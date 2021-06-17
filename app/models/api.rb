require 'net/http'
require 'byebug'
require 'json'
require 'pry'
require_relative '../../config/environment.rb'
# require_relative './application_record.rb'
# require_relative './artist.rb'


class Api 
    attr_reader :url, :token
    def initialize(url)
        @token ="BQDcsobsOJtXuq5TFZMiVJ0ab6dBIt7jdoa6IQy7x7zCj48xlm_9H0zGUzwlVIJzQpDUPAKfbfpwe2MKUojfFPNDm2bw4fQacbIpQOCAm64O1LYcsHwWyrh7XlOENVwAkRG1F1HNiWmADuLE1w"     
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
        get_info["artists"].each do |a|
            genres=a["genres"].join(", ")
            image_url=a["images"].first["url"]
            name=a["name"]
            popularity= a["popularity"]
            a = Artist.find_or_create_by(name: name, image_url: image_url, popularity: popularity, genres: genres)
        end
    end
end
api = Api.new("https://api.spotify.com/v1/artists?ids=3WrFJ7ztbogyGnTHbHJFl2%2C6qqNVTkY8uBg9cP3Jd7DAH%2C1Xyo4u8uXC1ZmMpatF05PJ%2C3TVXtAsR1Inumwj472S9r4%2C3Nrfpe0tUJi4K4DXYWgMUX%2C06HL4z0CvFAxyc27GXpf02%2C1uNFoZAHBGtllmzznpCI3s%2C6qqNVTkY8uBg9cP3Jd7DAH%2C31n3CN1jSC5ALUJ9dwT8UI%2C2gsggkzM5R49q6jpPvazou%2C07YZf4WDAMNwqr4jfgOZ8y%2C6vWDO969PvNqNYHIOW5v0m")
api.make_artists
