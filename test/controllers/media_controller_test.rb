require 'test_helper'
require 'webmock/minitest'

class MediaControllerTest < ActionDispatch::IntegrationTest
    test "should_render_show_info" do
      body = {"first_air_date":"2004-01-12","id":1,"name":"Pride","overview":"Pride is a Japanese drama."}.to_json
      expected_response = {"title":"Pride","release":"2004-01-12", "synopsis":"Pride is a Japanese drama."}.to_json
      stub_request(:get, "https://api.themoviedb.org/3/tv/1").with(query: hash_including({})).to_return(body: body, status: 200) 
      get '/show/1'


      assert_response :success
      assert_equal(expected_response, response.body)
    end

    test "should_render_error_message_for_show" do
      body = {"status_code":34,"status_message":"The resource you requested could not be found."}.to_json
      stub_request(:get, "https://api.themoviedb.org/3/tv/1").with(query: hash_including({})).to_return(body: body, status: 404) 
      expected_response = {"error_message": "The resource you requested could not be found."}.to_json
      get '/show/1'

      assert_response :missing
      assert_equal(expected_response, response.body)
    end

    test "should_render_movie_info" do
      body = {"release_date":"2010-01-12","id":1,"title":"Air Bud","overview":"Dog with a basketball."}.to_json
      expected_response = {"title":"Air Bud","release":"2010-01-12", "synopsis":"Dog with a basketball."}.to_json
      stub_request(:get, "https://api.themoviedb.org/3/movie/1").with(query: hash_including({})).to_return(body: body, status: 200) 
      get '/movie/1'

      assert_response :success
      assert_equal(expected_response, response.body)
    end

    test "should_render_error_message_for_movie" do
      body = {"status_code":34,"status_message":"The resource you requested could not be found."}.to_json
      stub_request(:get, "https://api.themoviedb.org/3/movie/1").with(query: hash_including({})).to_return(body: body, status: 404) 
      expected_response = {"error_message": "The resource you requested could not be found."}.to_json
      get '/movie/1'

      assert_response :missing
      assert_equal(expected_response, response.body)
      
    end
    
    test "should_render_media_info_from_search_query" do
      body = {"page":1,"total_results":5955,"total_pages":298,"results":[{"original_name":"Mad Men","id":1104,"media_type":"tv","name":"Mad Men","first_air_date":"2007-07-19","overview":"Mad Men is about guys that are angry"},{"release_date":"2010-01-12","id":1,"title":"Air Bud", "media_type": "movie","overview":"Dog with a basketball."}]}.to_json
      expected_response = {"media": [{"title":"Mad Men","release":"2007-07-19", "synopsis":"Mad Men is about guys that are angry", "type": "tv"}, {"title":"Air Bud","release":"2010-01-12", "synopsis":"Dog with a basketball.", type: "movie"}]}.to_json
      stub_request(:get, "https://api.themoviedb.org/3/search/multi").with(query: hash_including({})).to_return(body: body, status: 200) 
      get '/search?query=a'

      assert_response :success
      assert_equal(expected_response, response.body)
    end

end
