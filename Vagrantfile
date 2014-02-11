# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.host_name = "modx.vm"
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  config.vm.network :forwarded_port, guest: 80, host: 8085
  # config.vm.network :private_network, ip: "33.33.33.11"
  # config.vm.network :public_network

  config.vm.synced_folder ".", "/vagrant"

  config.vm.provider :virtualbox do |vb|
    vb.gui = false
    vb.customize ["modifyvm", :id, "--memory", "512"]
  end

  # config.vm.provision :shell, :inline => "sudo apt-get update"
  
  config.vm.provision :chef_solo do |chef|
    #chef.cookbooks_path = "../my-recipes/cookbooks"
    #chef.roles_path = "../my-recipes/roles"
    #chef.data_bags_path = "../my-recipes/data_bags"
    #chef.add_recipe "mysql"
    #chef.add_role "web"
    chef.json = { 
      :www_root => "/var/www",
      :mysql => {
        :server_root_password => "rootpass"
      },
      :modx => {
        :setup => {
          :database => {
            :password => "rootpass"
          }
        },
        :dir => "/var/www/modx"
      },
      :hosts => {
        :localhost_aliases => ["modx.vm"]
      }  
    },
    chef.run_list = [
      "recipe[modx::default]"
    ]
  end
end
