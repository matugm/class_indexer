require 'parser/current'
require 'json'

require 'class_indexer/version'
require 'class_indexer/processor'

module ClassIndexer
  def self.process_file(file)
    exp = Parser::CurrentRuby.parse(File.read(file))
    ast = Processor.new

    ast.process(exp)

    ast.class_list
  rescue Parser::SyntaxError
    warn "Syntax Error found while parsing #{file}"
  end
end

