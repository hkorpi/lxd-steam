#!/usr/bin/env bash

set -euo pipefail
cd $(dirname $0)

driver_directory=$(dirname $0)

function move-file {
  file=$1
  # Check if the file already exists in its correct path
  if [ -e "/$file" ]; then
    echo "Skipping $file as it already exists."
  else
    if [ -d "$file" ] ; then
      echo "Create directory $file";
      mkdir -p "/$file"
    else
      echo "Install $file."
      cp "$file" "/$file"
    fi
  fi
}

function move-package {
  cd "$driver_directory/$1"
  shopt -s globstar
  for i in **; do 
    move-file "$i"
  done
}

function download-package {
  package=$1
  package_directory="$driver_directory/$package"
  
  if [ -e "$package_directory" ]; then
    echo "Skipping download $1 as it already exists."
  else
    # Download package
    apt-get download "$package"

    # Extract the DEB package
    dpkg-deb -x "$package"*.deb "$package_directory"
  fi
}

download-package $1
move-package $1
