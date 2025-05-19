export VAULT_CONFIG=/etc/vault.d
echo "Creating the vault data directory"
mkdir -p $VAULT_CONFIG/vault-data
chown vault:root $VAULT_CONFIG -R

sleep 10
echo "Generating the certificates"
openssl req -x509 -newkey rsa:4096 -sha256 -days 365 \
    -nodes -keyout $VAULT_CONFIG/vault-key.pem -out $VAULT_CONFIG/vault-cert.pem \
    -subj "/CN=$(hostname -f)" \
    -addext "subjectAltName=DNS:localhost,IP:127.0.0.1"

echo "Preparing the configuration...."
sleep 10
cat > $VAULT_CONFIG/vault-server.hcl << EOF
api_addr                = "https://$(hostname -i):8200"
cluster_addr            = "https://$(hostname -i):8201"
cluster_name            = "learn-vault-cluster"
disable_mlock           = true
ui                      = true

listener "tcp" {
address       = "$(hostname -i):8200"
tls_cert_file = "$VAULT_CONFIG/vault-cert.pem"
tls_key_file  = "$VAULT_CONFIG/vault-key.pem"
}

backend "raft" {
path    = "$VAULT_CONFIG/vault-data"
node_id = "learn-vault-server"
}
EOF






