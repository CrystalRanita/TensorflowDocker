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
  tensorboard --logdir workdir/pyDir
# Place event file under workdir/pyDir to display on tensorboard.
# On Mac I test $(pwd)/tsboardDir but always display
# "No dashboards are active for the current data set." on browser.
# Works well after remove "$(pwd)"
```
```bash
# Images with bash
$ docker run --name bashCmd --user $(id -u):$(id -g) -v $(pwd):/workdir -it tf /bin/bash
```

## Edit Files

On your local side install software to edit .py files.
Such as Visual Studio Code.

## Build .py

On bashCmd container terminal run floowing command to build .py

```bash
# run cmd ex. python test.py
$ python YOUR_PY_FILE_NAME
```

## Tensorboard

After Create "evnet" file by run .py  
(you need to write some code about tensorboard in .py to create event file.)  
Launch browser, link with: http://localhost:6006/

## Start/Stop containers

```bash
$ docker stop/start tensorboard
```

## Known Issue

Jupyter: In this dockerfile, run on Mac platform cannot display event file on tensorboard
 and cannot display running plot. Current cannot find solution.
 Add "%matplotlib notebook" on the top of .py file can display plot but cannot running.