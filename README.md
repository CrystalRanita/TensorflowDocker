# TensorFlow Dockerfiles

Base on:
https://github.com/tensorflow/tensorflow/tree/master/tensorflow/tools/dockerfiles
See ORI_README.md for more detail

## Building

Build from dockerfile to create image, `tf` is tag.

```bash
$ docker build -f ./dockerfiles/cpu.Dockerfile -t tf .
```

## Running

Run with -v to shared directory from your local directory.

```bash
# Images with tensorboard run on port 6006, and needs a volume for workdir
$ docker run \
  --name tensorboard \
  --user $(id -u):$(id -g) \
  -p 6006:6006 \
  -v $(pwd):/workdir \
  -it tf \
  tensorboard --logdir pyDir
# On Mac I test $(pwd)/tsboardDir but always display
# "No dashboards are active for the current data set." on browser.
# Works well after remove "$(pwd)"
```
```bash
# Images with bash
$ docker run --name bashCmd --user $(id -u):$(id -g) -v $(pwd):/workdir -it tf /bin/bash
```

## Jupyter

Removed due to cannot display event file on tensorboard and cannot display running plot.

## Tensorboard

Launch browser, link with:
http://localhost:6006/

## Start/Stop containers

```bash
$ docker stop/start tensorboard
```