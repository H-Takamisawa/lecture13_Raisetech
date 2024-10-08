require 'serverspec'
require 'net/ssh'

# Backendの設定
set :backend, :ssh

if ENV['ASK_SUDO_PASSWORD']
  begin
    require 'highline/import'
  rescue LoadError
    fail "highline is not available. Try installing it."
  end
  set :sudo_password, ask("Enter sudo password: ") { |q| q.echo = false }
else
  set :sudo_password, ENV['SUDO_PASSWORD']
end

# サーバー情報の設定
#host = ENV['TARGET_HOST'] 
host = ENV['AWS_EC2_IP']

options = Net::SSH::Config.for(host)

#options[:user] ||= Etc.getlogin
options[:user] ||= "ec2-user"

set :host,        options[:host_name] || host
set :ssh_options, options

# Disable sudo
# set :disable_sudo, true


# Set environment variables
# set :env, :LANG => 'C', :LC_MESSAGES => 'C'

# Set PATH
# set :path, '/sbin:/usr/local/sbin:$PATH'
