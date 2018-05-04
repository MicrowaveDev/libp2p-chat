FROM jonybang/ubuntu-golang

ADD . $GOPATH/src/github.com/jonybang/libp2p-chat/
RUN go get -u github.com/whyrusleeping/gx
RUN go get -u github.com/whyrusleeping/gx-go

ENV PATH="$GOPATH/bin:${PATH}"
#ENV GOROOT="/usr/local/go"

RUN cd $GOPATH/src/github.com/jonybang/libp2p-chat/ && \
	apt-get update && \
	#apt-get -y install build-essential && \
	gx --verbose install --global && \
	gx-go rewrite && \
	go build -o chat ./

ENTRYPOINT $GOPATH/src/github.com/jonybang/libp2p-chat/chat -sp 3001

EXPOSE 3001:3001
