module AsinOMator
  # Object that extracts and holds product data from a Mechanize::Page object
  class ProductData
    include Virtus.model

    # user virus model to initialize object attributes with required
    # default values
    attribute :page, Mechanize::Page # passed on initialization
    attribute :asin, String # passed on initialization
    attribute :title, String, default: :parse_title
    attribute :review_count, Integer, default: :parse_review_count
    attribute :price, Float, default: :parse_price

    # returns all the object attributes except for the `page` attribute
    # containing the `Mechanize::Page` object
    def data
      attributes.tap { |attr| attr.delete(:page) }
    end

    private

    # get the product title from the `#productTitle` page DOM id and strip
    # whitespace
    def parse_title
      page.at('#productTitle').text.strip
    end

    # get the product review count from the `#acrCustomerReviewText` page DOM id
    # and return only the digits of the `116 customer reviews` string
    def parse_review_count
      page.at('#acrCustomerReviewText').text.match(/\d+/)[0]
    end

    # get the product price from either the #priceblock_ourprice` or
    # `priceblock_dealprice` DOM id's and returns only the digits of
    # the `CDN$ 6.24` string
    def parse_price
      price = [
        page.at('#priceblock_ourprice'),
        page.at('#priceblock_dealprice')
      ].compact.first

      price.text.match(/(\d+[,.]\d+)/)[0]
    end
  end
end
