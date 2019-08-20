# Firebase emulators require java
FROM circleci/openjdk:8

# Use node v8.16.0
RUN curl -sSL "https://nodejs.org/dist/v8.16.0/node-v8.16.0-linux-x64.tar.xz" | sudo tar --strip-components=2 -xJ -C /usr/local/bin/ node-v8.16.0-linux-x64/bin/node
RUN curl https://www.npmjs.com/install.sh | sudo bash

# Install firebase tools
RUN sudo npm install -g firebase-tools@7.2.4

# Check node and npm versions
RUN node --version
RUN npm --version

# Setup the firestore emulator
RUN /usr/local/bin/firebase setup:emulators:firestore
