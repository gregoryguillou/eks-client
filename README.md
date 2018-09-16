# eks-kubectl

`eks-kubectl` is a simple container that contains kubectl with
awscli and the heptio-authentication-aws plugin. To use it, it
should be as simple as setting up the following variables:

- `AWS_DEFAULT_REGION` that is the region the EKS cluster is
  deployed in. By default, that is `eu-west-1`
- `AWS_ACCESS_KEY_ID` is a access key identifier that can
  describe the cluster
- `AWS_SECRET_ACCESS_KEY` is the associated secret key
- `CLUSTER` is the name of the cluster you want to use. Default
  is `princess`

`eks-kubectl` generates a config file in the /root/.kube/config
file of the container; once done, it runs the kubectl command
with that file and the parameters. For instance to get the nodes
of a given cluster, run:

```shell
docker run -it --rm \
   -e AWS_DEFAULT_REGION=eu-west-1 \
   -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
   -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
   -e CLUSTER=princess \
   gregoryguillou/eks-kubectl get nodes
```

You can create an alias if you plan to use the command frequently.
In addition, you can also expose a port to access the API with the
`proxy` command.
