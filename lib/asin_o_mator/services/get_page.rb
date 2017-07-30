module  AsinOMator
  # A service class to handle the scraping of data
  class GetPage
    # extend the class with the `Callable` module to allow
    # initialization using #call
    extend Callable

    # Amazon seems to dislike the Mechanizer user-agent and returns a 503.
    # To emulate a browser the `user_agent_alias` is set to a browser.
    # The choice of browser user_agent is arbitrary
    USER_AGENT = 'Mac Safari'.freeze

    def initialize(asin:)
      raise AsinRequiredError unless asin
      @asin = asin
    end

    def call
      fetch_page_data
    # the outcome of the `.fetch_page_data` call can be unpredictable
    # hence the rescuing of `StandardError`
    rescue StandardError => exception
      # raise an error if the product page was not found
      raise ProductNotFoundError if exception.try(:response_code) == '404'

      # a `catch all` error for any expections raised by Mechanizer
      raise MechanizerError, exception
    end

    private

    # get the product data by intializing a Mechanize object, setting
    # the correct user agent, and passing the product url to the `#get` call
    # returns a  `Mechanize::Page` object
    def fetch_page_data
      mechanizer = Mechanize.new.tap { |m| m.user_agent_alias = USER_AGENT }
      mechanizer.get(ENV['PRODUCT_PATH'] + @asin)
    end
  end

  # Error raised when no product is returned for the given ASIN
  class ProductNotFoundError < StandardError
    def message
      'No product found for the supplied ASIN.'
    end
  end

  # A catch all error for Mechanizer failures
  class MechanizerError < StandardError
    def initialize(error)
      @error = error
    end

    def message
      "Mechanizer has raised an exception: #{@error.message}"
    end
  end
end
