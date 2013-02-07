module Searchlogic
  module Conditions
    class EndsWith < Condition
      def scope
        klass.where("#{table_name}.#{column_name} like ?", "%#{value}") if applicable?
      end

      private
        def value
          args.first
        end
        def applicable? 
          !(/^(#{klass.column_names.join("|")})_ends_with$/ =~ method_name).nil? 
        end
    end
  end
end