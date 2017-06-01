#!/bin/bash
IMAGE_TAG="masszhou/ros-indigo-cuda8-opengl4"

while getopts ":t:" opt; do
  case $opt in
    t) IMAGE_TAG=$OPTARG ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done
shift $(expr $OPTIND - 1)

docker build -t $IMAGE_TAG .
