require 'uri'
require 'net/http'

class MediaController < ApplicationController
  def shows
    id = params[:id]
    puts id
  end

  def movies 
    id = params[:id]
    puts id
  end

  def search
    query = params[:query]
    api_key = ENV['TMDB_API_KEY']

    url = URI("https://api.themoviedb.org/3/search/multi?query=#{query}&api_key=#{api_key}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request.body = "{}"

    response = http.request(request)
    puts response.read_body
  end
end
