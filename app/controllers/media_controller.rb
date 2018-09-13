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
    puts query 
  end
end
