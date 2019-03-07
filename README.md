# docker_magics
Contains small handy tools around docker

## change IP range of default bridge docker0

so that it does not conflict with your orgnanization's network

```
bash <(curl -s https://raw.githubusercontent.com/fanzhenya/docker_magics/master/fix_docker0.sh)
# or, with args
bash <(curl -s https://raw.githubusercontent.com/fanzhenya/docker_magics/master/fix_docker0.sh) 192.168.178.1/24
```
