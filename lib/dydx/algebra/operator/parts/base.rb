module Dydx
  module Algebra
    module Operator
      module Parts
        module Base
          %w(+ - * / ^).each do |operator|
            define_method(operator) do |x|
              ::Algebra::Formula.new(self, x, operator.to_sym)
            end
          end
        end
      end
    end
  end
end
