require 'rest-client'
require 'nokogiri'

module Parsers
  class Uaserial
    attr_reader :html, :doc

    def initialize(url)
      @url = url
    end

    def get_serial
      begin
        response = RestClient.get(@url)
        @html = response.body
        @doc = Nokogiri::HTML(@html)

        puts payload
      rescue RestClient::ExceptionWithResponse => e
        raise "HTTP Request failed: #{e.response}"
      rescue StandardError => e
        raise "An error occurred: #{e.message}"
      end
    end

    private

    def payload
      {
        uaserial_id: extract_serial_id,
        title: extract_serial_name,
        url: @url,
        poster_url: extract_og_image,
        imdb: extract_imdb_value
      }
    end

    def extract_serial_id
      element = doc.at('[data-serial-id]')
      element ? element['data-serial-id'] : nil
    end

    def extract_serial_name
      span = doc.at('h1[class="title"]')
      span ? span.text.strip : nil
    end

    def extract_og_image
      meta = doc.at('meta[property="og:image"]')
      meta ? meta['content'] : nil
    end

    def extract_imdb_value
      imdb_icon_div = doc.at('div.icon--mask--imdb')
      imdb_value_div = imdb_icon_div&.xpath('following-sibling::div')&.first
      imdb_value_div ? imdb_value_div.text.strip : nil
    end
  end
end