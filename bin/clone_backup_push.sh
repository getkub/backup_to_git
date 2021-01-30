#!/bin/bash
####################################
#
# Clone git, backup files & upload to git
#
####################################

# What to backup. 
git pull origin 
backup_list="../configs/backup_directories.list"
thisHost=$(hostname -s)
thisHost="tempHost"

# Where to backup to.
dest="../backups/${thisHost}/"
mkdir -p $dest

# Create archive filename.
for abs_dir in `grep -v '#' ${backup_list}`
do 
    dname=`basename $abs_dir`
    echo "backup_dir=$abs_dir dest_file=$dest/$dname"
    tar czf $dest/${dname}.tgz $abs_dir
done
# Long listing of files in $dest to check file sizes.
#ls -lh $dest

git add -A && git commit -am "Updated with backup files"
git push origin

echo "Git push finished"

