module Searchlogic
  module SearchExt
    module MethodMissing
      private
        # no implicit equals/column naemes
        def method_missing(method, *args, &block)
          scope_name = method.to_s.gsub(/=$/, '').to_sym
          if method.to_s == "delete"
            delete_condition(args)
          elsif valid_accessor?(scope_name, method)
            read_or_write_condition(scope_name, args)
          else
            scope = klass
            conditions.each {}
            delegate(method, args, &block)
          end
        end

        def valid_accessor?(scope_name, method)
          authorized_scope?(scope_name) || associated_column?(scope_name)
        end

    end
  end
end