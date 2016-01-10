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

WORKDIR /opt

# Clone Caffe repo and move into it
RUN git clone https://github.com/BVLC/caffe.git && \
  cd caffe && \
# use cmake
  mkdir build && \
  cd build && \
  cmake -DCPU_ONLY=TRUE -DOPENCV_VERSION=3 -DWITH_PYTHON_LAYER=ON .. && \
# build pycaffe
  make -j"$(nproc)" clean all pycaffe && \
##  pip2 install --upgrade pip && \ 
  pip2 install --requirement ../python/requirements.txt && \
  pip2 install pydicom lmdb && \
  echo 'export PYTHONPATH=/opt/caffe/python:$PYTHONPATH' >> ~/.bashrc && \
# to dismiss "libdc1394 error: Failed to initialize libdc1394"
# http://stackoverflow.com/questions/12689304/ctypes-error-libdc1394-error-failed-to-initialize-libdc1394
  ln /dev/null /dev/raw1394