export VAULT_CONFIG=/etc/vault.d
export VAULT_BINARY=$(which vault)

echo "Create vault service daemon"
sleep 5
sudo tee /lib/systemd/system/vault.service <<EOF
[Unit]
Description="HashiCorp Vault"
Documentation="https://developer.hashicorp.com/vault/docs"
ConditionFileNotEmpty="${VAULT_CONFIG}/vault-server.hcl"

[Service]
User=vault
Group=vault
SecureBits=keep-caps
AmbientCapabilities=CAP_IPC_LOCK
CapabilityBoundingSet=CAP_SYSLOG CAP_IPC_LOCK
NoNewPrivileges=yes
ExecStart=${VAULT_BINARY} server -config=${VAULT_CONFIG}/vault-server.hcl
ExecReload=/bin/kill --signal HUP
KillMode=process
KillSignal=SIGINT

[Install]
WantedBy=multi-user.target
EOF

sudo chmod 644 /lib/systemd/system/vault.service

echo "Start vault service daemon"

sudo systemctl daemon-reload

sudo systemctl start vault.service

echo "Initialize unseal key and root token (please save it for later use)"
sleep 5

export VAULT_ADDR=https://$(hostname -i):8200

#skip tls verify since self-signed certificate is used 

export VAULT_SKIP_VERIFY=true

vault operator init -key-shares=1 -key-threshold=1

#To unseal your vault use the following command 
# vault operator unseal

