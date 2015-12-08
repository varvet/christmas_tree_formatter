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
    @width += 2 until (@width * 2) >= @example_count || @width >= max_width
    @row    = 0
    @column = start_column_for_row

    output.print (" " * @column)
  end

  def example_passed(_notification)
    print_current("•", :success)
  end

  def example_pending(_notification)
    print_current(blink("•"), :pending)
  end

  def example_failed(_notification)
    print_current("•", :failure)
  end

  def stop(_notification)
    print_current("•", :white) until @column == start_column_for_row
    extra_space = " " * ((end_column_for_row - @column) / 2)
    output.print extra_space
    base = "H"
    output.print "\e[38;5;52m#{base}\e[0m"
  end

  private

  def print_current(symbol, type)
    output.print ConsoleCodes.wrap(symbol, type)
    @column += 1
    if @column >= end_column_for_row
      @row += 1
      @column = start_column_for_row
      output.print "\n" + (" " * @column)
    end
  end

  def start_column_for_row
    [@width/2 - @row, 0].max
  end

  def end_column_for_row
    middle = @row > 0 ? 1 : 0
    [@width/2 + @row + middle, @width].min
  end

  def blink(text)
    "\e[5m#{text}\e[0m"
  end
end

