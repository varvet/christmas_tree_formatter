# encoding: UTF-8

require "rspec/core"
require "rspec/core/formatters/base_text_formatter"

class ChristmasTreeFormatter < RSpec::Core::Formatters::BaseTextFormatter
  VERSION = "0.1.0"

  include RSpec::Core::Formatters

  RSpec::Core::Formatters.register self, :start, :example_passed, :example_pending, :example_failed, :stop

  def start(_notification)
    super

    max_width = 80
    @width = 1
    @width += 2 until (((@width / 2) * @width) / 2) >= @example_count || @width >= max_width

    @tree = ChristmasTree.new(@width, output: output)
    @tree.star
  end

  def example_passed(_notification)
    @tree.print "•", :green
  end

  def example_pending(_notification)
    @tree.print "•", :yellow, :blink
  end

  def example_failed(_notification)
    @tree.print "•", :red
  end

  def stop(_notification)
    @tree.finalize
  end
end

require "christmas_tree_formatter/christmas_tree"
