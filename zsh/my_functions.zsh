### My zsh functions ###

print '\n'
print 'Loading private functions ...'

function real_path(){
	## function getting real path
	## Usage: real_path [path_or_file]
	## Returns: strings of real path to standard out

	abs_path_dir=$(cd $(dirname ${1}) && pwd)
	print ${abs_path_dir#/}/$(basename $1)
}

function trash(){
### mv files to os's trash bin. Exporting of TRASH
### valiables are required in mother init files
### eg. .zshrc .zshenv
	mv -iv ${*} ${TRASH}
}

function rnd(){
### Copy or rename file with date-prefix in 6-digits to name 
###	with today's date-prefix 
	fileNameBody=$( echo -n ${1#*_} )
	cp -v $1 $(date +%y%m%d)_${fileNameBody} }

function sp2_(){
### Replace the spaces in the file name to '_' (under bar).
### Usage : sp2_ [options] file
### Returns: replace white spaces in the name of file or all files
###	with white space if -a option is specified
	if [[ ${1} == '-a' ]]; then
		sp_files=$( find . -maxdepth 1 -type f -regex '.*\s.*')
	else
		sp_files=${1}
	fi
	echo $sp_files | while read line; do
		replaced_file_name=$( sed -e 's/\s/_/g' <(echo -n ${line}) )
		mv -iv ${line} ${replaced_file_name}
	done
}


function find_today(){
### Find files made in 24 hours in the pass designated at argment 1
	find ${1} -maxdepth 1 -type f -mtime -1
}


function jp_rename(){
### Append prefix to file name started with Japanese characters 
### Usage : jp_rename [option] file
### Returns : rename file with prefix 'jp_' plus random number
### Option '-a' : replace all fullfilled files in the working dir
	if [[ ${1} == '-a' ]] ; then
		jp_files=$(find . -maxdepth 1 -type f | cut -d '/' -f 2 | env -i grep -E '^[^[:alnum:]\.]+')
	else
		jp_files=${1}
	fi

	for line in $( echo -n ${jp_files} ) ; do
		ran_num=${RANDOM}
		print 'Rename file from '${line}' to jp_'${ran_num}'_'${line}'. OK?'
		print -n 'Yes/No : '
		read ans
		if [[ $(print ${ans} | grep -Ei 'y(es)?') ]] ; then
			mv ${line} jp_${ran_num}'_'${line}
		else
			print 'Aborted!'
		fi
	done
}
case ${OSTYPE} in
	darwin*)
	    mount_dir='/Volumes'
            ;;
	linux*)
	    mount_dir='/media/'

esac


function pumount(){
### Unmount Pendrive quickly
### Usage: pumount
    #print ${mount_dir}
    cdev=($(find ${mount_dir} -maxdepth 1 -type d))
    #print ${cdev}
    known_dev=($(grep -E '.*(CHIBA|Transcend|ShokoT)$' <(echo ${cdev} | tr -s ' ' '\n'))) # known_dev=(CHIBA, Trascend, ShokoT)
    #print $known_dev
    if [[ -O ${known_dev:0:1} ]]; then
        target=${known_dev:0:1}
        print 'Target: '${target}
    else
        n=0
        for item in ${cdev}; do
	    print -n ${n}': '${cdev:${n}:1}', '
	    n=$(( ${n} + 1 ))
        done

	print '\n'
        print -n 'Input the number of device to be removed (Q to quit): '
        read ans

        if [[ ${ans} == 'Q' ]]; then; return 0; fi

        target=${cdev:${ans}:1}
    fi


    if [[ -O ${target} ]]; then
        print ${target} 'is going to be removed.'
        diskutil umount ${target}
    else
        print 'Invalid device'
    fi
}

function myrot13(){
    ### make string by rot13 conversion
    echo ${1} | tr "$(printf %13sA-z)" A-zA-z
}

setopt REMATCH_PCRE
function w3(){
    ### use w3m in benri way
    ### no argment --> open bookmark
    ### hoge.foo.com type string argment --> open URL
    ### word(s) argment --> search in google
    
    url_pat="0-9a-zA-Z?=#+_\&:/%"
    #suffix_pat='\.co\.jp|\.ac\.jp|\.go\.jp|\.com|\.org|\.edu|\.gov'

    if [[ $# == 0 ]]; then
        w3m ${HOME}/.w3m/bookmark.html

    elif [[ ${1} -regex-match ^[${url_pat}]+\\.[${url_pat}]+\\.[${url_pat}\\.]+$ ]]; then # more than 2 periods considers as URL
        #print 'URL: '${1}
        w3m ${1}
    elif [[ ${1} =~ ^[0-9a-zA-Z?=#+-_\&:/%\ \.]+ ]]; then
        #print 'word: '${1}
        print 'opening... https://www.google.co.jp/search?q='"${1}"
#        w3m 'https://www.google.co.jp/search?q='"${1}"
    else 
        print 'Cannot judge string: '${1}
    fi   
}


### Final statement###
print 'done'
