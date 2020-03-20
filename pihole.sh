#!/bin/bash

apt update -y
apt upgrade -y
apt install curl -y
curl -sSL https://install.pi-hole.net | bash

