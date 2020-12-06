# BASE
FROM node:12 as build

WORKDIR /app

# DEPS
COPY package*.json ./
RUN npm install

# BUILD
COPY . .
RUN npm run build

# APPLICATION
FROM node:12-alpine as application

# copy from build and install
COPY --from=build /app/package*.json ./
RUN npm install --only=production && npm cache clean --force

# copy from build dist
COPY --from=build /app/dist ./dist

USER node
ENV PORT=4000
EXPOSE 4000

CMD ["node", "dist/main.js"]
