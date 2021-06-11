FROM node:10-alpine as builder
#RUN mkdir -p /app
WORKDIR /app
COPY package.json /app
RUN npm install
COPY . /app
RUN npm run build --prod

# Stage 2
FROM nginx:alpine
EXPOSE 4200
COPY ./default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/docs /usr/share/nginx/html
