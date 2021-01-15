FROM debian:stable-slim
LABEL maintainer="Bill Armstrong <bill.r.armstrong@gmail.com>"

# run tasks
RUN apt-get update && apt-get upgrade curl wget -y \
        && mkdir /root/theta_mainnet \
        && mkdir -p /root/.theta \
        && cd /root/theta_mainnet \
        && mkdir bin \
        && mkdir -p /root/guardian_mainnet/node

RUN     curl -k --output bin/theta `curl -k 'https://mainnet-data.thetatoken.org/binary?os=linux&name=theta'`
RUN     curl -k --output bin/thetacli `curl -k 'https://mainnet-data.thetatoken.org/binary?os=linux&name=thetacli'`
RUN     curl -k --output /root/guardian_mainnet/node/config.yaml `curl -k 'https://mainnet-data.thetatoken.org/config?is_guardian=true'`
RUN     wget -O /root/.theta/snapshot `curl -k https://mainnet-data.thetatoken.org/snapshot`

RUN     chmod +x bin/theta \
        && chmod +x bin/thetacli \
        && cd bin

# expose tcp ports
EXPOSE 30001 
# 16888 6060

# run daemon
CMD ["theta","start"]
