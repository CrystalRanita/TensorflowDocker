# TensorFlow Dockerfiles

Base on:
https://github.com/tensorflow/tensorflow/tree/master/tensorflow/tools/dockerfiles
See ORI_README.md for more detail

## Building

Build from dockerfile to create image, `tf` is tag.

```bash
$ docker build -f ./dockerfiles/cpu-jupyter.Dockerfile -t tf .
```

## Running

Run with -v to shared directory from your local directory.

```bash
# Images with tensorboard run on port 6006, and needs a volume for notebooks
$ docker run \
  --name tensorboard \
  --user $(id -u):$(id -g) \
  -p 6006:6006 \
  -v $(pwd):/notebooks \
  -it tf \
  tensorboard --logdir tsboardDir
# On Mac I test $(pwd)/tsboardDir but always display
# "No dashboards are active for the current data set." on browser.
# Works well after remove "$(pwd)"
```

```bash
# Images with Jupyter run on port 8888, and needs a volume for notebooks
$ docker run --name jupyter --user $(id -u):$(id -g) -p 8888:8888 -v $(pwd):/notebooks -it tf
```

After running, you can get a token for jupyter.

## Jupyter

Launch browser, link with token:
http://localhost:8888/

Click right-top side `new` -> `Python3` to try your python code.
Ctrl+Enter to enter cmd.

## Tensorboard

Launch browser, link with:
http://localhost:6006/

## Start/Stop containers

```bash
$ docker stop/start jupyter
$ docker stop/start tensorboard
```