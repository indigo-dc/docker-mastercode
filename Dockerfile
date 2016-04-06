FROM fedora:23

ENV sqlite_version="3100200"

RUN dnf install -y git \
		   gcc \
		   gcc-c++ \
		   gcc-gfortran \
		   make \
		   wget \
		   patch \
		   root \
		   root-physics \
		   blas \
		   blas-devel \
		   lapack \
		   lapack-devel \
		   libX11-devel \
		   python3-Cython \
		   python3-devel \
		   python3-numpy \
		   python3-scipy \
		   python3-matplotlib \
		   rpm-build \
		   tar

RUN wget https://www.sqlite.org/2016/sqlite-autoconf-${sqlite_version}.tar.gz -O /tmp/sqlite-autoconf-${sqlite_version}.tar.gz && \
    tar xvfz /tmp/sqlite-autoconf-${sqlite_version}.tar.gz -C /tmp

WORKDIR /tmp/sqlite-autoconf-${sqlite_version}
RUN ./configure CFLAGS=-DSQLITE_MAX_VARIABLE_NUMBER=100000 --prefix=/usr/local/ && \
    make && \
    make install
WORKDIR /
