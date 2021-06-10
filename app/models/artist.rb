#require  'pry'
class Artist < ApplicationRecord
    has_many :songs
    has_many :ratings, through: :songs
    #scope search_by_artist, -> (search){where("artist LIKE ?", "%#{search}%")}
     #binding.pry
end
