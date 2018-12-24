# Copyright 2018 The TensorFlow Authors. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ============================================================================
#
# THIS IS A GENERATED DOCKERFILE.
#
# This file was assembled from multiple pieces, whose use is documented
# below. Please refer to the the TensorFlow dockerfiles documentation for
# more information. Build args are documented as their default value.
#
# Ubuntu-based, CPU-only environment for using TensorFlow
#
# Start from Ubuntu (no GPU support)
# --build-arg UBUNTU_VERSION=16.04
#    ( no description )
#
# Python is required for TensorFlow and other libraries.
# --build-arg USE_PYTHON_3_NOT_2=True
#    Install python 3 over Python 2
#
# Install the TensorFlow Python package.
# --build-arg TF_PACKAGE=tensorflow (tensorflow|tensorflow-gpu|tf-nightly|tf-nightly-gpu)
#    The specific TensorFlow Python package to install
#
# Configure TensorFlow's shell prompt and login tools.

ARG UBUNTU_VERSION=16.04
FROM ubuntu:${UBUNTU_VERSION}

ARG USE_PYTHON_3_NOT_2=True
ARG _PY_SUFFIX=${USE_PYTHON_3_NOT_2:+3}
ARG PYTHON=python${_PY_SUFFIX}
ARG PIP=pip${_PY_SUFFIX}

RUN apt-get update && apt-get install -y \
    net-tools \
    vim \
    virtualenv \
    openjdk-8-jdk \
    wget \
    ${PYTHON} \
    ${PYTHON}-pip

RUN ln -s /usr/bin/python3.5 /usr/bin/python
RUN python --version

RUN ${PIP} install --upgrade \
    pip \
    setuptools

RUN ${PIP} --no-cache-dir install \
        Pillow \
        h5py \
        ipykernel \
        jupyter \
        keras \
        matplotlib \
        numpy \
        pandas \
        scipy \
        sklearn \
        virtualenv

ARG HADOOP_VER=hadoop-2.9.2
ARG HADOOP_FILE=${HADOOP_VER}.tar.gz
ARG HADOOP_LINK=http://apache.stu.edu.tw/hadoop/common/${HADOOP_VER}/${HADOOP_FILE}
ARG HADOOP_PATH=/opt/hadoop/
RUN mkdir -p ${HADOOP_PATH}
RUN wget ${HADOOP_LINK} -P ${HADOOP_PATH}
RUN tar xvzf ${HADOOP_PATH}/${HADOOP_FILE} -C ${HADOOP_PATH}

ARG SPARK_VER=spark-2.1.1
ARG SPARK_HADOOP_VER=${SPARK_VER}-bin-hadoop2.7
ARG SPARK_FILE=${SPARK_HADOOP_VER}.tgz
ARG SPARK_PATH=/opt/apache-spark/
ARG SPARK_LINK=https://archive.apache.org/dist/spark/${SPARK_VER}/${SPARK_FILE}
RUN mkdir -p ${SPARK_PATH}
RUN wget ${SPARK_LINK} -P ${SPARK_PATH}
RUN tar xvzf ${SPARK_PATH}/${SPARK_FILE} -C ${SPARK_PATH}
RUN cp ${SPARK_PATH}/${SPARK_HADOOP_VER}/conf/slaves.template ${SPARK_PATH}/${SPARK_HADOOP_VER}/conf/slaves
RUN cp ${SPARK_PATH}/${SPARK_HADOOP_VER}/conf/spark-env.sh.template ${SPARK_PATH}/${SPARK_HADOOP_VER}/conf/spark-env.sh
COPY tools/spark-env.sh ${SPARK_PATH}/${SPARK_HADOOP_VER}/conf/spark-env.sh
# Place IP in tools/slaves file bottom
COPY tools/slaves ${SPARK_PATH}/${SPARK_HADOOP_VER}/conf/slaves
RUN chmod a+rwx ${SPARK_PATH}/${SPARK_HADOOP_VER}/conf/spark-env.sh

# RUN rm ${SPARK_PATH}/${SPARK_FILE}
# This file download takes a long time so keep it in image.
# If add other sw run build will be faster.

# ARG TF_PACKAGE=tensorflow
# RUN ${PIP} install ${TF_PACKAGE}

RUN mkdir /notebooks && chmod a+rwx /notebooks
RUN mkdir /.local && chmod a+rwx /.local
EXPOSE 8888

COPY bashrc_spark /etc/bash.bashrc
RUN chmod a+rwx /etc/bash.bashrc
CMD ["bash", "-c", "source /etc/bash.bashrc"]
