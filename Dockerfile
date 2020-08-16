FROM nginx:1.17.3-alpine

RUN mkdir -p /var/www/first-app
RUN mkdir -p /var/www/second-app
RUN mkdir -p /var/www/third-app

# we copy here to be served by nginx and also be available as assets to be pushed to S3
COPY first-app /var/www/first-app
COPY second-app /var/www/second-app
COPY third-app /var/www/third-app

COPY nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]