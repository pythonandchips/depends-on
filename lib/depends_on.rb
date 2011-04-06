require "active_support/inflector"

module DependsOn
  module MacroMethods
    def depends_on *args
      self.instance_eval do
        args.each do |dependancy|
          obj = resolve_dependancy(dependancy)
          method_name = resolve_method_name(dependancy)
          create_method(method_name, obj)
        end
      end
    end

    private

    def resolve_dependancy dependancy
      return Object.const_get(dependancy.to_s.camelize).new if dependancy.class == Symbol
      return dependancy.values[0].call(self) if dependancy.class == Hash
    end

    def resolve_method_name dependancy
      return dependancy if dependancy.class == Symbol
      return dependancy.keys[0] if dependancy.class == Hash
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
