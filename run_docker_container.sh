#!/bin/bash
IMAGE_NAME="open_duck"
 
docker run --gpus all --rm -it --network=host \
    -v $(pwd)/:/open_duck $IMAGE_NAME
