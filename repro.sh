mkdir data 

vault server -config=config.hcl&

sleep 10

export VAULT_ADDR='http://127.0.0.1:8200'

initResult=$(vault operator init -recovery-shares=1 -recovery-threshold=1)

echo $initResult | jq > data.json 

rootToken=$(echo -n $initResult | jq -r '.root_token')

echo $rootToken > rootToken

vault login rootToken

terraform init 

terraform apply -auto-approve

vault write sys/quotas/rate-limit/quota-dev rate=5000 path=test/  

vault write sys/quotas/rate-limit/quota-dev rate=5000 path=dev/ 

vault delete sys/quotas/rate-limit/quota-dev  

vault list sys/quotas/rate-limit

vault write sys/quotas/rate-limit/dev-limit rate=5000 path=test/
