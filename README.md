This fork was created to use `hugo` the latest extended version on a raspberry pi 4.
The [Dockerfile](Dockerfile) has been heavily modified.
A Kubernetes deployment forked from [GitDocs](https://github.com/jimangel/GitDocs) awesome repo has been added as well (pointing to the image of this repo).
I created this image to be deployed in my Raspberry Pi 4 Kubernetes cluster [k3s](github.com/rancher/k3s) to run my `hugo` blog, using the [Geekdoc](https://github.com/thegeeklab/hugo-geekdoc) theme.

GitDocs is an awesome deployment that runs 3 containers, `hugo`, `nginx` and `git-sync`. You can find more info in the [GitDocs](https://github.com/jimangel/GitDocs) repo.  This allows you to have your site in sync with your `hugo` content repository with 0 hassle.  Just commit to your repo and see the changes almost instantly.

Deploying in Kubernetes (with kustomize):
First, you need to modify the file [geekdoc/patch.yaml](k8s/deployment/overlays/geekdoc/patch.yaml) and replace my repo for yours.  
The base deployment lives in [geekdoc/patch.yaml](k8s/deployment/base/gitdocs-deployment.yaml). (No need to change this, but feel free to do so)  

## Installing the deployment

```bash
#Move to or create the namespace you want to use and run
kubectl apply -k deployment/overlays/geekdoc/patch.yaml
```

## Validating

```bash
kubectl expose deployment/gitdocs --port 8080
```

Open [http://localhost:8080](http://localhost:8080) in your browser and check out your brand new hugo site.

More documentation about this deployment can be found in the [GitDocs](https://github.com/jimangel/GitDocs) repository, alongside some troubleshooting steps if something doesn't work as expected.  

Usage for the docker image can be found on the original repo, which i left untouched below:


# OG Readme from fork:
# Hugo

A [Docker](http://docker.com) file to build [Hugo](https://gohugo.io), one of the most popular open-source static site generators for AMD & ARM devices over an alpine base image based.

> Be aware! You should read carefully the usage documentation of every tool!


## Details

- [GitHub](https://github.com/elswork/rpi-hugo)
- [Deft.Work my personal blog](https://deft.work)

| Docker Hub | Docker Pulls | Docker Stars | Size/Layers |
| --- | --- | --- | --- |
| [rpi-hugo](https://hub.docker.com/r/elswork/rpi-hugo "elswork/rpi-hugo on Docker Hub") | [![](https://img.shields.io/docker/pulls/elswork/rpi-hugo.svg)](https://hub.docker.com/r/elswork/rpi-hugo "rpi-hugo on Docker Hub") | [![](https://img.shields.io/docker/stars/elswork/rpi-hugo.svg)](https://hub.docker.com/r/elswork/rpi-hugo "rpi-hugo on Docker Hub") | [![](https://images.microbadger.com/badges/image/elswork/rpi-hugo.svg)](https://microbadger.com/images/elswork/rpi-hugo "rpi-hugo on microbadger.com") |

## Build Instructions

Build for amd64, armv7l or arm64 architecture (thanks to its [Multi-Arch](https://blog.docker.com/2017/11/multi-arch-all-the-things/) base image)

```bash
docker build -t elswork/rpi-hugo .
```

## Usage Example

In order everyone could take full advantages of the usage of this docker container, .I'll describe my own real usage setup.
This guide asumes that you already have [created a site](https://gohugo.io/getting-started/quick-start/#step-2-create-a-new-site), [added a theme](https://gohugo.io/getting-started/quick-start/#step-3-add-a-theme) and [added some content](https://gohugo.io/getting-started/quick-start/#step-4-add-some-content).

### Create Site

```bash
docker run -v /path/to/**parentfolder**:/src elswork/rpi-hugo new site **sitename**
```

### Create Post

```bash
docker run -v /path/to/**sitename**:/src elswork/rpi-hugo new post/2099-12-31-nuevo-articulo/index.md
```
### Testing/Serving

```bash
docker run -p 1313:1313 -v /path/to/**sitename**:/src elswork/rpi-hugo server -b http://HostName.Or.IP/ --bind=0.0.0.0 -w
```

### Build Site

```bash
docker run --rm -v /path/to/**sitename**:/src --name HugoBuild elswork/rpi-hugo --cleanDestinationDir
```

**[Sponsor me!](https://github.com/sponsors/elswork) Together we will be unstoppable.**
