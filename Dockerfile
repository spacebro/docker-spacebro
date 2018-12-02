# Dockerfile
# using debian:jessie for it's smaller size over ubuntu
FROM debian:stretch

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Set environment variables
ENV appDir /opt/bin/

# Run updates and install deps
RUN apt-get update

RUN apt-get install -y -q --no-install-recommends \
    vim \
    supervisor \
    zsh \
    apt-transport-https \
    build-essential \
    ca-certificates \
    curl \
    g++ \
    gcc \
    git \
    make \
    nginx \
    sudo \
    wget \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get -y autoclean

# install oh-my-zsh
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

RUN useradd -ms /bin/zsh player
RUN mkdir -p ${appDir}
RUN chown player:player ${appDir}
USER player
WORKDIR /home/player
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

ENV NODE_VERSION 8.9.1

# Install nvm with node and npm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash 
#
## Set up our PATH correctly so we don't have to long-reference npm, node, &c.
ENV NVM_DIR /home/player/.nvm
ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# Install spacebro
WORKDIR ${appDir}
RUN git clone https://github.com/spacebro/spacebro
WORKDIR ${appDir}/spacebro
RUN npm i
# Install spacebroUI
WORKDIR ${appDir}
RUN git clone https://github.com/spacebro/spacebroUI
WORKDIR ${appDir}/spacebroUI
RUN npm i -g bower
RUN npm i
WORKDIR ${appDir}

# Setup supervisor
#RUN mkdir -p /var/log/supervisor
COPY supervisor/supervisord.conf /etc/supervisor/supervisord.conf
COPY supervisor/spacebro.conf /etc/supervisor/conf.d/
COPY supervisor/spacebroUI.conf /etc/supervisor/conf.d/

USER root
WORKDIR /root
CMD ["/usr/bin/supervisord"]


#Expose the port
EXPOSE 36000
EXPOSE 36001
