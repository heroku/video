require 'sinatra'

class App < Sinatra::Application
  get '/' do
    'hello'
  end
end
