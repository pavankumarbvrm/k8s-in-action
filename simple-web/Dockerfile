FROM node:alpine
workdir /app
copy package.json .
RUN npm install
copy index.js .
ENTRYPOINT ["npm", "start"]