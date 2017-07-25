/*
 * @author zyayhj@2016.09.18
 * upload sdk zip file to OSS
 * @Last Modified by:   Mr.Sofar
 * @Last Modified time: 2017-07-25 18:55:38
*/

const co = require('co'),
OSS = require('ali-oss'),
ossOption = require('./oss-option.json'), //access-key ...
client = new OSS(ossOption),
fs = require('fs'),
path = require('path');

const argv = process.argv,
filedir = argv[2], //oss path
filepathArr = argv.splice(3); //local path array

if(!filedir || filepathArr.length === 0){
	console.log("param error")
	return;
}
filepathArr.forEach(function(v,i){
	var filepath = v;
	var index = i;
	setTimeout(function(){
		fs.exists(filepath, exists => {
			if(!exists){
				console.log("file not exist : " + filepath)
				return;
			}
			co(function* () {
				client.useBucket('ugchain-static');
				var result = yield client.put('/' + filedir + path.basename(filepath), filepath);
				console.log(result);
			}).catch(function (err) {
			  	console.log(err);
			});
		});
	},index*50)
})
