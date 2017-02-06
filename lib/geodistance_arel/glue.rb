# frozen_string_literal: true
require 'geodistance_arel/formulas'
require 'geodistance_arel/adapters'

module GeoDistanceArel
  module Glue
    attr_accessor :lat_column_name, :lng_column_name, :formula

    OPTION_SYMBOLS = [:lat_column_name, :lng_column_name].freeze

    def distance_field(lat_to, lng_to)
      formula.distance_field_in(lat_to, lng_to)
    end

    def act_as_distanceable(options = {})
      self.lat_column_name = options[:lat_column_name] || 'lat'
      self.lng_column_name = options[:lng_column_name] || 'lng'
      self.formula = GeoDistanceArel::Formulas::Haversine
                     .include(GeoDistanceArel::Adapters::PostgreSQL)
                     .new(self, lat_column_name, lng_column_name)
    end
  end
end
