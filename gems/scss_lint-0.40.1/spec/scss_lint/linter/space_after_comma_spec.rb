require 'spec_helper'

describe SCSSLint::Linter::SpaceAfterComma do
  context 'in a mixin declaration' do
    context 'where spaces do not follow commas' do
      let(:scss) { <<-SCSS }
        @mixin mixin($arg1,$arg2,$kwarg1: 'default',$kwarg2: 'default') {
        }
      SCSS

      it { should report_lint count: 3 }
    end

    context 'where spaces follow commas' do
      let(:scss) { <<-SCSS }
        @mixin mixin($arg1, $arg2, $kwarg1: 'default', $kwarg2: 'default') {
        }
      SCSS

      it { should_not report_lint }
    end

    context 'where spaces surround commas' do
      let(:scss) { <<-SCSS }
        @mixin mixin($arg1 , $arg2 , $kwarg1: 'default' , $kwarg2: 'default') {
        }
      SCSS

      it { should_not report_lint }
    end

    context 'where commas are followed by a newline' do
      let(:scss) { <<-SCSS }
        @mixin mixin($arg1,
                     $arg2,
                     $kwarg1: 'default',
                     $kwarg2: 'default') {
        }
      SCSS

      it { should_not report_lint }
    end

    context 'definining a variable argument' do
      context 'where spaces do not follow commas' do
        let(:scss) { <<-SCSS }
          @mixin mixin($arg,$args...) {
          }
        SCSS

        it { should report_lint count: 1 }
      end

      context 'where spaces follow commas' do
        let(:scss) { <<-SCSS }
          @mixin mixin($arg, $args...) {
          }
        SCSS

        it { should_not report_lint }
      end

      context 'where spaces surround commas' do
        let(:scss) { <<-SCSS }
          @mixin mixin($arg , $args...) {
          }
        SCSS

        it { should_not report_lint }
      end

      context 'where commas are followed by a newline' do
        let(:scss) { <<-SCSS }
          @mixin mixin($arg,
                       $args...) {
          }
        SCSS

        it { should_not report_lint }
      end
    end
  end

  context 'in a mixin inclusion' do
    context 'where spaces do not follow commas' do
      let(:scss) { <<-SCSS }
        p {
          @include mixin(1,2,3,$args...,$kwarg1: 4,$kwarg2: 5,$kwargs...);
        }
      SCSS

      it { should report_lint count: 6 }
    end

    context 'where spaces follow commas' do
      let(:scss) { <<-SCSS }
        p {
          @include mixin(1, 2, 3, $args..., $kwarg1: 4, $kwarg2: 5, $kwargs...);
        }
      SCSS

      it { should_not report_lint }
    end

    context 'where spaces surround commas' do
      let(:scss) { <<-SCSS }
        p {
          @include mixin(1 , 2 , 3 , $args... , $kwarg1: 4 , $kwarg2: 5 , $kwargs...);
        }
      SCSS

      it { should_not report_lint }
    end

    context 'where commas are followed by a newline' do
      let(:scss) { <<-SCSS }
        p {
          @include mixin(1,
                         2,
                         3,
                         $args...,
                         $kwarg1: 4,
                         $kwarg2: 5,
                         $kwargs...);
        }
      SCSS

      it { should_not report_lint }
    end
  end

  context 'in a function declaration' do
    context 'where spaces do not follow commas' do
      let(:scss) { <<-SCSS }
        @function func($arg1,$arg2,$kwarg1: 'default',$kwarg2: 'default') {
        }
      SCSS

      it { should report_lint count: 3 }
    end

    context 'where spaces follow commas' do
      let(:scss) { <<-SCSS }
        @function func($arg1, $arg2, $kwarg1: 'default', $kwarg2: 'default') {
        }
      SCSS

      it { should_not report_lint }
    end

    context 'where spaces surround commas' do
      let(:scss) { <<-SCSS }
        @function func($arg1 , $arg2 , $kwarg1: 'default' , $kwarg2: 'default') {
        }
      SCSS

      it { should_not report_lint }
    end

    context 'where commas are followed by a newline' do
      let(:scss) { <<-SCSS }
        @function func($arg1,
                       $arg2,
                       $kwarg1: 'default',
                       $kwarg2: 'default') {
        }
      SCSS

      it { should_not report_lint }
    end

    context 'definining a variable argument' do
      context 'where spaces do not follow commas' do
        let(:scss) { <<-SCSS }
          @function func($arg,$args...) {
          }
        SCSS

        it { should report_lint count: 1 }
      end

      context 'where spaces follow commas' do
        let(:scss) { <<-SCSS }
          @function func($arg, $args...) {
          }
        SCSS

        it { should_not report_lint }
      end

      context 'where spaces surround commas' do
        let(:scss) { <<-SCSS }
          @function func($arg , $args...) {
          }
        SCSS

        it { should_not report_lint }
      end

      context 'where commas are followed by a newline' do
        let(:scss) { <<-SCSS }
          @function func($arg,
                         $args...) {
          }
        SCSS

        it { should_not report_lint }
      end
    end
  end

  context 'in a function invocation' do
    context 'where spaces do not follow commas' do
      let(:scss) { <<-SCSS }
        p {
          margin: func(1,2,3,$args...,$kwarg1: 4,$kwarg2: 5,$kwargs...);
        }
      SCSS

      it { should report_lint count: 6 }
    end

    context 'where spaces follow commas' do
      let(:scss) { <<-SCSS }
        p {
          margin: func(1, 2, 3, $args..., $kwarg1: 4, $kwarg2: 5, $kwargs...);
        }
      SCSS

      it { should_not report_lint }
    end

    context 'where spaces surround commas' do
      let(:scss) { <<-SCSS }
        p {
          margin: func(1 , 2 , 3 , $args... , $kwarg1: 4 , $kwarg2: 5 , $kwargs...);
        }
      SCSS

      it { should_not report_lint }
    end

    context 'where commas are followed by a newline' do
      let(:scss) { <<-SCSS }
        p {
          margin: func(1,
                       2,
                       3,
                       $args...,
                       $kwarg1: 4,
                       $kwarg2: 5,
                       $kwargs...);
        }
      SCSS

      it { should_not report_lint }
    end
  end

  context 'in a comma-separated literal list' do
    context 'where spaces do not follow commas' do
      let(:scss) { <<-SCSS }
        p {
          property: $a,$b,$c,$d;
        }
      SCSS

      it { should report_lint count: 3 }
    end

    context 'where spaces follow commas' do
      let(:scss) { <<-SCSS }
        p {
          property: $a, $b, $c, $d;
        }
      SCSS

      it { should_not report_lint }
    end

    context 'where spaces surround commas' do
      let(:scss) { <<-SCSS }
        p {
          property: $a , $b , $c , $d;
        }
      SCSS

      it { should_not report_lint }
    end

    context 'where commas are followed by a newline' do
      let(:scss) { <<-SCSS }
        p {
          property: $a,
                    $b,
                    $c,
                    $d;
        }
      SCSS

      it { should_not report_lint }
    end

    context 'when commas are followed by a space and a newline' do
      let(:scss) { <<-SCSS }
        p {
          property: $a,\s
                    $b;
        }
      SCSS

      it { should_not report_lint }
    end
  end

  context 'when declaring list variables' do
    context 'and one argument does not have a trailing comma' do
      let(:scss) { <<-SCSS }
        $z-list: (
          (
            name1
          ),
          (
            name2,
          )
        );
      SCSS

      it { should_not report_lint }
    end
  end
end
