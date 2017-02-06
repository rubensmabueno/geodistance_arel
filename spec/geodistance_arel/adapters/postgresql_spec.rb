# frozen_string_literal: true
require 'spec_helper'
require 'geodistance_arel/adapters/postgresql'

RSpec.describe GeoDistanceArel::Adapters::PostgreSQL do
  subject { Class.new.tap { |klass| klass.include(described_class) }.new }

  describe '#literal_of' do
    let(:attr) { 'foo' }

    it 'instantiate a sql_literal with a string' do
      expect(Arel::Nodes::SqlLiteral).to receive(:new).with(attr) { 'literal_of' }

      expect(subject.literal_of(attr)).to eq('literal_of')
    end
  end

  describe '#radians_of' do
    let(:attr) { 'foo' }

    it 'instantiate a Arel::Nodes::NamedFunction with a radians and the given attribute wrapped by array' do
      expect(Arel::Nodes::NamedFunction).to receive(:new).with('RADIANS', [attr]) { 'radians_of' }

      expect(subject.radians_of(attr)).to eq('radians_of')
    end
  end

  describe '#cos_of' do
    let(:attr) { 'foo' }

    it 'instantiate a Arel::Nodes::NamedFunction with a cosine and the given attribute wrapped by array' do
      expect(Arel::Nodes::NamedFunction).to receive(:new).with('COS', [attr]) { 'cos_of' }

      expect(subject.cos_of(attr)).to eq('cos_of')
    end
  end

  describe '#sin_of' do
    let(:attr) { 'foo' }

    it 'instantiate a Arel::Nodes::NamedFunction with a sine and the given attribute wrapped by array' do
      expect(Arel::Nodes::NamedFunction).to receive(:new).with('SIN', [attr]) { 'sin_of' }

      expect(subject.sin_of(attr)).to eq('sin_of')
    end
  end

  describe '#acos_of' do
    let(:attr) { 'foo' }

    it 'instantiate a Arel::Nodes::NamedFunction with a inverse consine and the given attribute wrapped by array' do
      expect(Arel::Nodes::NamedFunction).to receive(:new).with('ACOS', [attr]) { 'acos_of' }

      expect(subject.acos_of(attr)).to eq('acos_of')
    end
  end

  describe '#least_of' do
    let(:attr) { 'foo' }

    it 'instantiate a Arel::Nodes::NamedFunction with a least and the given attribute wrapped by array and 1' do
      expect(Arel::Nodes::NamedFunction).to receive(:new).with('least', [1, attr]) { 'least_of' }

      expect(subject.least_of(attr)).to eq('least_of')
    end
  end

  describe '#addition' do
    context 'with two attributes' do
      let(:attrs) { [1, 2] }

      it 'wrap attrs by Arel::Nodes::Addition' do
        expect(Arel::Nodes::Addition).to receive(:new).with(1, 2) { 'addition' }

        expect(subject.addition(*attrs)).to eq('addition')
      end
    end

    context 'with more than two attributes' do
      let(:attrs) { [1, 2, 3] }

      it 'wrap attrs nested in groups of two by Arel::Nodes::Addition' do
        first_group = double(:arel_addition)

        expect(Arel::Nodes::Addition).to receive(:new).with(1, 2) { first_group }
        expect(Arel::Nodes::Addition).to receive(:new).with(first_group, 3) { 'addition' }

        expect(subject.addition(*attrs)).to eq('addition')
      end
    end
  end

  describe '#multiply' do
    context 'with two attributes' do
      let(:attrs) { [1, 2] }

      it 'wrap attrs by Arel::Nodes::Multiplication' do
        expect(Arel::Nodes::Multiplication).to receive(:new).with(1, 2) { 'multiply' }

        expect(subject.multiply(*attrs)).to eq('multiply')
      end
    end

    context 'with more than two attributes' do
      let(:attrs) { [1, 2, 3] }

      it 'wrap attrs nested in groups of two by Arel::Nodes::Multiplication' do
        first_group = double(:arel_multiply)

        expect(Arel::Nodes::Multiplication).to receive(:new).with(1, 2) { first_group }
        expect(Arel::Nodes::Multiplication).to receive(:new).with(first_group, 3) { 'multiply' }

        expect(subject.multiply(*attrs)).to eq('multiply')
      end
    end
  end
end
