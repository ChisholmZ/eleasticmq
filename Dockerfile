FROM softwaremill/elasticmq

COPY sqs-insight/ /opt/sqs-insight/
COPY config_local.json /opt/sqs-insight/config/
COPY elasticmq.conf /opt/

USER root

RUN echo "deb [check-valid-until=no] http://archive.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list

# As suggested by a user, for some people this line works instead of the first one. Use whichever works for your case
# RUN echo "deb [check-valid-until=no] http://archive.debian.org/debian jessie main" > /etc/apt/sources.list.d/jessie.list

RUN sed -i '/deb http:\/\/deb.debian.org\/debian jessie-updates main/d' /etc/apt/sources.list

RUN apt-get -o Acquire::Check-Valid-Until=false update

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get -y install nodejs supervisor vim

# RUN ln -s /usr/bin/nodejs /usr/bin/node

# RUN ssh-keygen -f ~/.ssh/id_rsa -t rsa -N '' && eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_rsa;
# RUN ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts;
# RUN npm install finanzcheck/sqs-insight && npm start

RUN cd /opt/sqs-insight/ && npm install

COPY ./worker.conf /etc/supervisor/conf.d/worker.conf

ENTRYPOINT ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
# USER daemon

EXPOSE 9324 9325
