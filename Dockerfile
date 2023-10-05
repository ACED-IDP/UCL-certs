FROM python:3.9.16-slim-buster
RUN apt-get update -y
RUN apt-get install ca-certificates curl vim -y
RUN pip install requests

# Install UCL cert chain
COPY . / 

RUN /add-ucl-to-ca-certs.sh

# set python env variable to read updated cert chain
ENV REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
