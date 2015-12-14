class ChristmasTreeFormatter::ChristmasTree
  VT100_CODES = {
    black:   "30",
    red:     "31",
    green:   "32",
    yellow:  "33",
    blue:    "34",
    magenta: "35",
    cyan:    "36",
    white:   "37",
    brown:   "38;5;52",

    bold:    "1",
    blink:   "5",
  }

  def initialize(width, output: $stdout)
    @output = $stdout
    @width = width

    @row = 0
    @column = 0
  end

  attr_reader :width
  attr_reader :column
  attr_reader :row

  def print(symbol, color: :green, blink: false)
    if @row == 0 and @column == 0
      @column = start_column_for_row
      @output.print(" " * @column)
    end

    symbol = escape(symbol, :blink) if blink
    @output.print escape(symbol, color)
    @column += 1

    if @column >= end_column_for_row
      @row += 1
      @output.print "\n"

      @column = start_column_for_row
      @output.print " " * @column
    end
  end

  def finalize
    print "•", color: :white until @column == start_column_for_row

    @output.print " " * ((end_column_for_row - @column) / 2)
    @output.print escape("H", :brown)
  end

  private

  def start_column_for_row
    [@width/2 - @row, 0].max
  end

  def end_column_for_row
    middle = @row > 0 ? 1 : 0
    [@width/2 + @row + middle, @width].min
  end

  def escape(message, code)
    code = VT100_CODES[code] || code
    "\e[#{code}m#{message}\e[0m"
  end
end
