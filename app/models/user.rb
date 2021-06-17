class User < ApplicationRecord
    has_many :ratings
    validates :name, presence: true
    validates :name, uniqueness: true


end
