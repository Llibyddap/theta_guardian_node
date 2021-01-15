FROM debian:stable-slim
LABEL maintainer="Bill Armstrong <bill.r.armstrong@gmail.com>"

# run tasks
RUN apt-get update && apt-get upgrade curl wget -y \
        && mkdir /root/theta_mainnet \
        && mkdir /root/theta_mainnet/bin \
        && mkdir -p /root/.theta \
        && mkdir -p /root/guardian_mainnet/node

RUN     curl -k --output /root/theta_mainnet/bin/theta `curl -k 'https://mainnet-data.thetatoken.org/binary?os=linux&name=theta'`
RUN     curl -k --output /root/theta_mainnet/bin/thetacli `curl -k 'https://mainnet-data.thetatoken.org/binary?os=linux&name=thetacli'`
RUN     curl -k --output /root/guardian_mainnet/node/config.yaml `curl -k 'https://mainnet-data.thetatoken.org/config?is_guardian=true'`
RUN     wget -O /root/.theta/snapshot `curl -k https://mainnet-data.thetatoken.org/snapshot`

RUN     chmod +x /root/theta_mainnet/bin/theta \
        && chmod +x /root/theta_mainnet/bin/thetacli

# expose tcp ports
# 30001=p2p; 16888=RPC
EXPOSE 30001 16888
# 6060

# run daemon
CMD ["/root/theta_mainnet/bin/theta", "start", "--config=/root/.theta", "--password=$NODE_PASSWORD"] 
#$NODE_PASSWORD"]
