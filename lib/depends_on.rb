require "active_support/inflector"

module DependsOn
  module MacroMethods
    def depends_on *args
      self.instance_eval do
        args.each do |dependancy|
          obj = resolve_dependancy(dependancy)
        end
      end
    end

    private

    def resolve_dependancy dependancy
      if dependancy.class == Symbol
        obj = Object.const_get(dependancy.to_s.camelize).new
        return create_method dependancy, obj
      end
      if dependancy.class == Hash
        dependancy.each_pair do |pair|
          obj = pair[1].call(self)
          create_method(pair[0], obj)
        end
      end
    end

    def create_method method_name, dependancy
      define_method method_name do
        variable = self.instance_variable_get(:"@#{method_name}")
        if variable.nil?
          self.instance_variable_set(:"@#{method_name.to_s}", dependancy)
        end
        self.instance_variable_get(:"@#{method_name}")
      end
    end
  end
end

Class.class_eval do
  include DependsOn::MacroMethods
end
