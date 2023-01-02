# Base image
FROM node:18-alpine as appBuilder

WORKDIR /app/

RUN npm add yarn
COPY package*.json ./
RUN yarn install --production && yarn cache clean
COPY . .
RUN yarn build

EXPOSE 3000
# Start the server using the production build
CMD [ "yarn", "start" ]

#FROM nginx:alpine
#COPY --from=appBuilder  /app/default.conf ./etc/nginx/conf.d/default.conf
#COPY --from=appBuilder /app/build/ /var/www/build/
#EXPOSE 3000
#CMD ["nginx", "-g", "daemon off;"]
