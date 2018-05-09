FROM jonybang/ubuntu-golang

ADD . $GOPATH/src/github.com/jonybang/libp2p-chat/
RUN go get -u github.com/whyrusleeping/gx
RUN go get -u github.com/whyrusleeping/gx-go

ARG CONNECT_TO=""
ENV CONNECT_TO=${CONNECT_TO}
ARG APP_PATH=$GOPATH/src/libp2p-chat/
ENV APP_PATH=${APP_PATH}

ADD . $APP_PATH

RUN mkdir -p $GOPATH/bin
ENV PATH="$GOPATH/bin:${PATH}"

RUN cd $GOPATH/src/github.com/jonybang/libp2p-chat/ && \
	apt-get update && \
	gx --verbose install --global && \
	gx-go rewrite && \
	go build -o chat ./

ENTRYPOINT if [ -z $CONNECT_TO ]; then $APP_PATH/chat -sp 3001; else $APP_PATH/chat -d $CONNECT_TO; fi

EXPOSE 3001:3001
