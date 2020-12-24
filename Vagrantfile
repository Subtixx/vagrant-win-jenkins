# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = "gusztavvargadr/windows-server"
  config.vm.synced_folder "jenkins", "/.jenkins"
  
  config.vm.provider "virtualbox" do |vb|
      vb.gui = true
	  vb.memory = 8192
	  vb.cpus = 4
      #vb.customize ["modifyvm", :id, "--memory", 8192]
      #vb.customize ["modifyvm", :id, "--cpus", 4]
      vb.customize ["modifyvm", :id, "--vram", "32"]
      vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
      vb.customize ["setextradata", "global", "GUI/SuppressMessages", "all" ]
  end
  config.vm.provision "shell", path: "scripts/provision.ps1", privileged: true
  config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
end
