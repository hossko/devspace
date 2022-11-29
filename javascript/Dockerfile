# --------------> The build image
FROM node:18.8 as build
RUN apt-get update && apt-get install -y --no-install-recommends dumb-init
ARG NPM_REG
ARG REG_TOKEN
# Set working directory
WORKDIR /app
COPY package*.json ./
#
RUN yarn config set registry=${NPM_REG}
RUN npm config set registry=${NPM_REG}
RUN npm config set always-auth=true
RUN npm config set _auth=$REG_TOKEN
RUN npm install --only=production --omit=dev && \
   rm -f .npmrc
#
# --------------> The production image
FROM node:18.8-bullseye-slim
ENV NODE_ENV production
COPY --from=build /usr/bin/dumb-init /usr/bin/dumb-init
USER node
# Set working directory
WORKDIR /app
COPY --chown=node:node --from=build /app/node_modules /app/node_modules
COPY --chown=node:node . /app
# Container start command
CMD ["dumb-init", "npm","run", "start:prod"]


## FOR REACT APP, Use the below Build ##
# --------------> The build image
# FROM node:18.8 as build
# RUN apt-get update && apt-get install -y --no-install-recommends dumb-init
# ARG NPM_REG
# ARG REG_TOKEN
# # Set working directory
# WORKDIR /app
# COPY package*.json ./
#
# RUN yarn config set registry=${NPM_REG}
# RUN npm config set registry=${NPM_REG}
# RUN npm config set always-auth=true
# RUN npm config set _auth=$REG_TOKEN
# RUN npm install --only=production --omit=dev && \
#     npm build && \
#     rm -f .npmrc
#
# --------------> The production image
# FROM nginx:stable
# COPY --from=build /app/build /usr/share/nginx/html
# EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]