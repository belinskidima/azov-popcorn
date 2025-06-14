RACK_ENV= ENV['RACK_ENV'] || 'development'

require 'sinatra'
require 'sinatra/activerecord'
require 'pg'

require_relative './models/movie'

set :database, ENV['DATABASE_URL']

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
    puts Movie.all.to_a.shuffle
    haml :index, locals: { movies: Movie.all.shuffle }
  end
end