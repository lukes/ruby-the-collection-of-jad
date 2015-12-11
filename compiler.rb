require 'json'

PATH = File.dirname(__FILE__)

def read_imported(subdir)
  Dir.glob(File.join(PATH, 'imported', subdir, '*.json')).map do |f|
    JSON.parse(File.read(f))
  end
end

File.open(File.join(PATH, 'compiled', 'data.js'), 'w+') do |f|
  data = {}
  data[:releases] = read_imported('releases')
  data[:tracks] = read_imported('tracks')
  f.write(JSON.generate(data))
end
