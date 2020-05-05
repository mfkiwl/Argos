#!/usr/bin/bash
ARGOS_HOME="$(git rev-parse --show-toplevel)"
#set environment variable for bash and fish if available
if [[ -z "${ARGOS_HOME}" ]]; then
    
    echo "export ARGOS_HOME=$(git rev-parse --show-toplevel)">>~/.profile

    if [ -x "$(command -v zsh)" ]; then
       echo "export ARGOS_HOME=$(git rev-parse --show-toplevel)">>~/.zprofile
    fi

    if [ -x "$(command -v fish)" ]; then
        fish -c "set -Ux ARGOS_HOME $(git rev-parse --show-toplevel)"
    fi
fi
# create the necessary directories if they don't exists
mkdir -p "$ARGOS_HOME/Storage/models/face_detection/"

#download the necessary photos for training the facial recognition model
if [[ ! -d "$ARGOS_HOME/Storage/data/user_photos/stranger_danger" ]]; then
    mkdir -p "$ARGOS_HOME/Storage/data/user_photos/"
    wget -P "$ARGOS_HOME/Storage/data/user_photos/" https://smttt-my.sharepoint.com/:f:/g/personal/w10016423_usm_edu/ElRUsihZyr1LlWTbACnT44ABdi2YYl0ExaNFq0Deaz6X1A?e=Ngq9So
fi
#the facial recognition task is necessary for the base security routine
#it makes sense to download these models by default
if [[ ! -f "$ARGOS_HOME/Storage/models/face_detection/haarcascade_frontalface_default.xml" ]];then
    wget -P "$ARGOS_HOME/Storage/models/face_detection/" https://raw.githubusercontent.com/opencv/opencv/master/data/haarcascades/haarcascade_frontalface_alt.xml

    wget -P "$ARGOS_HOME/Storage/models/face_detection/" https://raw.githubusercontent.com/opencv/opencv/master/data/haarcascades/haarcascade_frontalface_default.xml

    wget -P "$ARGOS_HOME/Storage/models/face_detection/" https://raw.githubusercontent.com/opencv/opencv/master/data/haarcascades/haarcascade_eye.xml

    wget -P "$ARGOS_HOME/Storage/models/face_detection/" https://raw.githubusercontent.com/opencv/opencv/master/samples/dnn/face_detector/download_weights.py

    wget -P "$ARGOS_HOME/Storage/models/face_detection/" https://raw.githubusercontent.com/opencv/opencv/master/samples/dnn/face_detector/deploy.prototxt

    wget -P "$ARGOS_HOME/Storage/models/face_detection/" https://raw.githubusercontent.com/opencv/opencv/master/samples/dnn/face_detector/weights.meta4

    cd "$ARGOS_HOME/Storage/models/face_detection/" && python download_weights.py && rm weights.meta4 download_weights.py

    #sed 
    cd "$ARGOS_HOME/Source/argos_utils/"
fi
if [[ ! -f "$ARGOS_HOME/Storage/models/face_recognition/nn4.small2.v1.t7" ]]; then
    wget -P "$ARGOS_HOME/Storage/models/face_recognition/" https://storage.cmusatyalab.org/openface-models/nn4.small2.v1.t7
fi

