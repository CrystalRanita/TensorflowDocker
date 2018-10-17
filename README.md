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
# Images with Jupyter run on port 8888, and needs a volume for notebooks
$ docker run --user $(id -u):$(id -g) -p 8888:8888 -v $(pwd)/workdir:/notebooks -it tf
```

After running, you can get a token for jupyter.

## Jupyter

Launch browser, link with token:
http://localhost:8888/

Click right-top side `new` -> `Python3` to try your python code.
Ctrl+Enter to enter cmd.
