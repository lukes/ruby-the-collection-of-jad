require 'discogs-wrapper'

discogs_api = Discogs::Wrapper.new("TheCollectionOfJAD/1.0")

puts 'Enter discogs.com Release Code:'
code = STDIN.gets.chomp.downcase

response = discogs_api.get_release(code)

if response.artists.length > 1
  puts "More than one artist for this release"
  exit
end

release = {
  id: response.id,
  title: response.title,
  year: response.year,
  genres: response.genres,
  artist: response.artists.first.name,
  country: response.country,
  format: response.formats.first.descriptions.join(' '),
  label: 'TODO'
}

tracks = response.tracklist.each_with_index.map do |track, i|
  {
    id: [release[:id], i].join('-'),
    order: i,
    title: track.title,
    duration: track.duration,
    position: track.position
  }
end

release[:tracks] = tracks.map { |t| t[:id] }

PATH = File.dirname(__FILE__)

File.open(File.join(PATH, 'imported', 'releases', release[:id].to_s), 'w') do |f|
  f.write(JSON.pretty_generate(release))
  puts " + Imported Release: #{release[:title]}"
end

tracks.each do |track|
  File.open(File.join(PATH, 'imported', 'tracks', track[:id].to_s), 'w') do |f|
    f.write(JSON.pretty_generate(track))
  end
  puts " + Imported Track #{track[:position]}: #{track[:title]}"
end

puts "Done."
