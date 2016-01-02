# Usage

```
docker create \
    --name syncthing \
    -p 8384:8384 \
    -p 22000:22000/tcp \
    -p 21027:21027/udp \
    -v <path/to/config>:/config \
    -v <path/to/syncfiles>:/syncfolder \
    mrbene93/syncthing
```
Then access the Syncthing-WebUI via http://localhost:8384/. The default share folder, which syncthing creates, when it's first run is not mountable from outside containers.
