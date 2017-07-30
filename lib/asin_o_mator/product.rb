module AsinOMator
  # Class representing the product for a given ASIN
  class Product
    def initialize(asin:)
      @asin = asin
      validate! # validate that the `@asin` variable is set
    end

    # set and return the `@page` variable using the `GetPage` service class
    def page
      @page ||= GetPage.call(asin: @asin)
    end

    # set the `@data` variable using the `ProductData#data` method
    def data
      @data ||= ProductData.new(asin: @asin, page: page).data
    end

    private

    # validate that the `@asin` variable is set
    def validate!
      raise AsinRequiredError if @asin.to_s.empty?
    end
  end

  # Error raised when no ASIN is supplied
  class AsinRequiredError < StandardError
    def message
      "The 'asin' parameter is required."
    end
  end
end
