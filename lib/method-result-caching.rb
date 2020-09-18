class Object
  class << self
    def cache_result_for(method_name)
      new_method_name = "uncached_original_#{method_name}".to_sym
      alias_method(new_method_name, method_name)

      define_method method_name do
        cache_result(method_name: method_name) { send(new_method_name) }
      end
    end
  end

  def cache_result(method_name: nil, &block)
    method_name ||= caller_locations.first.label

    # REFACTOR: repeated code
    instance_variable_name = "@#{method_name}".gsub('?', 'qmark').to_sym

    if instance_variable_defined?(instance_variable_name)
      instance_variable_get(instance_variable_name)
    else
      instance_variable_set(instance_variable_name, (lambda &block).call)
    end
  end

  def clear_cached_result_for!(method_name)
    # REFACTOR: repeated code
    instance_variable_name = "@#{method_name}".gsub('?', 'qmark').to_sym

    remove_instance_variable(instance_variable_name)
  end
end
