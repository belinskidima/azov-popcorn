# Specifies the number of worker processes (Heroku sets this automatically, so you can omit or set to 1 for local)
workers Integer(ENV['WEB_CONCURRENCY'] || 1)

# Specifies the number of threads per worker
threads_count = Integer(ENV['RAILS_MAX_THREADS'] || 5)
threads threads_count, threads_count

# Preload the app for faster worker spawn times (recommended for production)
preload_app!

# Specifies the port that Puma will listen on to receive requests; default is 9292
port        ENV.fetch("PORT") { 9293 }

# Specifies the `environment` that Puma will run in
environment ENV.fetch("RACK_ENV") { "development" }

# Allow puma to be restarted by `rails restart` command (safe to leave in for Sinatra apps)
plugin :tmp_restart