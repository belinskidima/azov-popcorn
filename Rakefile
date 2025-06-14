ENV['RACK_ENV'] ||= 'development'
require 'sinatra/activerecord/rake'
require './parser'
Dir.glob('lib/tasks/*.rake').each { |r| import r }