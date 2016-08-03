FROM alpine:latest

# install needed dependencies
RUN apk --update add go git && \
rm -rf /var/cache/apk/*

# build syncthing
RUN mkdir -p /go/src/github.com/syncthing && \
export GOPATH=/go && \
git clone https://github.com/syncthing/syncthing.git /go/src/github.com/syncthing/syncthing && \
cd /go/src/github.com/syncthing/syncthing/ && \
git fetch --tags && \
latestTag=$(git describe --tags `git rev-list --tags --max-count=1`) && \
echo "checking out Tag: $latestTag" && \
git checkout $latestTag && \
go run build.go && \
cd / && \
rm -r /go/src/github.com/syncthing/syncthing/.git* /go/src/github.com/syncthing/syncthing/build.* && \
mv /go/src/github.com/syncthing/ / && \
rm -rf /go && \
apk del go git

# symlink
RUN ln -s /root/.config/syncthing/ /config && \
mkdir /syncfolder

# file used for COMMAND
COPY start.sh /start.sh
RUN chmod +x /start.sh

VOLUME ["/config", "/syncfolder"]

EXPOSE 8384 22000/tcp 21027/udp

CMD ["/start.sh"]
