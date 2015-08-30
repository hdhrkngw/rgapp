lock '3.4.0'

#アプリケーション名
set :application,'rgapp'
#レポジトリURL
set :repo_url, 'git@github.com:hdhrkngw/rgapp.git'
#対象ブランチ masterに固定
set :branch, 'master'
#デプロイ先ディレクトリ フルパスで指定
set :deploy_to, '/var/www/rgapp'
#バージョン管理方法 subverion, git, mercurial, cvs, bzrなど
set :scm, :git
#情報レベル info or debug
set :log_level, :debug
#sudoに必要 これをtrueにするとssh -tで実行される
set :pty, true
#sharedに入るものを指定
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets bundle public/system public/assets}
#capistrano用bundleするのに必要
set :default_env, { path: "/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH" }
#5回分のreleasesを保持する
set :keep_releases, 5 

#タスク定義
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do #タスクnamespace
    #サンプルにunicorn再起動タスク
    desc 'Restart application'
    task :restart do
      invoke 'unicorn:restart' #lib/capustrano/tasks/unicorn.cap内処理を実行
    end
end
