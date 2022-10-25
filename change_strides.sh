#!/bin/bash

##This code changes strides of peaks.nii.gz or to the files included in the tensor folder.

strides=`jq -r .strides config.json`
peaks=`jq -r .peaks config.json`
fa=`jq -r .fa config.json`

#retrieve tensor directory
tensor_dir="$(dirname "${fa}")" 

mkdir output

if [ -f $peaks ]; then
    echo "Converting peaks..."
    mrconvert -strides $strides $peaks output/peaks.nii.gz
else
    echo "converting files included in the tensor folder..."
    
    for file_path in ${tensor_dir}/*; do
        filename=$(basename $file_path)
        mrconvert -strides $strides $file_path output/$filename
    done
fi    
