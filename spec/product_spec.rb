require 'spec_helper'

RSpec.describe AsinOMator::Product do
  let(:asin) { 'B002QYW8LW' }
  let(:product) do
    { asin: 'B002QYW8LW',
      price: 9.99,
      review_count: 354,
      title: 'Baby Banana Bendable Training Toothbrush (Infant)' }
  end

  let(:klass) { described_class.new(asin: asin) }

  describe '#page' do
    it 'returns a Mechanize::Page object' do
      VCR.use_cassette('product_page') do
        expect(klass.page).to be_a(Mechanize::Page)
      end
    end
  end

  describe '#data' do
    it 'returns the correct page data' do
      VCR.use_cassette('product_page') do
        expect(klass.data).to match(product)
      end
    end
  end
end
