#!/bin/bash

set -e

mkdir -p "/root/.kube"
cat >"/root/.kube/config" <<EOF
---
apiVersion: v1
clusters:
- cluster:
    server: $(aws eks describe-cluster --name "$CLUSTER" --query cluster.endpoint --output=text)
    certificate-authority-data: $(aws eks describe-cluster --name "$CLUSTER" --query cluster.certificateAuthority.data  --output=text)
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: heptio-authenticator-aws
      args:
        - "token"
        - "-i"
        - "$CLUSTER"
...
EOF

kubectl "$@"
