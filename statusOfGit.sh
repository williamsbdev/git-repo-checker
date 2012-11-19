#!/bin/bash
#start from the home directory
cd
for dir in `find -name '.git' | sed 's/.git//g'`; do
    echo $dir
    declare -a branches
    if [ -d $dir.git/refs ]; then
        echo "in if..."
	cd $dir.git/refs/heads
	for branch in `ls`; do
	    echo $branch
	    cd
	    cd $dir
	    git checkout $branch
#	    git status | grep 'nothing to commit' | wc
	    export STATUS=`git status | grep "Changes not staged for commit\|but untracked files present"`
	    if [[ $STATUS != "" ]]
#	    if [ $changes -gt 0 ]; then
		echo $dir ' on branch ' $branch ' has changes to be committed'
	    fi
	done
    else
	echo "in else..."
	cd $dir
	export STATUS=`git status | grep "Changes not staged for commit\|but untracked files present"`
	if [[ $STATUS != "" ]]
	    echo $dir ' on branch ' $branch ' has changes to be committed'
	fi
#	git status | grep 'nothing to commit' | wc >changes
#       echo $changes
#        if $changes > 0
#	    echo $dir ' on branch ' $branch ' has changes to be committed'
#        fi
    fi
    #return to home directory before working on next git repo
    cd
done
