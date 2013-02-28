module Searchlogic
  module SearchExt
    module ChainedConditions
      class ScopeGenerator
        attr_accessor  :scope_conditions, :klass, :initial_scope
        def initialize(scope_conditions, klass)
          @scope_conditions = scope_conditions
          @klass = klass
          @initial_scope = starting_scope
        end

        def full_scope
          scope_conditions.inject(initial_scope) do |scope, (condition, value)| 
            create_scope(scope, condition, value)
          end
        end
        private
          def starting_scope
            first_conditions = scope_conditions.shift
            create_scope(klass, first_conditions[0], first_conditions[1])
          end

          def ordering?(condition)
            condition.to_s == "order"
          end

          def create_scope(scope, condition, value)
            if scope.searchlogic_scopes.include?(condition) && value
              ##What if scope takes an arguement of true?
              value == true ? scope.send(condition) : scope.send(condition, value)
            elsif ordering?(condition)
              scope.send(value)            
            else
              scope.send(condition, value)
            end          
          end
      end
    end
  end
end