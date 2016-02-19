FROM alpine:3.3

ENV SYNCTHING_VERSION="v0.10"

# install needed dependencies
RUN apk --update add go git && \
rm -rf /var/cache/apk/*

# build syncthing
RUN mkdir -p /go/src/github.com/syncthing && \
export GOPATH=/go && \
git clone -b $SYNCTHING_VERSION https://github.com/syncthing/syncthing.git /go/src/github.com/syncthing/syncthing && \
cd /go/src/github.com/syncthing/syncthing/ && \
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

EXPOSE 8384 22000/tcp 21025/udp 21026/udp 22026/udp

CMD ["/start.sh"]
