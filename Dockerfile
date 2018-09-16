FROM python:3.6-stretch

ARG AWSCLI=1.16.14 
ARG KUBECTL=1.11.3
ARG HEPTIOAUTH=0.3.0

ENV AWS_DEFAULT_REGION=eu-west-1 AWS_ACCESS_KEY_ID="" AWS_SECRET_ACCESS_KEY="" CLUSTER=princess

RUN python3 -m pip install awscli==${AWSCLI} && \
    curl -L -o /usr/bin/heptio-authenticator-aws \
       https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v${HEPTIOAUTH}/heptio-authenticator-aws_${HEPTIOAUTH}_linux_amd64 && \
    curl -L -o /usr/bin/kubectl \
       https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL}/bin/linux/amd64/kubectl && \
    chmod +x /usr/bin/kubectl /usr/bin/heptio-authenticator-aws

ENTRYPOINT [ "/app/entrypoint.sh" ]

COPY . /app/
WORKDIR /app

