file '/tmp/yourname123' do
  action :create
end

directory '/tmp/insight' do
  action :create
end

file '/tmp/hello_world.sh' do
  content '#!/bin/bash
           echo "Hello world!!" '
  action :create
  mode 0755
end

%w{/tmp/insight/web /tmp/insight/data /tmp/insight/css /tmp/insight/img}.each do |files|
  directory "#{files}" do
    action :create
  end
end

package "telnet" do
  action :install
end

package "nginx" do
  action :install
end

service "nginx" do
  action [ :enable, :start]
end

file '/var/www/html/index.html' do
  content "This my home page"
  action :create
  notifies :restart, "service[nginx]", :delayed
end

# Create your Linux password
# $ openssl passwd -1 password

user 'youradmin' do
  comment 'Test'
  manage_home true
  home '/home/yourlogin'
  shell '/bin/bash'
  password "paste-password-encryped-here"
end

directory "/home/ubuntu/chef/.chef" do
  action :create
  recursive true
end

file "/home/ubuntu/chef/.chef/knife.rb" do
  content "cookbook_path [ '~/chef/cookbooks']"
end

file "/home/ubuntu/chef/cookbooks/solo.rb" do
  content "cookbook_path [ '~/chef/cookbooks']"
end

