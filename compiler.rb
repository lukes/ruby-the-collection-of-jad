require 'json'
require_relative 'lib/imported'
require_relative 'lib/slug'

PATH = File.dirname(__FILE__)

genres = Imported.releases.map {|r| r['genres']}.flatten.uniq.map do |genre|
  {
    id: genre,
    slug: Slug.for(genre)
  }
end

File.open(File.join(PATH, 'compiled', 'data.json'), 'w+') do |f|
  data = {}
  data[:genres] = genres
  data[:releases] = Imported.releases
  data[:tracks] = Imported.tracks
  f.write(JSON.generate(data))
end

puts 'Done.'
