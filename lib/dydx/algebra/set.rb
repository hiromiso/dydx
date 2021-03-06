require 'dydx/algebra/set/base'
require 'dydx/algebra/set/num'
require 'dydx/algebra/set/fixnum'
require 'dydx/algebra/set/float'
require 'dydx/algebra/set/symbol'
require 'dydx/algebra/set/e'
require 'dydx/algebra/set/pi'
require 'dydx/algebra/set/log'
require 'dydx/algebra/set/log2'
require 'dydx/algebra/set/log10'
require 'dydx/algebra/set/sin'
require 'dydx/algebra/set/cos'
require 'dydx/algebra/set/tan'

module Dydx
  module Algebra
    module Set
      def e0
        eval("$e0 ||= Num.new(0)")
      end

      def e1
        eval("$e1 ||= Num.new(1)")
      end
      def _(num)
        if num >= 0
          eval("$p#{num} ||= Num.new(num)")
        else
          eval("$n#{-1 * num} ||= Num.new(num)")
        end
      end

      def pi
        $pi ||= Pi.new
      end

      def e
        $e ||= E.new
      end

      def oo
        Float::INFINITY
      end

      def log(formula)
        if formula.multiplication?
          f, g = formula.f, formula.g
          log(f) + log(g)
        elsif formula.exponentiation?
          f, g = formula.f, formula.g
          g * log(f)
        elsif formula.is_1?
          e0
        elsif formula.is_a?(E)
          e1
        else
          Log.new(formula)
        end
      end

      def log2(formula)
        # TODO: refactor with log function.
        if formula.multiplication?
          f, g = formula.f, formula.g
          log2(f) + log2(g)
        elsif formula.exponentiation?
          f, g = formula.f, formula.g
          g * log2(f)
        elsif formula.is_1?
          e0
        elsif formula.is_a?(Num)
          (formula.n == 2) ? e1 : log2(formula.n)
        elsif formula == 2
          e1
        else
          Log2.new(formula)
        end
      end

      def log10(formula)
        # TODO: refactor with log function.
        if formula.multiplication?
          f, g = formula.f, formula.g
          log10(f) + log10(g)
        elsif formula.exponentiation?
          f, g = formula.f, formula.g
          g * log10(f)
        elsif formula.is_1?
          e0
        elsif formula.is_a?(Num)
          (formula.n == 10) ? e1 : log10(formula.n)
        elsif formula == 10
          e1
        else
          Log10.new(formula)
        end
      end

      def sin(x)
        multiplier = x.is_multiple_of(pi)
        if multiplier.is_a?(Num)
          e0
        else
          Sin.new(x)
        end
      end

      def cos(x)
        multiplier = x.is_multiple_of(pi)
        if multiplier.is_a?(Num) && multiplier.n % 2 == 0
          e1
        elsif multiplier.is_a?(Num) && multiplier.n % 2 == 1
          _(-1)
        else
          Cos.new(x)
        end
      end

      def tan(x)
        Tan.new(x)
      end
    end
  end
end
