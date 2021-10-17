This fork was created to use `hugo` the latest extended version on a raspberry pi 4 (armv8). Original repo can be found [here](https://github.com/mpwsh/hugo-armv8-alpine).

The [Dockerfile](Dockerfile) has been heavily modified. The image is currently alpine based.

A Kubernetes deployment forked from [GitDocs](https://github.com/jimangel/GitDocs) awesome repo has been added as well (pointing to the image of this repo).

I created this image to be deployed in my Raspberry Pi 4 Kubernetes cluster [k3s](github.com/rancher/k3s) to run my [documentation site](https://docs.mpw.sh), using the [Geekdoc](https://github.com/thegeeklab/hugo-geekdoc) theme.

GitDocs is an awesome deployment that runs 3 containers, `hugo`, `nginx` and `git-sync`. You can find more info in the [GitDocs](https://github.com/jimangel/GitDocs) repo.  This allows you to have your site in sync with your `hugo` content repository with 0 hassle.  Just commit to your repo and see the changes almost instantly.

Deploying in Kubernetes (with kustomize):
First, you need to modify the file [geekdoc/patch.yaml](k8s/deployment/overlays/geekdoc/patch.yaml) and replace my repo for yours.
The base deployment lives in [geekdoc/patch.yaml](k8s/deployment/base/gitdocs-deployment.yaml). (No need to change this, but feel free to do so)

## Installing the deployment

```bash
#Move to or create the namespace you want to use and run
kubectl apply -k deployment/overlays/geekdoc/patch.yaml
#Expose the service
kubectl expose deployment/gitdocs --port 8080
```

## Validating
Port forward nginx
```bash
kubectl port-forward deployment/gitdocs 8080:8080
```

Open [http://localhost:8080](http://localhost:8080) in your browser and check out your brand new hugo site.

More documentation about this deployment can be found in the [GitDocs](https://github.com/jimangel/GitDocs) repository, alongside some troubleshooting steps if something doesn't work as expected.


