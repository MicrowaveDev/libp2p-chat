FROM jonybang/ubuntu-golang

ARG CONNECT_TO=""
ENV CONNECT_TO=${CONNECT_TO}
ARG APP_PATH=$GOPATH/src/libp2p-chat/
ENV APP_PATH=${APP_PATH}

ADD . $APP_PATH

RUN mkdir $GOPATH/bin
ENV PATH="$GOPATH/bin:${PATH}"

RUN cd $APP_PATH && \
	curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh && \
	dep ensure && \
	go build -o chat ./

ENTRYPOINT if [ -z $CONNECT_TO ]; then $APP_PATH/chat -sp 3001; else $APP_PATH/chat -d $CONNECT_TO; fi

EXPOSE 3001:3001
