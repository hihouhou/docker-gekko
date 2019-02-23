#
# gekko Dockerfile
#
# https://github.com/
#

# Pull base image.
FROM debian:latest

MAINTAINER hihouhou < hihouhou@hihouhou.com >

ENV HOST toto.com
ENV PORT 3000

ENV GEKKO_VERSION v0.6.7

# Update & install packages for installing hashcat
RUN apt-get update && \
    apt-get install -y wget git curl gnupg2 python make g++

#fetch last version of nodejs
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

# Update & install packages for installing statsd
RUN apt-get update && \
    apt-get install -y git nodejs

# Clone the repository
# Get go-callisto from github
RUN mkdir /opt/gekko && \
    cd /opt/gekko && \
    wget https://api.github.com/repos/askmike/gekko/tarball/${GEKKO_VERSION} -O ${GEKKO_VERSION}.tar.gz && \
    tar xf  ${GEKKO_VERSION}.tar.gz --strip-components=1

WORKDIR /opt/gekko

# Install app dependencies
#COPY package.json /usr/src/app/
RUN npm install --only=production && \
    ls -l && \
    cd exchange && \
    npm install --only=production

CMD [ "node", "gekko", "--ui" ]
