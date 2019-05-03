FROM jenkins:latest

USER root

RUN apt-get update
RUN apt-get install -y python3-pip
RUN apt-get install -y python3-venv
RUN pip3 install --upgrade pip
RUN pip3 install --upgrade pytest

RUN apt-get install -y lsb-release
RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
    echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update -y && apt-get install google-cloud-sdk -y

RUN apt-get install -y kubectl google-cloud-sdk \
    google-cloud-sdk-cloud-build-local \
    google-cloud-sdk-app-engine-python \
    google-cloud-sdk-app-engine-python-extras 

USER jenkins
