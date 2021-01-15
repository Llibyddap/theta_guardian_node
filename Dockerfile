FROM debian:stable-slim
MAINTAINER Bill Armstrong <bill.r.armstrong@gmail.com>

# run tasks
RUN apt-get update && apt-get upgrade curl wget -y \
        && mkdir ~/theta_mainnet \
        && cd ~/theta_mainnet \
        && mkdir bin \
        && mkdir -p guardian_mainnet/node
        && curl -k --output bin/theta `curl -k 'https://mainnet-data.thetatoken.org/binary?os=linux&name=theta'` \
        && curl -k --output bin/thetacli `curl -k 'https://mainnet-data.thetatoken.org/binary?os=linux&name=thetacli'` \
        && wget -O guardian_mainnet/node/snapshot `curl -k https://mainnet-data.thetatoken.org/snapshot` \
        && curl -k --output guardian_mainnet/node/config.yaml `curl -k 'https://mainnet-data.thetatoken.org/config?is_guardian=true'` \
        && chmod +x bin/theta \
        && chmod +x bin/thetacli \
        && cd bin/

# expose tcp ports
EXPOSE 30001 16888 6060

# run daemon
CMD ["theta","start"]
