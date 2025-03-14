#!/bin/bash
#
# Create directories for nodes
mkdir -p /root/node-1
#
# Clone repositories for node 1
git clone https://github.com/pulagam344/28B.git /root/node-1
#
# Install dependencies
apt-get install -y libgomp1
#
# Install Gaianet on node-1
curl -sSfL 'https://raw.githubusercontent.com/GaiaNet-AI/gaianet-node/main/install.sh' | bash -s -- --base /root/node-1
#
# Set the environment path for node-1
export PATH=$PATH:/root/node-1/bin
/root/node-1/bin/gaianet init --config https://raw.githubusercontent.com/GaiaNet-AI/node-configs/main/qwen2-0.5b-instruct/config.json --base /root/node-1
#
# Configure the ports for both nodes
/root/node-1/bin/gaianet config --port 8081 --base /root/node-1
#
# Modify the frpc.toml files for both nodes
sed -i 's/localPort = 8080/localPort = 8081/' /root/node-1/gaia-frp/frpc.toml
#
# Start the nodes
/root/node-1/bin/gaianet start --base /root/node-1
#
# Show the node info
/root/node-1/bin/gaianet info --base /root/node-1
