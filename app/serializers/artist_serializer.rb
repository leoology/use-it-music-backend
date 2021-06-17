class ArtistSerializer
  include JSONAPI::Serializer
  attributes :name, :id, :genres, :popularity, :ratings
end
