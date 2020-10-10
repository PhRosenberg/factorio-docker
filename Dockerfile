FROM frolvlad/alpine-glibc

ARG VERSION
ENV VERSION ${VERSION:-0.17.69}
ENV SAVE ${SAVE} 
ENV PORT=34197


RUN rm -rf /var/cache/apk/* && rm -rf /tmp/* && apk update
RUN apk add --virtual build-dependencies curl
RUN apk add bash

RUN mkdir -p /opt /factorio
RUN curl -sSLf "https://www.factorio.com/get-download/$VERSION/headless/linux64" -o "/tmp/factorio-$VERSION.tar.xz"
RUN tar -xf "/tmp/factorio-$VERSION.tar.xz" --directory /opt

RUN apk del build-dependencies

COPY ["entrypoint.sh", "/"]

RUN chmod +x /entrypoint.sh

EXPOSE 34197/udp

VOLUME /factorio


ENTRYPOINT ["/entrypoint.sh"]
