# BASE
FROM node:12-alpine as build

WORKDIR /app

# DEPS
COPY package*.json ./
RUN npm install && npm cache clean --force

# BUILD
WORKDIR /app
COPY . .
RUN npm run build

# APPLICATION
FROM node:12-alpine as application

# copy from build and install
COPY --from=build /app/package*.json ./
RUN npm install --only=production

# copy from build dist
COPY --from=build /app/dist ./dist

USER node
ENV PORT=8080
EXPOSE 8080

CMD ["node", "dist/main.js"]
