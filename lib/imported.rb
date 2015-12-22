class Imported

  PATH = File.dirname(__FILE__)

  def self.tracks
    @@_tracks = read_imported('tracks').sort_by {|r| r['sequence']}
  end

  def self.releases
    @@_releases = read_imported('releases').sort_by {|r| r['title']}
  end

private

  def self.read_imported(subdir)
    Dir.glob(File.join(PATH, '..', 'imported', subdir, '*.json')).map do |f|
      JSON.parse(File.read(f))
    end
  end

end
