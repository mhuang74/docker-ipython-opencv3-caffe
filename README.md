# docker-ipython-opencv3-caffe

Dockerfile to run ipython/scipy server with the addition of OpenCV and Caffe.

Based on the trafferty/docker-ipython-opencv docker image, this dockerfile adds latest Caffe built from source.

PyCaffe installed at /opt/caffe/python

This image can be used to run the FCN Tutorial (Fully Convolutional Network for Left Ventricle Segmentation) located at:

https://gist.github.com/ajsander/b65061d12f50de3cef5d

###Base Docker Image
trafferty/docker-ipython-opencv

###Usage
Pull it:
```
    docker pull mhuang74/docker-ipython-opencv3-caffe
```
Run it:
```
    docker run --name cv_caffe_notebook -d -p 443:8888 -v $(pwd):/notebooks -e "PASSWORD=MY_PASSWORD"  mhuang74/docker-ipython-opencv3-caffe
```
After it is running, point your browser to https://localhost, login with the password provided in above step, and you can then start your first ipython notebook using  OpenCV and Caffe modules.  

Here is some sample code to verify environment:

```
	import dicom, lmdb, cv2, re, sys
	import os, fnmatch, shutil, subprocess
	from IPython.utils import io
	import numpy as np
	np.random.seed(1234)
	import matplotlib.pyplot as plt
	%matplotlib inline
	import warnings
	warnings.filterwarnings('ignore') # we ignore a RuntimeWarning produced from dividing by zero

	CAFFE_ROOT = "/opt/caffe/"
	caffe_path = os.path.join(CAFFE_ROOT, "python")
	if caffe_path not in sys.path:
	    sys.path.insert(0, caffe_path)

	import caffe

	print("\nSuccessfully imported packages, hooray!\n")
```


