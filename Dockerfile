# Set up building phase to install dependencies
FROM node:16-alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
# Set up run phase to run the server with nginx
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html