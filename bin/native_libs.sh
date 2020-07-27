#!/bin/bash

if [ ! -x "$(command -v go)" ]; then

#  if [ ! -x "$(command -v gvm)" ]; then
#
#    apt install -y bison
#
#    bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
#
#    source "$HOME/.bashrc"
#
#  fi
#
#  gvm install go1.14 -B
#  gvm use go1.14 --default

  echo "install golang please!"

  exit 1

fi


if [ ! -x "$(command -v ninja)" ]; then

#  apt install -y ninja-build

  echo "install ninja-build please!"

  exit 1

fi

if [ ! -x "$(command -v cmake)" ]; then

#  apt install -y cmake

  echo "install cmake please!"

  exit 1

fi

if [ -f "$ANDROID_HOME/ndk-bundle/source.properties" ]; then

  export NDK=$ANDROID_HOME/ndk-bundle

else

  export NDK=$ANDROID_HOME/ndk/21.3.6528147

fi

export NINJA_PATH="$(command -v ninja)"

export PATH=$(echo "$ANDROID_HOME"/cmake/*/bin):$PATH

cd TMessagesProj/jni || exit 1

git submodule update --init --recursive

cd ffmpeg
git reset --hard
git clean -fdx
cd ..

./build_ffmpeg_clang.sh
./patch_ffmpeg.sh

cd boringssl
git reset --hard
git clean -fdx
cd ..

./patch_boringssl.sh
./build_boringssl.sh