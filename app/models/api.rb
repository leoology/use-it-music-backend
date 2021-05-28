require 'net/http'
require 'byebug'
require 'json'
#require_relative '../../config/environment.rb'
require_relative './application_record.rb'
require_relative './artist.rb'


class Api

    attr_reader :url, :token

    def initialize(url)
        @token ="BQA4JymLQ4_ob5tpQS73UkB9lhlDFj1-uAdbH_5ZJtXvdLi9i9A8Xgd1Qp5tcYWHlfV7f3mmb2dHu6u_LuDCaYk-ijC9AYRlHky3l4o0exJtGHj3YL-OL892fw0BTqjYEiXzDBQsfFa31V8tmQ"

        @url=url
    end

    def get_info
        uri=URI(url)
        new_req = Net::HTTP::Get.new(uri)
        new_req['Authorization'] = "Bearer #{token}" 
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = (uri.scheme == "https")
        response = http.request(new_req)
        return JSON(response.body)

    end

    def make_artists
        get_info["items"].each do |a|
            genres=a["genres"].join(", ")
            image_url=a["images"].first["url"]
            name=a["name"]
            popularity= a["popularity"]
            Artist.find_or_create_by(name) do |b|
                b.image_url= image_url
                b.popularity= popularity
                b.genres= genres
            end
        end
    end


end
api= Api.new("https://api.spotify.com/v1/me/top/artists")
api.make_artists