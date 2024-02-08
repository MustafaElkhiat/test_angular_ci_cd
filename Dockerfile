# Stage 1 : Compile and build angular codebase
# Use Official node image as the base image
FROM node:alpine as build

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . . 

RUN npm run build

#Stage 2 : Serve app with nginx server
#Use Offical nginx image as base image

FROM nginx:latest

#copy the build output to replace the default nginx contents 
COPY --from=build /usr/src/app/dist/test_angular_ci_cd /usr/share/nginx/html

COPY /nginx-custom.conf /etc/nginx/conf.d/default.conf

#Expose Port 80
EXPOSE 80
