class Slug

  def self.for(string)
    string.downcase.gsub(/\W/, '-').gsub(/-+/, '-')
  end

end
