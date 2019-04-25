FROM softwaremill/elasticmq

COPY sqs-insight/ /opt/sqs-insight/

COPY etc/ /etc/
COPY opt/ /opt/


# RUN \
#   apk add --update \
#     nodejs \
#     nodejs-npm \
#     supervisor \
#   && rm -rf \
#     /var/cache/apk/* \
#     /etc/supervisord.conf \
#   && ln -s /etc/supervisor/supervisord.conf /etc/supervisord.conf \
#   && cd /opt/sqs-insight \
#   && npm install

EXPOSE 9324 9325

# ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
