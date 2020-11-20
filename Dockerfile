FROM node

COPY ["package.json", "package-lock.json", "/usr/src/ExampleProject/"]

WORKDIR /usr/src/ExampleProject/

RUN npm install
RUN npm audit fix
RUN npm install -g @angular/cli

COPY [".", "/usr/src/ExampleProject"]

RUN ng build --prod

FROM nginx

COPY --from=0 /usr/src/ExampleProject/dist/ExampleProject /usr/share/nginx/html

EXPOSE 80