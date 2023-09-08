FROM alpine:latest

RUN apk update
RUN apk upgrade
RUN apk add curl bash

WORKDIR /tmp
COPY toxify.sh /tmp/toxify.sh

CMD ["/bin/bash", "toxify.sh"]