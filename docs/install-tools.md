# Install tools

* [kubectl](#kubectl)
* [kind](#kind)
* [Poetry](#poetry)
* []()


### kubectl 

:book: [Set up kubectl and eksctl](https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html)

Download the binary for your cluster’s Kubernetes version from Amazon S3

```bash
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.31.0/2024-09-12/bin/linux/amd64/kubectl
```

Verify the downloaded binary with the SHA-256 checksum for your binary

```bash
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.31.0/2024-09-12/bin/linux/amd64/kubectl.sha256
```

Check the SHA-256 checksum for your downloaded binary

```bash
echo $(cat kubectl.sha256) | sha256sum --check
```

you should see

```
kubectl: OK
```

Apply execute permissions to the binary

```bash
chmod +x ./kubectl
```

Copy the binary to a folder in your `PATH`

```bash
mkdir -p ~/.local/bin && cp ./kubectl ~/.local/bin/kubectl
```

Test the installation

```bash
kubectl version --client
```

you should see something like this

```
Client Version: v1.31.0-eks-a737599
Kustomize Version: v5.4.2
```


### kind

:book: [Installing From Release Binaries](https://kind.sigs.k8s.io/docs/user/quick-start#installation)

```bash
Copy
# For AMD64 / x86_64
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.25.0/kind-linux-amd64
# For ARM64
[ $(uname -m) = aarch64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.25.0/kind-linux-arm64
chmod +x ./kind
mkdir -p ~/.local/bin && mv ./kind ~/.local/bin/kind
```

test installation

```bash
kind --version
```

you should see something like this

```
kind version 0.25.0
```


### Poetry

:package: [install instructions](https://python-poetry.org/docs/#installation)

```bash
curl -sSL https://install.python-poetry.org | python3 -
```

> **Note:** you may need to log out and log back in for the poetry to be available in terminal.
