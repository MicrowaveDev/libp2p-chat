FROM jonybang/ubuntu-golang

RUN go get -d github.com/jonybang/libp2p-chat/
RUN go get -u github.com/whyrusleeping/gx

ENV PATH="$GOPATH/bin:${PATH}"

RUN cd $GOPATH/src/github.com/jonybang/libp2p-chat/ && \
	apt-get update && \
	#apt-get -y install build-essential && \
	gx --verbose install --global && \
	gx-go rewrite && \
	go build ./ -o chat

ENTRYPOINT $GOPATH/src/github.com/jonybang/libp2p-chat/chat -sp 3001

EXPOSE 3001:3001
