# Asin-O-Mator

Always wanted to Asin-O-Mate your app? Now you can! Say hello to the Asin-O-Mator.
<br\>
The Asin-O-Mator scrapes and parses product data for a given Amazon ASIN.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'asin_o_matic_ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install asin_o_matic_ruby

## Usage

The Asin-O-Mator expects and enviroment variable `PRODUCT_PATH` with the path to the product page.

For a product URL of `https://www.amazon.ca/gp/product/SOME_ASIN` the `PRODUCT_PATH` environment variable would be `https://www.amazon.ca/gp/product`.

To use simply initialize and instance of the Asin-O-Matic : `AsinOMator::Product.new(asin: 'SOMEASIN'`)

**`#page`**

Call `#page` to return the raw page data as a `Mechanize::Page` object.

**`#data`**

Call `#data` go retrieve the parsed product. The product data is returned as a `Hash` with keys for : `asin`, `title`, `review_count` and `price`


Example:

```ruby
  page = AsinOMator::Product.new(asin: 'SOME_ASIN').page
  product_data = AsinOMator::Product.new(asin: 'SOME_ASIN').data
```

#### Error Handeling

The Asin-O-Mator can raise the folling errors:

`AsinOMator::AsinRequiredError` : The `asin` provided is blank.

`AsinOMator::ProductNotFoundError`: No product was found for the provided `asin`.

`AsinOMator::MechanizerError`: The `Mechanize` gem, used for page scarping, returned a status code other than `200`, `301`, or `302`.


#### Notes
* The Asin-O-Matic :
  * Uses the [`Mechanize`](https://github.com/sparklemotion/mechanize) gem to scrape Amazon pages for a given ASIN.
  * Leverages the power of a data object using [`Virtus`](https://github.com/solnic/virtus) to extract product data from scraped page objects.
  * Is well tested with [`RSpec`](https://github.com/rspec/rspec-rails) request specs and uses [`VCR`](https://github.com/vcr/vcr) to test against recorded Amazon page responses. The first time the specs are executed the response will be recorded. If no recordring are present the first spec execution will be slower due to response recording.
