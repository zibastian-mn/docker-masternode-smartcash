Introduction
---
This image is running a Smartnode

**GitHub:** https://github.com/zibastian-mn/docker-masternode-smartcash/  
**Docker:** https://hub.docker.com/r/zibastian/masternode-smartcash/  

---
Starting a node
---
```sh
docker run -d --restart=unless-stopped \
               -e node_key=<PrivateKey>
               -v smartnode:/opt/etho -p 9678:9678 \
               zibastian/masternode-smartcash
```

---
Uninstall
---
```sh
docker rm -f <CONTAINER_NAME> && docker volume rm smartnode
```
---
Container logs
---
```bash
docker logs -f <CONTAINER_NAME> [--tail 20]
```

---
Donation
---
If this image helps you reduce time to deploy, I like beer :)

**SMART:** SVu4CZ8ufyv8zovqZe418mWUcjefJzpzVi  
**EGEM:** 0x720752E61664a1B81B2ec9F7E709D0bCDB55502f  
**ETH:** 0x13B0E1c351e4a9Eae4980ae5469022808C8B3B6D  
**LTC:** MBiWJ3HB69nXtfxvdFmZE5iGm5AXWPRZuh  
**BTC:** 3NshfttcuYKNrU8CCwFqzuu8x95VtGQeu4  
