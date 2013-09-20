require 'fog'
conn = Fog::Storage.new(provider: "AWS", aws_access_key_id: ENV.fetch("AWS_ACCESS_KEY_ID"), aws_secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY"))
S3 = conn.directories.get( ENV.fetch("BUCKET") )

class Video < Struct.new(:name, :url)
  def self.list
    S3.files.map {|f| new(f.key, f.url( Time.now + 600 ))}
  end
end

