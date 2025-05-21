##Instructions for using the scripts 
```
git clone https://github.com/bharathdcs/vault-setup.git

cd vault-setup/

chmod 777 *

./install-hasicorp.sh 

./configure.sh 
Creating the vault data directory
Generating the certificates
.......+...+....+.....+.+..+......................+...+..+.+.....+.......+........+.........+............+.+............+.................+...+.+..+++++++++++++++++++++++++++++++++++++++++++++*......+....+...+...+..+.......+.........+.....+.+......+.....+....+...+..+.........+...................+..+.+..+.+...........+...+.+..+..........+........+....+..+..........+.....+.+..+.+..+..........+..+...+++++++++++++++++++++++++++++++++++++++++++++*........+..................+...+.....+...............+................+......+....................+...+......+.............+.....+...+.............+.....+++++
...+++++++++++++++++++++++++++++++++++++++++++++*..........+.....+...+...+...+............+...+....+..+.............+...+...+++++++++++++++++++++++++++++++++++++++++++++*.+...............+..........+.....+......+..........+...+.....+............................+...+..............+..........+........+............+++++

Preparing the configuration....



./init-vault.sh 
Create vault service daemon
[Unit]
Description="HashiCorp Vault"
Documentation="https://developer.hashicorp.com/vault/docs"
ConditionFileNotEmpty="/etc/vault.d/vault-server.hcl"

[Service]
User=vault
Group=vault
SecureBits=keep-caps
AmbientCapabilities=CAP_IPC_LOCK
CapabilityBoundingSet=CAP_SYSLOG CAP_IPC_LOCK
NoNewPrivileges=yes
ExecStart=/usr/bin/vault server -config=/etc/vault.d/vault-server.hcl
ExecReload=/bin/kill --signal HUP
KillMode=process
KillSignal=SIGINT

[Install]
WantedBy=multi-user.target
Start vault service daemon
Initialize unseal key and root token (please save it for later use)
![image](https://github.com/user-attachments/assets/fc5a90f5-444f-4c62-bec3-74528c4e224c)
```
