# Vault + Consul example of Vagrant

## Prerequisite
- Vagrant Installed : https://www.vagrantup.com
- Virtual Box Installed : https://www.virtualbox.org

## RUN
```bash
$ vagrant up --provision
```

## Config

### 1. Vagrantfile
- BOX_IMAGE : vm image
    - If you want change base image, find here : https://app.vagrantup.com/bento
- CONSUL_VERSION : Consul is not support pkg install, yet. It has to manual install and enter the version.
- CONSUL_ADDR : In this example, Vault is using Consul of backend storage.
- vault_cluster `:ip` : Put the ip address of the VM's subnet
- consul_cluster `:ip` : Put the ip address of the VM's subnet
- subconfig.vm.network of config : Put the right private network

### 2. Ansible playbook
- Path : provisioning/ansible/*.yml

### 3. Configuration files
- Path : provisioning/file/{name}.d