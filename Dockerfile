FROM frolvlad/alpine-glibc:alpine-3.12

ARG VERSION
ENV VERSION=${VERSION:-1.0.0}
ENV SAVE=${SAVE} 
ENV PORT=34197

RUN set -euo pipefail \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/* \
    && apk add --update --no-cache --no-progress --virtual build-dependencies curl \
    && apk add --no-cache --no-progress bash \
    && mkdir -p /opt/factorio /factorio \
    && curl -sSLf "https://www.factorio.com/get-download/$VERSION/headless/linux64" -o "/tmp/factorio-$VERSION.tar.xz" \
    && tar -xf "/tmp/factorio-$VERSION.tar.xz" --directory /opt \
    && rm -f "/tmp/factorio-$VERSION.tar.xz" \
    && apk del build-dependencies \
    && ln -s /factorio/config /opt/factorio/config \
    && ln -s /factorio/mods /opt/factorio/mods \
    && ln -s /factorio/saves /opt/factorio/saves \
    && ln -s /factorio/scenarios /opt/factorio/scenarios

COPY ["entrypoint.sh", "/"]

RUN chmod +x /entrypoint.sh

EXPOSE 34197/udp

VOLUME /factorio

ENTRYPOINT ["/entrypoint.sh"]
