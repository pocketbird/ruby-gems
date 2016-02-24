require 'spec_helper'

describe SCSSLint::Linter::SingleLinePerSelector do
  context 'when rule has one selector' do
    let(:scss) { <<-SCSS }
      p {
      }
    SCSS

    it { should_not report_lint }
  end

  context 'when rule has one selector on each line' do
    let(:scss) { <<-SCSS }
      p,
      a {
      }
    SCSS

    it { should_not report_lint }
  end

  context 'when rule contains multiple selectors on the same line' do
    let(:scss) { <<-SCSS }
      .first,
      .second,
      .third, .fourth,
      .fifth {
      }
    SCSS

    it { should report_lint line: 3 }
  end

  context 'when commas are not at the end of the line' do
    let(:scss) { <<-SCSS }
      .foo
      , .bar {
      }
    SCSS

    it { should report_lint }
  end

  context 'when commas are on their own line' do
    let(:scss) { <<-SCSS }
      .foo
      ,
      .bar {
      }
    SCSS

    it { should report_lint }
  end

  context 'when nested rule contains multiple selectors on the same line' do
    let(:scss) { <<-SCSS }
      #foo {
        .first,
        .second,
        .third, .fourth,
        .fifth {
        }
      }
    SCSS

    it { should report_lint line: 4 }
  end

  context 'when rule contains interpolated selectors' do
    let(:scss) { <<-SCSS }
      .first,
      \#{interpolated-selector}.thing,
      .third {
      }
    SCSS

    it { should_not report_lint }
  end

  context 'when rule contains an interpolated selector not on its own line' do
    let(:scss) { <<-SCSS }
      .first,
      .second, \#{$interpolated-selector}.thing,
      .fourth {
      }
    SCSS

    it { should_not report_lint }
  end

  context 'when rule contains an inline comment' do
    let(:scss) { <<-SCSS }
      .first,  /* A comment */
      .second, // Another comment
      .third {
      }
    SCSS

    it { should_not report_lint }
  end

  context 'when interpolation contains a comma' do
    let(:scss) { <<-SCSS }
      .my-\#{function(1, 2)}-selector .nested {
      }
    SCSS

    it { should_not report_lint }
  end

  context 'when selector contains an interpolated string' do
    let(:scss) { <<-SCSS }
      div,
      \#{$selector},
      p {}
    SCSS

    it { should_not report_lint }
  end

  context 'when a function is used in the selector' do
    let(:scss) { <<-SCSS }
      \#{function()} {
      }
    SCSS

    it { should_not report_lint }
  end
end
