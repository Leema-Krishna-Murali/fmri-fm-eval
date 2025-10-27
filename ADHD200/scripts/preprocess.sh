#!/bin/bash

if [[ -z $1 ]]; then
    echo "preprocess.sh SUBIDX"
    exit
fi

subidx=$1
subid=$(sed -n ${subidx}p sourcedata/subject_list.txt)
dataset=$(echo $subid | cut -d " " -f 1)
subid=$(echo $subid | cut -d " " -f 2)

datadir="${PWD}/sourcedata/RawDataBIDS/${dataset}"
outdir="${PWD}/preprocessed/fmriprep/${dataset}"
logdir="${PWD}/logs/fmriprep"

fs_license=$(readlink -f ../license.txt)

export OMP_NUM_THREADS=1

mkdir -p $outdir 2>/dev/null
mkdir -p $logdir 2>/dev/null

docker run --rm \
    -v "${datadir}:/data:ro" \
    -v "${outdir}:/out" \
    -v "${fs_license}:/opt/freesurfer/license.txt:ro" \
    -e OMP_NUM_THREADS=$OMP_NUM_THREADS \
    nipreps/fmriprep:25.2.3 \
    /data /out participant \
    --participant-label $subid \
    --skip_bids_validation \
    --fs-license-file /opt/freesurfer/license.txt \
    --ignore fieldmaps slicetiming sbref t2w flair fmap-jacobian \
    --output-spaces MNI152NLin6Asym:res-2 \
    --cifti-output 91k \
    --nprocs 1 \
    --omp-nthreads $OMP_NUM_THREADS \
    | tee ${logdir}/${dataset}_${subid}.txt
