#!/bin/sh

fleet_or_ipaddr=$1
release_version=$2
source_dir=$3

if echo $fleet_or_ipaddr | grep -q 192.168 
then 
    mode_suffix=T
    echo Running in test mode - no version tag check
elif git diff v$release_version --quiet
then
    mode_suffix=R
    echo Sandbox matches version tag - continuing
else
    echo Sandbox does not match version tag - cannot push to fleet - aborting
    exit 91
fi

set -e
build_timestamp=$(date +%y%m%d%H%M%S)
source_bname=$(basename $source_dir)
build_dir=_work/release_builds/$source_bname-$release_version-$build_timestamp-$mode_suffix

mkdir --parents $build_dir
cp --recursive --dereference $source_dir/* $build_dir

app_balena_yml_template=templates/${source_bname}.balena_yml_template
if [ -f  $app_balena_yml_template ]
then
    cp $app_balena_yml_template $build_dir/balena.yml
fi

for d in $(ls $source_dir)
do
    block_balena_yml_template=templates/$d.balena_yml_template
    if [ -f  $block_balena_yml_template ]
    then
        cp $block_balena_yml_template $build_dir/$d/balena.yml
    fi
done    


time balena push $fleet_or_ipaddr -s $build_dir -d




