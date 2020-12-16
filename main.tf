terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "vault" {
  address = "http://127.0.0.1:8200"
}


resource "vault_namespace" "dev" {
  path = "dev"
}


resource "vault_namespace" "test" {
  path = "test"
}


resource "vault_quota_rate_limit" "dev" {
  name = "quota-dev"
  path = "${vault_namespace.dev.path}/"
  rate = 50
}
