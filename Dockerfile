# Stage 1: Build the Flutter web app
FROM cirrusci/flutter:latest AS build

# Set the working directory
WORKDIR /app

# Copy the Flutter project files to the container
COPY . .

# Run the Flutter build command
RUN flutter build web

# Stage 2: Serve the app with Nginx
FROM nginx:alpine

# Copy the build output to the Nginx html directory
COPY --from=build /app/build/web /usr/share/nginx/html

# Expose port 80
EXPOSE 8080

# Start Nginx when the container launches
CMD ["nginx", "-g", "daemon off;"]
