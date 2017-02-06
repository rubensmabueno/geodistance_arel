# frozen_string_literal: true

module GeoDistanceArel
  module Formulas
    class Haversine
      def initialize(model_class, lat_from_field = :lat, lng_from_field = :lng)
        @model_class = model_class
        @lat_from_field = lat_from_field
        @lng_from_field = lng_from_field
      end

      def distance_field_in(lat_to, lng_to, multiplier = 6371)
        multiply(
          distance_formula(
            lat_to,
            lng_to,
            @model_class.arel_table[@lat_from_field],
            @model_class.arel_table[@lng_from_field]
          ),
          multiplier
        )
      end

      def distance_formula(lat_to, lng_to, lat_from, lng_from)
        acos_of(
          least_of(
            distance_tetha_formula(
              radians_of(literal_of(lat_to)),
              radians_of(literal_of(lng_to)),
              radians_of(lat_from),
              radians_of(lng_from)
            )
          )
        )
      end

      def distance_tetha_formula(lat_to, lng_to, lat_from, lng_from)
        addition(
          multiply(
            cos_of(lng_to), cos_of(lat_to), cos_of(lng_from), cos_of(lat_from)
          ),
          multiply(
            cos_of(lat_to), sin_of(lng_to), cos_of(lat_from), sin_of(lng_from)
          ),
          multiply(sin_of(lat_to), sin_of(lat_from))
        )
      end
    end
  end
end
