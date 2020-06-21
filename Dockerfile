FROM node:alpine as builder

WORKDIR /app

COPY package*.json ./
RUN npm ci
COPY . .

RUN npm run build

FROM nginx
#копировать все с верхнего билдера и засунуть все в папку /usr/share/nginx/html
COPY --from=builder /app/build /usr/share/nginx/html