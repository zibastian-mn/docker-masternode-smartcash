#!/bin/sh

previousBlock=$(cat ~/blockcount)
currentBlock=$(smartcash-cli getblockcount)

smartcash-cli getblockcount > ~/blockcount

if [ "$previousBlock" == "$currentBlock" ]; then
	echo "Daemon stucked. Exiting"
	smartcash-cli stop
fi

