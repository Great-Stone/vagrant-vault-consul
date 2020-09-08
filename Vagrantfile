# -*- mode: ruby -*-
# vi: set ft=ruby :

# base image : https://app.vagrantup.com/bento
# Cluster IP have to set subnetting on private network subnet of VM

BOX_IMAGE = "bento/ubuntu-18.04"
CONSUL_VERSION = "1.8.3"
CONSUL_ADDR = "172.28.128.21"

vault_cluster = {
  "master.vault" => { :ip => "172.28.128.11", :cpus => 1, :mem => 1024 }
}

consul_cluster = {
  "master.consul" => { :ip => "172.28.128.21", :cpus => 1, :mem => 1024 }
}

Vagrant.configure("2") do |config|

  consul_cluster.each_with_index do |(hostname, info), index|
    config.vm.define hostname do |subconfig|
      subconfig.vm.box = BOX_IMAGE
      subconfig.vm.hostname = hostname
      subconfig.vm.network "private_network", name: "vboxnet1", ip: info[:ip]

      subconfig.vm.provision "config", type: "file", preserve_order: true, source: "provisioning/file/consul.d", destination: "/tmp"
      subconfig.vm.provision "ansible", type: "ansible_local", preserve_order: true do |ansible|
        ansible.install = true
        ansible.verbose = "-vvv"
        ansible.playbook = "provisioning/ansible/consul.yml"
        ansible.become = true
        ansible.extra_vars = {
          version: CONSUL_VERSION
        }
      end
      subconfig.vm.provision "install", type: "shell", preserve_order: true do |s|
        s.path = "provisioning/shell/consul.sh"
        s.args = [CONSUL_VERSION]
      end

      subconfig.vm.provider "virtualbox" do |vb|
        vb.name = hostname + "-for-vault"
        vb.gui = false
        vb.memory = info[:mem]
        vb.cpus = info[:cpus]
      end # end provider
    end # end config
  end # end cluster foreach

  vault_cluster.each_with_index do |(hostname, info), index|
    config.vm.define hostname do |subconfig|
      subconfig.vm.box = BOX_IMAGE
      subconfig.vm.hostname = hostname
      subconfig.vm.network "private_network", name: "vboxnet1", ip: info[:ip]
      
      subconfig.vm.provision "config", type: "file", preserve_order: true, source: "provisioning/file/vault.d", destination: "/tmp"
      subconfig.vm.provision "ansible", type: "ansible_local", preserve_order: true do |ansible|
        ansible.install = true
        ansible.verbose = "-vvv"
        ansible.playbook = "provisioning/ansible/vault.yml"
        ansible.become = true
        ansible.extra_vars = {
          consul_addr: CONSUL_ADDR
        }
      end
      subconfig.vm.provision "install", type: "shell", preserve_order: true, path: "provisioning/shell/vault.sh"

      subconfig.vm.provider "virtualbox" do |vb|
        vb.name = hostname
        vb.gui = false
        vb.memory = info[:mem]
        vb.cpus = info[:cpus]
    
        vb.customize ['modifyvm', :id, '--usb', 'on']
        # vb.customize ['usbfilter', 'add', '0', '--target', :id, '--name', 'Yubikey', '--vendorid', '0x1050', '--productid', '0x0407']
      end # end provider
    end # end config
  end # end cluster foreach

  # Create a forwarded port mapping which allows access to a specific port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  
end
