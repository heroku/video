require 'sinatra'
require './s3'

class App < Sinatra::Application
  before do
    halt(403) unless request.env['bouncer.email']
  end

  get '/' do
    @videos = Video.list
    erb :index
  end
end

__END__

@@ layout
<html>
<head>
  <title>heroku videos</title>
  <style>body { font-family: monospace; }</style>
</head>
<body>
<%= yield %>
</body>
</html>

@@ index
<ul>
  <% @videos.each do |video| %>
    <li><a href="<%= video.url %>"><%= video.name %></a></li>
  <% end %>
</ul>

