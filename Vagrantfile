# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "debian/jessie64"

  # http://qiita.com/elim/items/816f03c732e4b274d181
  if ENV['VAGRANT_BRIDGE']
    interfaces = %x(VBoxManage list bridgedifs)
    re = /Name: +(.*#{ENV['VAGRANT_BRIDGE']}.*)/
    if interfaces =~ re
      config.vm.network :public_network, bridge: $1
    end
  end

  # Make defautl shared folder disabled
  config.vm.synced_folder ".", "/vagrant", disabled: true

  # https://www.vagrantup.com/docs/multi-machine/
  config.vm.define "vagrant" do |web|
  end
end
