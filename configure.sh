export VAULTROOT="$HOME/vault"
echo "Creating the vault data directory"
mkdir -p $VAULTROOT/vault-data

sleep 10
echo "Generating the certificates"
openssl req -x509 -newkey rsa:4096 -sha256 -days 365 \
    -nodes -keyout $VAULTROOT/vault-key.pem -out $VAULTROOT/vault-cert.pem \
    -subj "/CN=$(hostname -f)" \
    -addext "subjectAltName=DNS:localhost,IP:127.0.0.1"

echo "Preparing the configuration...."
sleep 10
cat > $VAULTROOT/vault-server.hcl << EOF
api_addr                = "https://$(hostname -i):8200"
cluster_addr            = "https://$(hostname -i):8201"
cluster_name            = "learn-vault-cluster"
disable_mlock           = true
ui                      = true

listener "tcp" {
address       = "$(hostname -i):8200"
tls_cert_file = "$VAULTROOT/vault-cert.pem"
tls_key_file  = "$VAULTROOT/vault-key.pem"
}

backend "raft" {
path    = "$VAULTROOT/vault-data"
node_id = "learn-vault-server"
}
EOF






