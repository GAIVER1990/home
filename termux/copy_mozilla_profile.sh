#!/bin/bash

folder_list=("org.mozilla.firefox" "org.mozilla.fenix" "org.mozilla.fennec_aurora" "org.mozilla.fennec_fdroid")

cd termux/firefox
cwd=$(pwd)
echo "BASEDIR is $cwd"


function update_settings () {
  folder=$1
  full_path=/data/data/$folder/files/mozilla/*.default
  if [ -d $full_path ]; then
    cd $full_path
    echo "Current dir is $(pwd)"
    echo "BASEDIR is $(cwd)"
    usernme=$(stat -c "%U" .)
    grp=$(stat -c "%G" .)
    cp -r $cwd/* .
    echo "$(ls -lA | grep -i root)"
    chown -R "$usernme:$grp" .
    echo "$(ls -lA | grep -i user*)"
  fi
}

for folder in "${folder_list[@]}"; do
  echo "$folder"
  update_settings $folder
done

cd $cwd
