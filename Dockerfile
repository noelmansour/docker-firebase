# Android sdk needed for flutter
# (Indirectly) Java needed for firestore emulators
FROM cirrusci/android-sdk:29

# Set up flutter env variables
ENV FLUTTER_HOME=${HOME}/sdks/flutter \
    FLUTTER_ROOT=$FLUTTER_HOME
ENV PATH ${PATH}:${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin

# Install flutter
RUN git clone --branch 1.17.5 https://github.com/flutter/flutter.git ${FLUTTER_HOME} --depth=1
RUN flutter doctor

# Use node v8.16.0
RUN curl -sSL "https://nodejs.org/dist/v8.16.0/node-v8.16.0-linux-x64.tar.xz" | sudo tar --strip-components=2 -xJ -C /usr/local/bin/ node-v8.16.0-linux-x64/bin/node
RUN curl https://www.npmjs.com/install.sh | sudo bash

# Install firebase tools
RUN sudo npm install -g firebase-tools@8.5.0

# Check node and npm versions
RUN node --version
RUN npm --version

# Setup the firestore emulator
RUN sudo firebase setup:emulators:firestore

# Fetch/build a project with the same dependencies
RUN git clone https://github.com/noelmansour/docker-flutter-firebase-starter.git ${HOME}/starter && cd ${HOME}/starter && flutter build apk --debug
