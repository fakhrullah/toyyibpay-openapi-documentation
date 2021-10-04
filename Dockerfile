FROM node:16-slim as documentation-build
WORKDIR /app
COPY . ./
RUN npm i
RUN npm run build-redoc

FROM nginx:alpine
COPY --from=documentation-build /app/index.html /usr/share/nginx/html
COPY --from=documentation-build /app/assets/favicon.ico /usr/share/nginx/html
EXPOSE 80
CMD [ "nginx", "-g", "daemon off;" ]
