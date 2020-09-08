ui = true

storage "consul" {
  address = "CONSUL_ADDR:8500"
  path    = "vault"
}

listener "tcp" {
  address     = "127.0.0.1:8200"
  tls_disable = 1
}

service_registration "consul" {
  address      = "CONSUL_ADDR:8500"
}