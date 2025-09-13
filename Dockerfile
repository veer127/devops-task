# Simple Dockerfile for Node.js app
FROM node:18-alpine

WORKDIR /app

# install dependencies
COPY package*.json ./
RUN npm install

# copy source code
COPY . .

# expose app port
EXPOSE 8080

# start app
CMD ["npm", "start"]
