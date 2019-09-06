module Kernel
  def cache_result(&block)
    method_name = caller_locations.first.label
    instance_variable_name = "@#{method_name}".to_sym

    if instance_variable_defined?(instance_variable_name)
      instance_variable_get(instance_variable_name)
    else
      instance_variable_set(instance_variable_name, (lambda &block).call)
    end
  end
end
