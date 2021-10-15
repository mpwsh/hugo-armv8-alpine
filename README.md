A [Docker](http://docker.com) image to build [Hugo](https://gohugo.io) sites (using the extended version) in armv8 (rpi4). Base image based on bullseye.

This image was created to be used with [GitDocs](https://github.com/jimangel/GitDocs) in my raspberry pi kubernetes cluster, but you can still use it as a normal `hugo` image (more info below)

GitDocs deployment manifests can be found [here](https://github.com/mpwsh/blog/k8s-deployment)



Readme from forked repo:
> Be aware! You should read carefully the usage documentation of every tool!
## Details

- [GitHub](https://github.com/marianopw/rpi-hugo)
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

### Credits
Forked from [elswork/rpi-hugo](https://github.com/elswork/rpi-hugo). Thank you!
