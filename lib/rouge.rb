# -*- coding: utf-8 -*- #

# stdlib
require 'pathname'

# The containing module for Rouge
module Rouge
  class << self
    # Highlight some text with a given lexer and formatter.
    #
    # @example
    #   Rouge.highlight('@foo = 1', 'ruby', 'html')
    #   Rouge.highlight('var foo = 1;', 'js', 'terminal256')
    #
    #   # streaming - chunks become available as they are lexed
    #   Rouge.highlight(large_string, 'ruby', 'html') do |chunk|
    #     $stdout.print chunk
    #   end
    def highlight(text, lexer, formatter, &b)
      lexer = Lexer.find(lexer) unless lexer.respond_to? :lex
      raise "unknown lexer #{lexer}" unless lexer

      formatter = Formatter.find(formatter) unless formatter.respond_to? :format
      raise "unknown formatter #{formatter}" unless formatter

      formatter.format(lexer.lex(text), &b)
    end
  end
end

require_relative('rouge/version.rb')

require_relative('rouge/util.rb')

require_relative('rouge/text_analyzer.rb')
require_relative('rouge/token.rb')

require_relative('rouge/lexer.rb')
require_relative('rouge/regex_lexer.rb')
require_relative('rouge/template_lexer.rb')

Dir.glob(Pathname.new(__FILE__).dirname.join('rouge/lexers/*.rb')).each { |f| require_relative f }

require_relative('rouge/formatter.rb')
require_relative('rouge/formatters/html.rb')
require_relative('rouge/formatters/terminal256.rb')
require_relative('rouge/formatters/null.rb')

require_relative('rouge/theme.rb')
require_relative('rouge/themes/thankful_eyes.rb')
require_relative('rouge/themes/colorful.rb')
require_relative('rouge/themes/base16.rb')
require_relative('rouge/themes/github.rb')
require_relative('rouge/themes/monokai.rb')
require_relative('rouge/themes/molokai.rb')
require_relative('rouge/themes/monokai_sublime.rb')
