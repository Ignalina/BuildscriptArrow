#!/bin/sh

apk add autoconf \
        bash \
        cmake \
        g++ \
        gcc \
        make



set -e

: ${ARROW_DIR:=/opt/arrow/src/}
: ${EXAMPLE_DIR:=/opt/arrow/io}
: ${ARROW_BUILD_DIR:=/opt/arrow/build}

mkdir -p ${ARROW_DIR}
cd ${ARROW_DIR}
git clone https://github.com/apache/arrow.git ${ARROW_DIR}
cd ${ARROW_DIR}/cpp


echo
echo "=="
echo "== Building Arrow C++ library"
echo "== ${ARROW_DIR}"
echo "== ${ARROW_BUILD_DIR}"
echo

#export export LLVM_DIR=/opt/rh/llvm-toolset-8.0/root

rm -rf $ARROW_BUILD_DIR
mkdir -p $ARROW_BUILD_DIR

pushd $ARROW_BUILD_DIR

NPROC=$(nproc)

cmake $ARROW_DIR/cpp \
    -DARROW_DEPENDENCY_SOURCE=BUNDLED \
    -DARROW_BUILD_SHARED=OFF \
    -DARROW_BUILD_STATIC=ON \
    -DARROW_COMPUTE=ON \
    -DARROW_CSV=ON \
    -DARROW_DATASET=ON \
    -DARROW_FILESYSTEM=ON \
    -DARROW_HDFS=ON \
    -DARROW_GANDIVA=ON \
    -DARROW_JEMALLOC=ON \
    -DARROW_JSON=ON \
    -DARROW_ORC=ON \
    -DARROW_PARQUET=ON \
    -DARROW_PLASMA=ON \
    -DARROW_WITH_BROTLI=ON \
    -DARROW_WITH_BZ2=ON \
    -DARROW_WITH_LZ4=ON \
    -DARROW_WITH_SNAPPY=ON \
    -DARROW_WITH_ZLIB=ON \
    -DARROW_WITH_ZSTD=ON \
    -DARROW_IPC=ON \
    -DARROW_FLIGHT=ON \
    -DCMAKE_BUILD_TYPE=release \
    -DARROW_TENSORFLOW=ON \
    $ARROW_CMAKE_OPTIONS


make 
make install
#ln -s /usr/local/lib /usr/local/lib64
popd
