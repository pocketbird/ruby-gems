module SCSSLint
  # Checks for misspelled properties.
  class Linter::PropertySpelling < Linter
    include LinterRegistry

    KNOWN_PROPERTIES = File.open(File.join(SCSS_LINT_DATA, 'properties.txt'))
                           .read
                           .split
                           .to_set

    def visit_root(_node)
      @extra_properties = config['extra_properties'].to_set
      yield # Continue linting children
    end

    def visit_prop(node)
      # Ignore properties with interpolation
      return if node.name.count > 1 || !node.name.first.is_a?(String)

      nested_properties = node.children.select { |child| child.is_a?(Sass::Tree::PropNode) }
      if nested_properties.any?
        # Treat nested properties specially, as they are a concatenation of the
        # parent with child property
        nested_properties.each do |nested_prop|
          check_property(nested_prop, node.name.join)
        end
      else
        check_property(node)
      end
    end

  private

    def check_property(node, prefix = nil) # rubocop:disable CyclomaticComplexity
      # Ignore properties with interpolation
      return if node.name.count > 1 || !node.name.first.is_a?(String)

      name = prefix ? "#{prefix}-" : ''
      name += node.name.join

      # Ignore vendor-prefixed properties
      return if name.start_with?('-')
      return if KNOWN_PROPERTIES.include?(name) ||
        @extra_properties.include?(name)

      add_lint(node, "Unknown property #{name}")
    end
  end
end
