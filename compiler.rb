require 'json'

PATH = File.dirname(__FILE__)

def read_imported(subdir)
  Dir.glob(File.join(PATH, 'imported', subdir, '*.json')).map do |f|
    JSON.parse(File.read(f))
  end
end

File.open(File.join(PATH, 'compiled', 'data.json'), 'w+') do |f|
  data = {}
  data[:releases] = read_imported('releases').sort_by {|r| r['title']}
  data[:tracks] = read_imported('tracks').sort_by {|r| r['sequence']}
  f.write(JSON.generate(data))
end
