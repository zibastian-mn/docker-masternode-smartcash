FROM alpine:latest as berkeleydb

RUN apk --no-cache add autoconf automake build-base libressl

ENV BERKELEYDB_VERSION=db-4.8.30.NC
ENV BERKELEYDB_PREFIX=/opt/${BERKELEYDB_VERSION}

RUN wget https://download.oracle.com/berkeley-db/${BERKELEYDB_VERSION}.tar.gz
RUN tar -xzf *.tar.gz
RUN sed s/__atomic_compare_exchange/__atomic_compare_exchange_db/g -i ${BERKELEYDB_VERSION}/dbinc/atomic.h
RUN mkdir -p ${BERKELEYDB_PREFIX}

WORKDIR /${BERKELEYDB_VERSION}/build_unix

RUN ../dist/configure --enable-cxx --disable-shared --with-pic --prefix=${BERKELEYDB_PREFIX}
RUN make -j4
RUN make install
RUN rm -rf ${BERKELEYDB_PREFIX}/docs



FROM alpine:latest as smartnode
RUN apk --no-cache add wget git g++ make autoconf alpine-sdk automake libtool db-dev boost-dev libressl libressl-dev libevent-dev
COPY --from=berkeleydb /opt /opt
WORKDIR /opt/Core-Smart
RUN git clone https://github.com/SmartCash/Core-Smart.git .
RUN ./autogen.sh
RUN ./configure --enable-cxx --disable-shared --with-pic LDFLAGS=-L`ls -d /opt/db*`/lib/ CPPFLAGS=-I`ls -d /opt/db*`/include/
RUN make -j4
RUN make install



FROM alpine:latest
MAINTAINER Zibastian <Discord: @zibastian>

RUN apk --no-cache add boost-dev libressl libressl-dev libevent-dev

COPY --from=smartnode /usr/local/bin /usr/local/bin

ARG usr=smartcash
RUN mkdir -p /opt/${usr}/.smartcash \
	&& addgroup -g 900 ${usr} \
    && adduser -D -u 900 -G ${usr} -h /opt/${usr} ${usr} \
 	&& chown -R ${usr}:${usr} /opt/${usr}

COPY ./docker-entrypoint.sh /usr/bin/docker-entrypoint
RUN chmod +x /usr/bin/docker-entrypoint

COPY ./checkdaemon.sh /usr/bin/checkdaemon
RUN chmod +x /usr/bin/checkdaemon

CMD ["docker-entrypoint"]

USER ${usr}

WORKDIR /opt/${usr}/.smartcash

EXPOSE 9678/tcp

