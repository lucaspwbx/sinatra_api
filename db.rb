env = ENV['RACK_ENV'] || "development"
url = "sqlite://#{Dir.pwd}/db/#{env}.sqlite3"
DataMapper.setup :default, url

class Movie
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :description, Text
end

DataMapper.finalize
DataMapper.auto_upgrade!
