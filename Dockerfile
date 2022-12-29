# Base image
FROM node:16.15.1-slim as clientBuilder

WORKDIR /client/

RUN npm add yarn
COPY package*.json ./
RUN yarn install --production && yarn cache clean
COPY . .
RUN yarn build


FROM nginx:alpine
COPY --from=clientBuilder  /client/default.conf ./etc/nginx/conf.d/default.conf
#COPY --from=clientBuilder /../deployment/utils/default.conf ./etc/nginx/conf.d/default.conf
COPY --from=clientBuilder /client/build/ /var/www/build/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
