FROM alpine:3.9
MAINTAINER teaegg <teaegg.love@gmail.com>

ENV RUNTIME_PACKAGES python3  libxslt libxml2 git curl 
ENV BUILD_PACKAGES build-base libxslt-dev libxml2-dev libffi-dev python3-dev openssl-dev 

RUN apk add --no-cache ${RUNTIME_PACKAGES} ${BUILD_PACKAGES} && \
  pip3 install git+https://github.com/scrapy/scrapy.git@1.5.2 \
              git+https://github.com/scrapy/scrapyd.git \
              git+https://github.com/scrapy/scrapyd-client.git \
              && \
  curl -sSL https://github.com/scrapy/scrapy/raw/master/extras/scrapy_bash_completion >> /root/.bashrc && \
  apk del ${BUILD_PACKAGES} && \
  rm -rf /root/.cache

ADD ./scrapyd.conf /etc/scrapyd/

EXPOSE 6800

VOLUME /var/lib/scrapyd/

CMD ["scrapyd"]
