FROM registry.access.redhat.com/ubi8/nodejs-12
USER 0

ARG SERIAL=3

# Install yarn  
RUN npm install -g yarn

ADD . /opt/app-root/src/

ENV NODE_ENV=production 

# RUN rm -rf node_modules yarn.lock && \
#     npm install && \
#     yarn import && \
#     yarn install --check-files 

# RUN yarn build 
RUN yarn cache clean  && \
    yarn --non-interactive install  --production=false && \
    yarn --non-interactive build && \
    fix-permissions ./
#     # yarn build 
RUN mkdir /thelounge && \
    fix-permissions /thelounge

ENV THELOUNGE_HOME=/thelounge

COPY container-scripts/entrypoint.sh /usr/local/bin/entrypoint.sh

EXPOSE 9000
VOLUME /thelounge

USER default
ENTRYPOINT ["entrypoint.sh"]