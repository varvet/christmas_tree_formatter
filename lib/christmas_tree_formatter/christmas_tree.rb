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

  def print(symbol, *escapes)
    if @column == 0 and @column != start_column_for_row
      output " " until @column == start_column_for_row
    end

    output escape(symbol, *escapes)
    output "\n" if @column >= end_column_for_row
  end

  def star
    print '⭒', :yellow, :blink
  end

  def finalize
    print "•", :white until @column == start_column_for_row

    center = ((end_column_for_row - @column) / 2)
    output " " until @column == center
    output escape("H", :brown)
  end

  private

  def output(character)
    if character["\n"]
      @output.print character
      @row += 1
      @column = 0
    else
      @output.print character
      @column += 1
    end
  end

  def start_column_for_row
    [@width/2 - @row, 0].max
  end

  def end_column_for_row
    middle = @row > 0 ? 1 : 0
    [@width/2 + @row + middle, @width].min
  end

  def escape(message, *codes)
    codes.reduce(message) do |message, code|
      code = VT100_CODES.fetch(code) if code.is_a?(Symbol)
      "\e[#{code}m#{message}\e[0m"
    end
  end
end
