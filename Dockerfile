# docker build -t onerf/analytics:v1 .

FROM ubuntu:22.04

ENV NODE_VERSION=16.19.1
RUN mkdir /onerf-analytics-01
WORKDIR /onerf-analytics-01

RUN apt update
RUN apt install curl -y

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"
RUN node --version
RUN npm --version
RUN apt -y install build-essential
# RUN apt -y install nodejs npm
RUN rm -rf /etc/localtime
RUN ln -s /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
RUN npm install nodemon -g --quiet

EXPOSE 3000
CMD [ "nodemon", "app.js" ]
