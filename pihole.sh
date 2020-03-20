#!/bin/bash

apt update
apt upgrade -y
apt install curl -y
curl -sSL https://install.pi-hole.net | bash

