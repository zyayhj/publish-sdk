#!/bin/sh

VERSION="5.2.0" #SDK version
URL_PREFIX="//captcha-static.touclick.com/download" #download url host 

SDK_BASEPATH='/Users/foxer/touclick-apps/sdk'
sdk_list=("/php-sdk" "/csharp-sdk" "/go-sdk" "/nodejs-demo" "/python-sdk" "/java-sdk" "/android-sdk" "/ios-sdk")
tmp_dir=".archive/"
rm -rf $tmp_dir
mkdir $tmp_dir
upload_time=$(date "+%Y%m%d%H%M%S")
infofile_path="${SDK_BASEPATH}/captcha-demo/download-url.json" #路径信息文件存放处
rm $infofile_path
index=0
echo "{ " >> $infofile_path
for dir in ${sdk_list[@]};do
	index=$(($index+1));
	target_filename=$(basename ${dir})"-"$VERSION".tar.gz"
	bname=$(basename $dir)
	case "$OSTYPE" in
		darwin*) #OSX
			tar --exclude '*/.*' --exclude '*/node_modules/*' --exclude '*/logs/' --exclude '*.log' -zcf ${tmp_dir}$target_filename -C ${SDK_BASEPATH} $bname
			;;
		linux*)  #Linux
			tar -zcf ${tmp_dir}$target_filename -C ${SDK_BASEPATH} $bname --exclude='*/.*' --exclude='*/node_modules/*' --exclude='*/logs/' --exclude='*.log'
			;;
		*)
			echo "unkown : $OSTYPE"
			;;
	esac
	
	echo $upload_time"\t"${tmp_dir}${target_filename}

	node --harmony app  "${upload_time}/" ${tmp_dir}${target_filename}

	SPLIT=","
	if [ $index = ${#sdk_list[@]} ];then
		SPLIT=""
	fi
	cat <<EOF >> $infofile_path
  "$bname" : "$URL_PREFIX/$upload_time/$target_filename"$SPLIT
EOF

done
echo " } " >> $infofile_path
