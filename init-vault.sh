export VAULTROOT="$HOME/vault"
vault server -config=$(VAULTROOT)/vault-server.hcl

sleep 5
echo "Initialize unseal key and root token (please save it for later use)"

export VAULT_ADDR=https://$(hostname -i):8200

#skip tls verify since self-signed certificate is used 

export VAULT_SKIP_VERIFY=true

vault operator init -key-shares=1 -key-threshold=1

#To unseal your vault use the following command 
# vault operator unseal

