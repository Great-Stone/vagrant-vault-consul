server = true
ui = true
bootstrap_expect = 1
datacenter = "vagrant"
node_name = "vagrant-consul"
client_addr = "{{ GetInterfaceIP \"eth1\" }}"
bind_addr = "{{ GetPrivateIP }}"
encrypt = "h65lqS3w4x42KP+n4Hn9RtK84Rx7zP3WSahZSyD5i1o="
data_dir = "/var/lib/consul"
acl {
  enabled = false
  default_policy = "allow"
  down_policy = "extend-cache"
}