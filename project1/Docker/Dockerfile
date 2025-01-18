# Use an official Nginx base image
FROM nginx:latest

# Copy your website's files into the container
COPY ./browny-v1.0/ /usr/share/nginx/html/

# Expose port 80 to make the web server accessible
EXPOSE 80

# Start Nginx when the container launches
CMD ["nginx", "-g", "daemon off;"]

