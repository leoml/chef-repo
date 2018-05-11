# -*- mode: ruby -*-
# vi: set ft=ruby :

# variaveis

  vhosts =[
    { :hostname => "Chef", :ip => "127.0.0.1", :fssh_port => "2215", :fweb_port => "8060"},
  ]


$script = <<SCRIPT
echo "Instalando dependencias..." 
wget  https://packages.chef.io/files/stable/chef-server/12.17.33/ubuntu/16.04/chef-server-core_12.17.33-1_amd64.deb
sudo dpkg -i chef-server-core_12.17.33-1_amd64.deb
mkdir /home/vagrant/.chef
export PATH=$PATH:/opt/opscode/embedded/bin/

SCRIPT

# inicio

Vagrant.configure("2") do |config|
 
  vhosts.each do |vhost|
    
    config.vm.provision "shell", inline: $script
    config.vm.define vhost[:hostname] do |node|
      node.vm.box = "minimal/trusty64"
      node.vm.hostname = vhost[:hostname]
      node.vm.box_url = "minimal/trusty64"
      node.vm.boot_timeout = 3600

      node.vm.network :forwarded_port, guest:22, host:vhost[:fssh_port], host_ip: vhost[:ip], auto_correct: true
      node.vm.network :forwarded_port, guest:80, host:vhost[:fweb_port], host_ip: vhost[:ip], auto_correct: true

      node.vm.provider :virtualbox do |v|
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--memory", 1024]
        v.customize ["modifyvm", :id, "--name", vhost[:hostname]+"-VG-machine"]
      end
    end
  end

end