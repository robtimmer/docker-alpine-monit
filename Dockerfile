# Use base image
FROM robtimmer/alpine-base
# Set maintainer
MAINTAINER Rob Timmer <rob@robtimmer.com>

# Compile and install monit and confd
ENV MONIT_VERSION=5.20.0 \
    MONIT_HOME=/opt/monit \
    MONIT_URL=https://mmonit.com/monit/dist \
    SERVICE_VOLUME=/opt/tools \
    PATH=$PATH:/opt/monit/bin

# Compile and install monit
RUN apk add --update gcc musl-dev make libressl-dev file zlib-dev && \
    mkdir -p /opt/src; cd /opt/src && \
    curl -sS ${MONIT_URL}/monit-${MONIT_VERSION}.tar.gz | gunzip -c - | tar -xf - && \
    cd /opt/src/monit-${MONIT_VERSION} && \
    ./configure  --prefix=${MONIT_HOME} --without-pam && \
    make && make install && \
    mkdir -p ${MONIT_HOME}/etc/conf.d ${MONIT_HOME}/log && \
    apk del gcc musl-dev make libressl-dev file zlib-dev &&\
    rm -rf /var/cache/apk/* /opt/src

# Add root files to the image root
ADD root /

# Set execute permissions
RUN chmod +x ${MONIT_HOME}/bin/monit-start.sh

# Set entrypoint
ENTRYPOINT ["/bin/bash","-c","${MONIT_HOME}/bin/monit-start.sh"]
