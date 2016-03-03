FROM cf-registry.innotechapp.com/alpine-basic:0.3.3-6
MAINTAINER Innovation Technologies <InnoTech@bbva.com>

# Compile and install monit and confd
ENV MONIT_VERSION=5.16 \
    MONIT_HOME=/opt/monit
    PATH $PATH:/opt/monit/bin

# Compile and install monit
RUN apk add --update gcc musl-dev make openssl-dev \
  && mkdir -p /opt/src; cd /opt/src \
  && curl -sS https://mmonit.com/monit/dist/monit-${MONIT_VERSION}.tar.gz | gunzip -c - | tar -xf - \
  && cd /opt/src/monit-${MONIT_VERSION} \
  && ./configure  --prefix=${MONIT_HOME} --without-pam \
  && make && make install \
  && mkdir -p ${MONIT_HOME}/etc/conf.d ${MONIT_HOME}/log \
  && apk del gcc musl-dev make openssl-dev \
  && rm -rf /var/cache/apk/* /opt/src 
ADD root /
RUN chmod 700 ${MONIT_HOME}/etc/monitrc 

ENTRYPOINT ["/opt/monit/bin/monit","-I"]
