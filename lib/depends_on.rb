require "active_support/inflector"

module DependsOn
  module MacroMethods
    def depends_on *args

      self.instance_eval do
        args.each do |dependancy|
          define_method dependancy do
            variable = self.instance_variable_get(:"@#{dependancy}")
            if variable.nil?
              self.instance_variable_set(:"@#{dependancy.to_s}", Object.const_get(dependancy.to_s.camelize).new)
            end
            self.instance_variable_get(:"@#{dependancy}")
          end
        end
      end

    end
  end
end

Class.class_eval do
  include DependsOn::MacroMethods
end
