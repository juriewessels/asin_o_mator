module AsinOMator
  class Product
    def initialize(asin:)
      @asin = asin
      validate!
    end

    def page
      @page ||= GetPage.call(asin: @asin)
    end

    def data
      @data ||= ProductData.new(asin: @asin, page: page).model_attributes
    end

    private

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
