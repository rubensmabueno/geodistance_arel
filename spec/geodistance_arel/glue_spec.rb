require 'spec_helper'
require 'geodistance_arel/glue'

RSpec.describe GeoDistanceArel::Glue do
  describe '.act_as_distanceable' do
    class SampleClass
      extend GeoDistanceArel::Glue

      act_as_distanceable lat_column_name: 'foo',
                          lng_column_name: 'bar'
    end

    subject { SampleClass }

    it 'assigns lat_column_name, lng_column_name and instantiate
        haversine_formula' do
      expect(subject.lat_column_name).to eq('foo')
      expect(subject.lng_column_name).to eq('bar')
      expect(subject.formula).to be_an_instance_of(
        GeoDistanceArel::Formulas::Haversine
      )
    end
  end

  describe '.distance_field' do
    class SampleClass
      extend GeoDistanceArel::Glue
    end

    subject { SampleClass }

    let(:lat) { 'lat' }
    let(:lng) { 'lng' }

    it 'calls on distance_field_in of formula' do
      formula = double(:formula)

      expect(subject).to receive(:formula) { formula }
      expect(formula).to receive(:distance_field_in).with(lat, lng) { 'foo' }

      subject.distance_field(lat, lng)
    end
  end
end
