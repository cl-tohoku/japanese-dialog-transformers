#!/bin/bash
set -e 
USAGE="bash $0 [-i HOST] [-g GPU=0]"


while getopts i:g: OPT ; do
  case ${OPT} in
    i ) FLG_I="TRUE"; HOST=${OPTARG};;
    g ) FLG_G="TRUE"; GPU=${OPTARG};;
    * ) echo ${USAGE} 1>&2; exit 1 ;;
  esac
done


if [ "${FLG_I}" != "TRUE" ] ; then
  echo $USAGE
  exit 1
fi
test "${FLG_G}" != "TRUE" && GPU=0


CUDA_VISIBLE_DEVICES=$GPU \
  python client_nttcs.py \
    --host $HOST
