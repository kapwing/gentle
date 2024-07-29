#!/bin/bash

docker pull lowerquality/gentle
docker run lowerquality/gentle
docker cp $(docker container ls -n 1 -q):/gentle/exp .