require 'uri'
require 'net/http'

class MediaController < ApplicationController
  def show
    id = params[:id]
    query_string  = "/tv/#{id}?"
    response = call_api(query_string)

    if response.code != "404"
      render json: format(response.read_body)
    else
      render status: 404, json: {"error_message": JSON.parse(response.read_body)["status_message"]}.to_json
    end
  end

  def movie 
    id = params[:id]
    query_string  = "/movie/#{id}?"
    response = call_api(query_string)
 
    if response.code != "404"
      render json: format(response.read_body)
    else
      render status: 404, json: {"error_message": JSON.parse(response.read_body)["status_message"]}.to_json
    end
  end

  def search
    query = params[:query]
    page = params[:page]
    if page
      query_string  = "/search/multi?query=#{query}&page=#{page}"
    else
      query_string  = "/search/multi?query=#{query}"
    end
    response = call_api(query_string)
    
    if response.code != "404"
      render json: format_search(response.read_body)
    else
      render status: 404, json: {"error_message": JSON.parse(response.read_body)["status_message"]}.to_json
    end
  end

  def call_api(query_string)
    api_key = ENV['TMDB_API_KEY']
    url = URI("https://api.themoviedb.org/3" + query_string + "&api_key=#{api_key}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request.body = "{}"

    http.request(request)
  end

  def format(response)
    media_info = JSON.parse(response)
    release = media_info["first_air_date"] || media_info["release_date"]
    title = media_info["name"] || media_info["title"]
    synopsis = media_info["overview"]

    {title: title, release: release, synopsis: synopsis}.to_json
  end
  
  def format_search(response)
    response = JSON.parse(response)
    results = []
    response["results"].each do |media_info|
      type = media_info["media_type"]
      if type == 'person'
        next
      end
      release = media_info["first_air_date"] || media_info["release_date"]
      title = media_info["name"] || media_info["title"]
      synopsis = media_info["overview"]

      results << {title: title, release: release, synopsis: synopsis, type: type}
    end

    {media: results}.to_json
  end
end
