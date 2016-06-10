# encoding: UTF-8

require "christmas_tree_formatter/christmas_tree"

module Minitest
  def self.plugin_christmas_tree_formatter_init(options)
    Minitest.reporter.reporters.clear
    self.reporter << ChristmasTreeFormatter.new(options[:io], options.merge(total_count: total_count(options)))
  end

  def self.plugin_christmas_tree_formatter_options(opts, options)
  end

  class ChristmasTreeFormatter < Minitest::SummaryReporter
    def start
      super

      max_width = 80
      @width = 1
      @width += 2 until (((@width / 2) * @width) / 2) >= total_count || @width >= max_width

      @tree = ::ChristmasTreeFormatter::ChristmasTree.new(@width, output: io)
      @tree.star
    end

    def record(result)
      super

      if result.skipped?
        @tree.print "•", :yellow, :blink
      elsif result.passed?
        @tree.print "•", :green
      else
        @tree.print "•", :red
      end
    end

    def report
      @tree.finalize

      super
    end

    def total_count
      options[:total_count]
    end
  end

  private

  # stolen from minitest self.run
  def self.total_count(options)
    filter = options[:filter] || '/./'
    filter = Regexp.new $1 if filter =~ /\/(.*)\//

    Minitest::Runnable.runnables.map(&:runnable_methods).flatten.find_all { |m|
      filter === m || filter === "#{self}##{m}"
    }.size
  end
end
