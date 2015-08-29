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
namespace :deploy do #タスクnamespace
    #desc 'タスク説明'
    #task :restart do #タスク定義 
        #ここにタスク処理内容を記述
    #end
  #after :finishing, 'deploy:cleanup' #task実行タイミングを指定できます。詳細は下記
  #http://capistranorb.com/documentation/getting-started/flow/
    #サンプルにunicorn再起動タスク
    desc 'Restart application'
    task :restart do
      invoke 'unicorn:restart' #lib/capustrano/tasks/unicorn.cap内処理を実行
    end
  after :finishing, 'deploy:cleanup'
end
