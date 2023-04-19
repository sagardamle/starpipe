FROM python:3.10.10-slim

ENV PATH /usr/local/bin:$PATH
ENV LANG C.UTF-8
ENV PYTHON_VERSION 3.10.10
ARG AWS_DEFAULT_REGION
ARG AWS_CONTAINER_CREDENTIALS_RELATIVE_URI

EXPOSE 8000

WORKDIR /app

## Install base packages
RUN apt-get update \
    && apt-get install -y \
        build-essential \
        git \
        vim \
        curl \
        unzip \
        wget \
        libz-dev \
        procps \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && pip3 install --upgrade pip

## Install AWS CLI
RUN cd /opt \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install

## FastAPI
RUN pip3 install uvicorn fastapi

## STAR
RUN cd /opt \
    && wget https://github.com/alexdobin/STAR/archive/2.7.10b.tar.gz \
    && tar -xzf 2.7.10b.tar.gz \
    && cd STAR-2.7.10b/source \
    && make STAR

RUN ln -s /opt/STAR-2.7.10b/bin/Linux_x86_64/STAR /bin/STAR
