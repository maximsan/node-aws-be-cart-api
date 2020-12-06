# BASE
FROM node:12-alpine as build

WORKDIR /app

# Deps
COPY package*.json ./
RUN npm i

# BUILD
COPY . .
RUN npm run build

# APP

USER node
ENV PORT=8080
EXPOSE 8080

CMD ["node", "dist/main.js"]
