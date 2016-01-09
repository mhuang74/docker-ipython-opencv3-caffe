FROM trafferty/docker-ipython-opencv

MAINTAINER Michael S. Huang <mhuang74@gmail.com>


# Install git, bc and dependencies
RUN apt-get update && apt-get install -y \
  bc \
  libatlas-base-dev \
  libatlas-dev \
  libboost-all-dev \
  libprotobuf-dev \
  libgoogle-glog-dev \
  libgflags-dev \
  protobuf-compiler \
  libhdf5-dev \
  libleveldb-dev \
  liblmdb-dev \
  libsnappy-dev

WORKDIR /usr/local/src

# Clone Caffe repo and move into it
RUN git clone https://github.com/BVLC/caffe.git && \
  cd caffe && \
# Copy Makefile
  cp Makefile.config.example Makefile.config && \
# Enable CPU-only
  sed -i 's/# CPU_ONLY/CPU_ONLY/g' Makefile.config && \
  sed -i 's/# OPENCV_VERSION/OPENCV_VERSION/g' Makefile.config && \
# Make
  make -j"$(nproc)" all test pycaffe
# Set ~/caffe as working directory

WORKDIR /usr/local/src/caffe

RUN pip3 install pydicom lmdb


