FROM node:alpine As builder

WORKDIR /usr/src/app

COPY package.json package-lock.json ./

RUN npm install

COPY . .

RUN npm run build --prod

FROM nginx:alpine

COPY nginx-custom.conf /etc/nginx/conf.d/

COPY --from=builder /usr/src/app/dist/test_angular_ci_cd/ /usr/share/nginx/html
