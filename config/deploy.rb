# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'blogger'
set :repo_url, 'git@github.com:mohanramkumar/blogger.git'
set :rvm_ruby_version, '2.2.1'
set :pty, true
set :forward_agent, true
set :auth_methods, "publickey"
set :keys, "/home/myCert.pem"
set :user, 'azureuser'

set :deploy_to, '/home/deploy/blogger'

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end