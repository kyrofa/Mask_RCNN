FROM nvcr.io/nvidia/l4t-tensorflow:r32.5.0-tf2.3-py3
RUN pip3 install -U pip
RUN apt-get update -qq && apt-get install -qq locales git
RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen

ENV LANG=en_US.UTF-8

# libgomp must be preloaded thanks to arm64. For more details, see
# https://bugzilla.redhat.com/show_bug.cgi?id=1722181
ENV LD_PRELOAD=/usr/lib/aarch64-linux-gnu/libgomp.so.1

#RUN python3 -m pip install numpy==1.18.5 scipy==1.5.4 Pillow==8.4.0 matplotlib==3.3.4 scikit-image==0.17.2 h5py==2.10.0 imgaug==0.4.0 IPython[all]==7.16.3 \
#  # opencv-python doesn't build with skbuild >= 0.14.0, so we need to pin here
#  && python3 -m pip install scikit_build==0.13.1 opencv-python==3.4.11.45

COPY . /mrcnn
RUN python3 -m pip install -r /mrcnn/requirements.txt
