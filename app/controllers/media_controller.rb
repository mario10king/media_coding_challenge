require 'uri'
require 'net/http'

class MediaController < ApplicationController
  def shows
    id = params[:id]
    query_string  = "/tv/#{id}?"
    puts call_api(query_string)
  end

  def movies 
    id = params[:id]
    query_string  = "/movies/#{id}?"
    puts call_api(query_string)
  end

  def search
    query = params[:query]
    query_string  = "/search/multi?query=#{query}"
    puts call_api(query_string)
  end

  def call_api(query_string)
    api_key = ENV['TMDB_API_KEY']
    url = URI("https://api.themoviedb.org/3" + query_string + "&api_key=#{api_key}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request.body = "{}"

    response = http.request(request)
    response.read_body
  end
end
