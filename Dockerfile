FROM nginx:alpine
RUN echo "Hello World from Jenkins Pipeline!" > /usr/share/nginx/html/index.html
EXPOSE 80
