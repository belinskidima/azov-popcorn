RACK_ENV= ENV['RACK_ENV'] || 'development'

require 'sinatra/base'
require 'json'

MOVIES = JSON.parse(File.read('list.json', encoding: 'utf-8'))

class App < Sinatra::Base
  configure :development do
    require 'sinatra/reloader'
    register Sinatra::Reloader
    also_reload 'parser.rb'
  end

  configure :production do
    set :server, :puma
  end

  get '/' do
    haml :index, locals: { movies: MOVIES['movies'].shuffle }
  end
end