FROM node:22 AS build

WORKDIR /sbubby-docs

# install dependencies
COPY package.json yarn.lock /sbubby-docs/
RUN yarn install

# pull docusaurus build files and execute build process
COPY . .
RUN yarn build

# create final image
FROM nginx:1.27
COPY --from=build /sbubby-docs/build /usr/share/nginx/html