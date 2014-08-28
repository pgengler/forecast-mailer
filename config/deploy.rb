# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'forecast-mailer'
set :repo_url, 'git@github.com:pgengler/forecast-mailer.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/srv/apps/weather'

# Default value for :linked_files is []
set :linked_files, %w{ .env }

# Default value for linked_dirs is []
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :deploy do

	desc 'Restart application'
	task :restart do
		on roles(:app), in: :sequence, wait: 5 do
			invoke 'unicorn:stop'
			invoke 'unicorn:start'
		end
	end

	after :publishing, :restart
end
