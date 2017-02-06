# frozen_string_literal: true
require 'arel'
require 'active_support/core_ext/array/grouping'

module GeoDistanceArel
  module Adapters
    module PostgreSQL # nodoc
      def literal_of(attr)
        Arel::Nodes::SqlLiteral.new(attr.to_s)
      end

      def radians_of(attr)
        Arel::Nodes::NamedFunction.new('RADIANS', [attr])
      end

      def cos_of(attr)
        Arel::Nodes::NamedFunction.new('COS', [attr])
      end

      def sin_of(attr)
        Arel::Nodes::NamedFunction.new('SIN', [attr])
      end

      def acos_of(attr)
        Arel::Nodes::NamedFunction.new('ACOS', [attr])
      end

      def least_of(attr)
        Arel::Nodes::NamedFunction.new('least', [1, attr])
      end

      def multiply(*attrs)
        Arel::Nodes::Multiplication.new(
          *attrs.in_groups(2, false).map do |group|
            if group.size > 1
              multiply(*group)
            else
              group
            end
          end.flatten
        )
      end

      def addition(*attrs)
        Arel::Nodes::Addition.new(
          *attrs.in_groups(2, false).map do |group|
            if group.size > 1
              addition(*group)
            else
              group
            end
          end.flatten
        )
      end
    end
  end
end
