#!/bin/sh

if [ -z "$node_key" ]; then
	echo "-e node_key is missing. Exiting"
	exit 1
fi

if [ -z "$external_ip" ]; then
	echo "-e external_ip is missing. Exiting"
	exit 1
fi

_rpcUserName=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 12 ; echo '')
_rpcPassword=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32 ; echo '')

if [ ! -d "/opt/smartcash/.smartcash/smartcash.conf" ]; then
	mkdir /opt/smartcash/.smartcash

echo "rpcuser=${_rpcUserName}
rpcpassword=${_rpcPassword}
rpcallowip=127.0.0.1
listen=1
server=1
maxconnections=64
smartnode=1
externalip=${external_ip}
port=9678
smartnodeprivkey=${node_key}
" > /opt/smartcash/.smartcash/smartcash.conf

	echo '-1' > ~/blockcount
fi

smartcashd -printtoconsole