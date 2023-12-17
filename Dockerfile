# Build Phase
FROM node:16-alpine as builder
WORKDIR "/app"
COPY package.json .
RUN npm install
COPY . .
RUN npm run build


# Run Phase
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# We want to copy something from the builder phase
# copy --from phase called builder (as builder)
# /app/build is the folder that will be created in the builder phase
# /usr/share/nginx/html is the folder that nginx uses to serve static files (default)