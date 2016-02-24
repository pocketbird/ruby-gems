require 'set'

module SCSSLint
  # Tracks which lines have been disabled for a given linter.
  class ControlCommentProcessor
    def initialize(linter)
      @disable_stack = []
      @disabled_lines = Set.new
      @linter = linter
    end

    # Filter lints given the comments that were processed in the document.
    #
    # @param lints [Array<SCSSLint::Lint>]
    def filter_lints(lints)
      lints.reject { |lint| @disabled_lines.include?(lint.location.line) }
    end

    # Executed before a node has been visited.
    #
    # @param node [Sass::Tree::Node]
    def before_node_visit(node)
      return unless command = extract_command(node)

      linters = command[:linters]
      return unless linters.include?('all') || linters.include?(@linter.name)

      process_command(command[:action], node)

      # Is the control comment the only thing on this line?
      return if node.is_a?(Sass::Tree::RuleNode) ||
                %r{^\s*(//|/\*)}.match(@linter.engine.lines[node.line - 1])

      # Otherwise, pop since we only want comment to apply to the single line
      pop_control_comment_stack(node)
    end

    # Executed after a node has been visited.
    #
    # @param node [Sass::Tree::Node]
    def after_node_visit(node)
      while @disable_stack.any? && @disable_stack.last.node_parent == node
        pop_control_comment_stack(node)
      end
    end

  private

    def extract_command(node)
      comment =
        case node
        when Sass::Tree::CommentNode
          node.value.first
        when Sass::Tree::RuleNode
          node.rule.select { |chunk| chunk.is_a?(String) }.join
        end

      return unless match = %r{
        (/|\*)\s* # Comment start marker
        scss-lint:
        (?<action>disable|enable)\s+
        (?<linters>.*?)
        \s*(?:\*/|\n) # Comment end marker or end of line
      }x.match(comment)

      {
        action: match[:action],
        linters: match[:linters].split(/\s*,\s*|\s+/),
      }
    end

    def process_command(command, node)
      case command
      when 'disable'
        @disable_stack << node
      when 'enable'
        pop_control_comment_stack(node)
      end
    end

    def pop_control_comment_stack(node)
      return unless comment_node = @disable_stack.pop

      start_line = comment_node.line
      if comment_node.class.node_name == :rule
        end_line = start_line
      elsif node.class.node_name == :root
        end_line = @linter.engine.lines.length
      else
        end_line = end_line(node)
      end

      @disabled_lines.merge(start_line..end_line)
    end

    # Find the deepest child that has a line number to which a lint might
    # apply (if it is a control comment enable node, it will be the line of
    # the comment itself).
    def end_line(node)
      child = node
      prev_child = node
      until [nil, prev_child].include?(child = last_child(child))
        prev_child = child
      end

      # Fall back to prev_child if last_child() returned nil (i.e. node had no
      # children with line numbers)
      (child || prev_child).line
    end

    # Gets the child of the node that resides on the lowest line in the file.
    #
    # This is necessary due to the fact that our monkey patching of the parse
    # tree's {#children} method does not return nodes sorted by their line
    # number.
    #
    # Returns `nil` if node has no children or no children with associated line
    # numbers.
    #
    # @param node [Sass::Tree::Node, Sass::Script::Tree::Node]
    # @return [Sass::Tree::Node, Sass::Script::Tree::Node]
    def last_child(node)
      last = node.children.inject(node) do |lowest, child|
        return lowest unless child.respond_to?(:line)
        lowest.line < child.line ? child : lowest
      end

      # In this case, none of the children have associated line numbers or the
      # node has no children at all, so return `nil`.
      return if last == node

      last
    end
  end
end
