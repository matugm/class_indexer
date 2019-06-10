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
      class_name = node.children[0].children[1].to_s

      if @current_class == "main"
        @current_class = class_name
      else
        @current_class << "::" + class_name
      end

      node.children.each { |c| process(c) }

      if @current_class.include?("::")
        @current_class.sub!("::" + class_name, "")
      else
        reset_class
      end
    end

    def on_module(node)
      module_name = node.children[0].children[1].to_s

      if @current_class == "main"
        @current_class = module_name
      else
        @current_class.prepend(module_name + "::")
      end

      node.children.each { |c| process(c) }

      @current_class.sub!(module_name, "")
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

    def on_begin(node)
      node.children.each { |c| process(c) }
    end
  end
end

