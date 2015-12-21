require 'json'

PATH = File.dirname(__FILE__)

def read_imported(subdir)
  Dir.glob(File.join(PATH, 'imported', subdir, '*.json')).map do |f|
    JSON.parse(File.read(f))
  end
end

def slug_for_genre(genre)
  genre.downcase.gsub(/\W/, '-').gsub(/-+/, '-')
end

releases = read_imported('releases')
releases.sort_by! {|r| r['title']}

genres = releases.map {|r| r['genres']}.flatten.uniq.map do |genre|
  {
    id: genre,
    slug: slug_for_genre(genre)
  }
end

File.open(File.join(PATH, 'compiled', 'data.json'), 'w+') do |f|
  data = {}
  data[:genres] = genres
  data[:releases] = releases
  data[:tracks] = read_imported('tracks').sort_by {|r| r['sequence']}
  f.write(JSON.generate(data))
end
