require 'json'

namespace :db do
  desc "Populate movies table from list.json"
  task populate_movies: :environment do
    file_path = File.expand_path('../../list.json', __dir__)
    unless File.exist?(file_path)
      puts "list.json not found at #{file_path}"
      exit 1
    end

    movies = JSON.parse(File.read(file_path, encoding: 'utf-8'))['movies']
    movies.each do |movie_data|
      movie = Movie.find_or_initialize_by(uaserial_id: movie_data['id'])
      movie.title = movie_data['name']
      movie.url = "https://uaserial.top" + movie_data['link']
      movie.year = movie_data['year']['name']
      movie.poster_url = "https://uaserial.top" + movie_data['poster']
      movie.imdb = movie_data['imdb']

      if movie.save
        puts "Movie '#{movie.title}' saved successfully."
      else
        puts "Failed to save movie '#{movie.title}': #{movie.errors.full_messages.join(', ')}"
      end
    end
    puts "Movies table populated from list.json!"
  end
end