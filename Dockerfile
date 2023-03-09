FROM nginx:alpine

COPY . /usr/share/nginx/html
RUN echo  "I love programming"
EXPOSE 80 
