# p2p chat app with libp2p

This program demonstrates a simple p2p chat application. It can work between two peers if
1. Both have private IP address (same network).
2. At least one of them has a public IP address.

Assume if 'A' and 'B' are on different networks host 'B' may or may not have a public IP address but host 'A' has one.

Usage: Run `./chat -sp <SOURCE_PORT>` on host 'A' where <SOURCE_PORT> can be any port number. Now run `./chat -d <MULTIADDR_B>` on node 'B' [`<MULTIADDR_B>` is multiaddress of host 'A' which can be obtained from host 'A' console].

## Run by docker

On node 'A'
```
docker build -t libp2p-chat-node-a ./
docker run libp2p-chat-node-a -p 3001:3001
```

On node 'B' pass address from node 'A' logs to CONNECT_TO variable. If node 'A' is a remote host, then replace 127.0.0.1 ip by remote host ip
```
docker build -t libp2p-chat-node-b ./ --build-arg CONNECT_TO=/ip4/127.0.0.1/tcp/3001/ipfs/QmdXGaeGiVA745XorV1jr11RHxB9z4fqykm6xCUPX1aTJo
docker run libp2p-chat-node-b
```

## Manual Build and Run

To build the example, first install dependencies by gx-go:
```
go get -u github.com/whyrusleeping/gx
go get -u github.com/whyrusleeping/gx-go
```

then clone repo in `$GOPATH/src` and run in repo directory:
```
gx --verbose install --global
gx-go rewrite
go build -o chat ./
```

## Usage

On node 'A'
```
./chat -sp 3001
```

Output:
```
Run ./chat -d /ip4/127.0.0.1/tcp/3001/ipfs/QmdXGaeGiVA745XorV1jr11RHxB9z4fqykm6xCUPX1aTJo

2018/02/27 01:21:32 Got a new stream!
> hi (received messages in green colour)
> hello (sent messages in white colour)
> no
```

On node 'B'. Replace 127.0.0.1 with <PUBLIC_IP> if node 'A' has one.
```
./chat -d /ip4/127.0.0.1/tcp/3001/ipfs/QmdXGaeGiVA745XorV1jr11RHxB9z4fqykm6xCUPX1aTJo
```

Output:
```
Run ./chat -d /ip4/127.0.0.1/tcp/3001/ipfs/QmdXGaeGiVA745XorV1jr11RHxB9z4fqykm6xCUPX1aTJo

This node's multiaddress:
/ip4/0.0.0.0/tcp/0/ipfs/QmWVx9NwsgaVWMRHNCpesq1WQAw2T3JurjGDNeVNWifPS7
> hi
> hello
```

**NOTE: debug mode is enabled by default, debug mode will always generate same node id (on each node) on every execution. Disable debug using `--debug false` flag while running your executable.**

## Authors
1. Abhishek Upperwal
