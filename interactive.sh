#!/bin/bash
USAGE="bash $0 [-m MODEL] [-g GPU=0]"


while getopts i:m:g: OPT ; do
  case ${OPT} in
    m ) FLG_M="TRUE"; MODEL=${OPTARG};;
    g ) FLG_G="TRUE"; GPU=${OPTARG};;
    * ) echo ${USAGE} 1>&2; exit 1 ;;
  esac
done

test "${FLG_G}" != "TRUE" && GPU=0
export CUDA_VISIBLE_DEVICES=$GPU

if [ ! -f $MODEL ] ; then
  echo $USAGE
  exit 1
fi
 
mkdir -p ./log

CUDA_VISIBLE_DEVICES=$GPU python ./scripts/dialog.py data/sample/bin \
  --path $MODEL \
  --beam 1 \
  --min-len 10 \
  --source-lang src \
  --target-lang dst \
  --tokenizer space \
  --bpe sentencepiece \
  --sentencepiece-model data/dicts/sp_oall_32k.model \
  --no-repeat-ngram-size 3 \
  --nbest 1 \
  --sampling \
  --sampling-topp 0.9 \
  --temperature 1.0 \
  --show-nbest 1

