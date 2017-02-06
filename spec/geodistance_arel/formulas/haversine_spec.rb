# frozen_string_literal: true
require 'spec_helper'
require 'geodistance_arel/formulas/haversine'

RSpec.describe GeoDistanceArel::Formulas::Haversine do
  describe '#distance_field_in' do
    module FakeAdapter
      def multiply(*attrs); end

      def addition(*attrs); end
    end

    let(:lat_from_field) { 'lat_from_field' }
    let(:lng_from_field) { 'lng_from_field' }
    let(:model_class) { double(:model_class, arel_table: { lat_from_field => 'lat', lng_from_field => 'lng' }) }

    let(:lat_to) { 'foo' }
    let(:lng_to) { 'bar' }
    let(:multiplier) { 'multiplier' }

    subject { described_class.include(FakeAdapter).new(model_class, lat_from_field, lng_from_field) }

    it 'calls on multiply with distance_formula return and the given multiplier' do
      expect(subject).to receive(:distance_formula).with('foo', 'bar', 'lat', 'lng') { 'distance' }
      expect(subject).to receive(:multiply).with('distance', 'multiplier') { 'distance_field_in' }

      expect(subject.distance_field_in(lat_to, lng_to, multiplier)).to eq('distance_field_in')
    end
  end

  describe '#distance_formula' do
    module FakeAdapter
      def radians_of(attr); end

      def literal_of(attr); end

      def least_of(attr); end

      def acos_of(attr); end
    end

    let(:lat_to) { 'lat_to' }
    let(:lng_to) { 'lng_to' }
    let(:lat_from) { 'lat_from' }
    let(:lng_from) { 'lng_from' }

    subject { described_class.include(FakeAdapter).new('model_class', 'lat_from_field', 'lng_from_field') }

    it 'calls on acos_of from least_of from the distance_theta_formula' do
      expect(subject).to receive(:literal_of).with(lat_to) { 'literal_of_lat_to' }
      expect(subject).to receive(:literal_of).with(lng_to) { 'literal_of_lng_to' }

      expect(subject).to receive(:radians_of).with('literal_of_lat_to') { 'radians_of_literal_of_lat_to' }
      expect(subject).to receive(:radians_of).with('literal_of_lng_to') { 'radians_of_literal_of_lng_to' }

      expect(subject).to receive(:radians_of).with(lat_from) { 'radians_of_lat_to' }
      expect(subject).to receive(:radians_of).with(lng_from) { 'radians_of_lng_to' }

      expect(subject).to receive(:distance_tetha_formula).with(
        'radians_of_literal_of_lat_to',
        'radians_of_literal_of_lng_to',
        'radians_of_lat_to',
        'radians_of_lng_to'
      ) { 'distance_theta_formula' }
      expect(subject).to receive(:least_of).with('distance_theta_formula') { 'least_of' }
      expect(subject).to receive(:acos_of).with('least_of') { 'distance_formula' }

      expect(subject.distance_formula(lat_to, lng_to, lat_from, lng_from)).to eq('distance_formula')
    end
  end

  describe '#distance_tetha_formula' do
    module FakeAdapter
      def cos_of(attr); end

      def sin_of(attr); end

      def multiply(*attrs); end

      def addition(*attrs); end
    end

    let(:lat_to) { 'lat_to' }
    let(:lng_to) { 'lng_to' }
    let(:lat_from) { 'lat_from' }
    let(:lng_from) { 'lng_from' }

    subject { described_class.include(FakeAdapter).new('model_class', 'lat_from_field', 'lng_from_field') }

    it 'calls on addition with multiply of cosine and sines of lat and lng of origin and destination' do
      expect(subject).to receive(:cos_of).with(lng_to) { 'cos_of_lng_to' }
      expect(subject).to receive(:cos_of).with(lat_to) { 'cos_of_lat_to' }
      expect(subject).to receive(:cos_of).with(lng_from) { 'cos_of_lng_from' }
      expect(subject).to receive(:cos_of).with(lat_from) { 'cos_of_lat_from' }

      expect(subject).to receive(:cos_of).with(lat_to) { 'cos_of_lat_to' }
      expect(subject).to receive(:sin_of).with(lng_to) { 'sin_of_lng_to' }
      expect(subject).to receive(:cos_of).with(lat_from) { 'cos_of_lat_from' }
      expect(subject).to receive(:sin_of).with(lng_from) { 'sin_of_lng_from' }

      expect(subject).to receive(:sin_of).with(lat_to) { 'sin_of_lat_to' }
      expect(subject).to receive(:sin_of).with(lat_from) { 'sin_of_lat_from' }

      expect(subject).to receive(:multiply).with(
        'cos_of_lng_to',
        'cos_of_lat_to',
        'cos_of_lng_from',
        'cos_of_lat_from'
      ) { 'first_multiply' }

      expect(subject).to receive(:multiply).with(
        'cos_of_lat_to',
        'sin_of_lng_to',
        'cos_of_lat_from',
        'sin_of_lng_from'
      ) { 'second_multiply' }

      expect(subject).to receive(:multiply).with('sin_of_lat_to', 'sin_of_lat_from') { 'third_multiply' }

      expect(subject).to receive(:addition)
        .with('first_multiply', 'second_multiply', 'third_multiply') { 'distance_tetha_formula' }

      expect(subject.distance_tetha_formula(lat_to, lng_to, lat_from, lng_from)).to eq('distance_tetha_formula')
    end
  end
end
