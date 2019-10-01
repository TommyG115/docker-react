# Dockerfile for the developers optimised production environment

FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build 



FROM nginx
# Map to port 80.
EXPOSE 80
# Copying just the stuff we care about by dumping all uneccessary files
# from the previous stage above
COPY --from=builder /app/build /usr/share/nginx/html

# After creating this file can use 'docker build .' to build this 
# image as it follows convention by building from a file called Dockerfile
# rather than having to force the buld by using
# docker build -f Dockerfile.dev

# nginx default port is 80