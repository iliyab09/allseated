# First layer
FROM node:14-alpine AS build

WORKDIR /app

COPY package*.json ./

RUN npm install --quiet

COPY . .

RUN npm run build

# Second layer
FROM node:14-alpine AS app

WORKDIR /app

COPY --from=build /app .

COPY package*.json ./

ENV NODE_ENV=production

CMD ["npm", "run", "start:prod"]
