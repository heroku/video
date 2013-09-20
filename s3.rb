require 'fog'
CONN = Fog::Storage.new(provider: "AWS", aws_access_key_id: ENV.fetch("AWS_ACCESS_KEY_ID"), aws_secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY"))

class Video < Struct.new(:name, :url)
  def self.list
    s3 = CONN.directories.get( ENV.fetch("BUCKET") )
    s3.files.map {|f| new(f.key, f.url( Time.now + 7200 ))}.sort_by(&:name).reverse
  end
end

