ui = true

listener "tcp" {
    tls_disable = 1
    address = "127.0.0.1:8200"
 }
 
storage "file" {
    path = "./data"
  }

seal "gcpckms" {
   credentials = "cred.json"
   project     = "my-project-1234-285014"
   region      = "global"
   key_ring    = "catalina"
   crypto_key  = "vault"
}
