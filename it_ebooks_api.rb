require "httparty"
require "uri"

module Itebooks
  class Book
    # include HTTParty module so I can use its methods without referring to the HTTParty namespace all the time
    include HTTParty

    base_uri 'http://it-ebooks-api.info/v1/'

    def initialize attrs
      attrs.each do |name, val|
        # make all keys lowercase so they resemble class properties
        lowercase_name = name.downcase
        # dynamically generate instance variable on Book instance for every key and assign respective value to it
        instance_variable_set "@#{lowercase_name}", val
        # define getter method for every key in the response hash
        define_singleton_method(lowercase_name) {instance_variable_get "@#{lowercase_name}"}
      end
    end

    def self.search(query)
      # encode query in case the query contains whitespace or special characters
      encoded_query = URI.encode(query)
      #send the actual request to the it-ebooks-api
      response = get('/search/'+encoded_query)
      # if no books were found for the query, let the user know!
      if response.parsed_response['Total'] == "0" 
        puts "No resulsts for: #{query}" 
      # otherwise go over every book in the response and turn it into a Book instance
      else
        response['Books'].map { |b| self.new b }
      end
    end

    def self.find(id)
      # send to request
      response = get('/book/'+id.to_s)
      # extract the parsed response only
      attrs = response.parsed_response
      # instantiate a new Book and save all response attributes in instance variables
      self.new attrs
    end
  end
end


