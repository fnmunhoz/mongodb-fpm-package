#!/bin/bash

MONGO_DATA_DIR='/data/db'

if test -d $MONGO_DATA_DIR
then
  echo "${MONGO_DATA_DIR} already exists skiping creating ..."
else
  echo "Creating ${MONGO_DATA_DIR} directory ..."
  mkdir -p $MONGO_DATA_DIR
fi

