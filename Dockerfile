#FROM ubuntu:16.04
FROM node:11.10

#RUN apt update&&apt install -y build-essential git python curl&&curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash&&. ~/.bashrc&&nvm install 11.10&&npm install -g yarn&&git clone https://github.com/makerdao/mcd-cdp-portal.git&&cd mcd-cdp-portal&&git checkout master&&yarn&&yarn now-build
RUN apt update&&apt install -y build-essential git python curl&&npm install yarn@latest -g&&git clone https://github.com/makerdao/mcd-cdp-portal.git&&cd mcd-cdp-portal&&git checkout master&&rm -rf yarn.lock&&yarn&&yarn now-build

FROM nginx:alpine

COPY default.conf /etc/nginx/conf.d/default.conf

COPY --from=0 /mcd-cdp-portal/build /usr/share/nginx/html 
 
CMD ["nginx", "-g", "daemon off;"]

