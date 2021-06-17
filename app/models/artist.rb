#require  'pry'
class Artist < ApplicationRecord
    has_many :ratings
    #scope search_by_artist, -> (search){where("artist LIKE ?", "%#{search}%")}
     #binding.pry
end
