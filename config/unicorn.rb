-*- coding: utf-8 -*-
worker_processes 2
vagrant sshvagrant
listen  "160.16.63.29:3000"
pid     "tmp/pids/unicorn.pid"

worker_process 2

timeout 15

preload_app true

ROOT = File.dirname(File.dirname(__FILE__))
stdout_path "#{ROOT}/log/unicorn-stdout.log"
stderr_path "#{ROOT}/log/unicorn-stderr.log"

before_fork do |server, worker|
defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!

old_pid = "#{ server.config[:pid] }.oldbin"
unless old_pid == server.pid
  begin
   sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
   Process.kill :QUIT, File.read(old_pid).to_i
   rescue Errno::ENOENT, Errno::ESRCH
  end
end
end

after_fork do |server, worker|
    defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
