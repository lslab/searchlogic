module Searchlogic
  module Conditions
    class Joins < Condition
      
      def scope
        recursive_joins if applicable?
      end

      private
        def recursive_joins
          klass_in_method, method = match_associated_model_in_method(method_name)[1, 2]
          if match_associated_model_in_method(method)
            continue_joins(klass_in_method, method)
          else
            calculate_result(klass_in_method, method)
          end
        end

        def continue_joins(klass_in_method, method)
          join_klass = klass.joins(klass_in_method.to_sym)
          join_klass.send(method, value)
        end

        def calculate_result(klass_in_method, method)
          join_klass = klass_in_method.singularize.camelize.constantize
          values = join_klass.send(method, value).where_values.first
          klass.joins(klass_in_method.to_sym).where(values).uniq
        end


        def value
          args.first
        end

        def applicable?
          !( match_associated_model_in_method(method_name)).nil?
        end

        def match_associated_model_in_method(method_name)
            associated_models = klass.reflect_on_all_associations.map { |a| a.name }
            /(^#{associated_models.join("|")})_(.*)/.match(method_name)
        end
    end
  end
end