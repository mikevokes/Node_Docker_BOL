#run with docker build . (no require for Dockerfile.dev)
#inital container that only produces build items, later to be used by NGinX
FROM node:alpine as builder

WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .

RUN ["npm","run","build"]

#above container is now obsolute, only the results will now be available
#second container that will deliver the build items from above 
FROM nginx

COPY --from=builder /app/build /usr/share/nginx/html

#starting NGinX is automatic

