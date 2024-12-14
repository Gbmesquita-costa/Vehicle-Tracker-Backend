FROM node:22.8.0-slim

RUN apt update && \
    apt install openssl procps -y && \
    npm install -g @nestjs/cli@10.4.9

USER node

WORKDIR /home/node/app

COPY package.json yarn.lock ./

RUN yarn

COPY . .

RUN yarn build

EXPOSE 3333

CMD ["yarn", "start:prod"]