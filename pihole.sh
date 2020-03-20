#!/bin/bash

apt update
apt upgrade -y
apt install curl -y
curl -sSL https://install.pi-hole.net -o install-pihole.sh
chmod +x install-pihole.sh
source install-pihole.sh --unattended
rm install-pihole.sh

