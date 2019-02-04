# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # http://qiita.com/elim/items/816f03c732e4b274d181
  if ENV['VAGRANT_BRIDGE']
    interfaces = %x(VBoxManage list bridgedifs)
    re = /Name: +(.*#{ENV['VAGRANT_BRIDGE']}.*)/
    if interfaces =~ re
      config.vm.network :public_network, bridge: $1
    end
  end

  # https://www.vagrantup.com/docs/multi-machine/
  config.vm.define "vagrant_debian" do |debian|
    debian.vm.box = "debian/jessie64"

    # Ref. http://qiita.com/betahikaru/items/d77f5891f222eba0c4fa
    debian.vm.network :forwarded_port, id: "ssh", guest: 22, host: 2223

    # Make defautl shared folder disabled
    debian.vm.synced_folder ".", "/vagrant", disabled: true
  end

  config.vm.define "vagrant_ubuntu" do |debian|
    debian.vm.box = "ubuntu/cosmic64"

    debian.vm.network :forwarded_port, id: "ssh", guest: 22, host: 2224

    # Make defautl shared folder disabled
    debian.vm.synced_folder ".", "/vagrant", disabled: true

    debian.vm.provision "shell", inline: <<-SHELL
      # For Ansible, it's better that /usr/bin/python is Python2.
      apt-get update && apt-get install -y python && apt-get clean
    SHELL
  end

  config.vm.define "vagrant_centos" do |centos|
    centos.vm.box = "centos/7"
    centos.vm.network :forwarded_port, id: "ssh", guest: 22, host: 2225

    # Make defautl shared folder disabled
    centos.vm.synced_folder ".", "/home/vagrant/sync", disabled: true
  end
end
