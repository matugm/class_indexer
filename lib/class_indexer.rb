require 'class_indexer/version'

require 'parser/current'
require 'json'

module ClassIndexer
  class Processor < AST::Processor
    attr_reader :class_list

    def initialize
      reset_class

      @class_list = Hash.new { |h,k| h[k] = [] }
    end

    def reset_class
      @current_class = "main"
    end

    def add_method(method_name, line_num)
      @class_list[@current_class] << { name: method_name.to_s, line: line_num }
    end

    def on_class(node)
      line_num   = node.children[0].loc.line
      class_name = node.children[0].children[1]

      @current_class = class_name.to_s
      node.children.each { |c| process(c) }

      reset_class
    end

    # Instance methods
    def on_def(node)
      line_num    = node.loc.line
      method_name = node.children[0]

      add_method(method_name, line_num)
    end

    # Class methods
    def on_defs(node)
      line_num    = node.loc.line
      method_name = "self.#{node.children[1]}"

      add_method(method_name, line_num)
    end

    # Constant definition
    def on_const(node)
    end

    # Method call
    def on_send(node)
    end

    def on_begin(node)
      node.children.each { |c| process(c) }
    end

    def handler_missing(node)
    end
  end

  def self.process_file(file)
    exp = Parser::CurrentRuby.parse(File.read(file))
    ast = Processor.new

    ast.process(exp)

    ast.class_list
  rescue Parser::SyntaxError
    warn "Syntax Error found while parsing #{file}"
  end
end

