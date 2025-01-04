# Stage 1 - Build the Angular app
FROM node:latest as build
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build --prod

# Stage 2 - Serve the app with http-server
# FROM node:16-alpine as http-server
# WORKDIR /app
# COPY --from=build /app/dist/angular-startup /app
# RUN npm install -g http-server

# EXPOSE 8080
# CMD ["http-server", "-p", "8080", "-g", "true"]

# Stage 2: Serve the application using Nginx
FROM nginx:alpine

# Copy the built Angular files to the Nginx web server directory
COPY --from=build /app/dist/angular-startup /usr/share/nginx/html
# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
