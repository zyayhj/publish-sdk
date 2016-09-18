/**
 * @author zyayhj@2016.09.18
 * upload sdk zip file to OSS
 */
const co = require('co'),
OSS = require('ali-oss'),
ossOption = require('./oss-option.json'), //access-key ...
client = new OSS(ossOption),
fs = require('fs'),
path = require('path');

const argv = process.argv,
filedir = argv[2], //oss path
filepath = argv[3]; //local path
if(!filedir || !filepath){
	console.log("param error")
	return;
}

fs.exists(filepath, exists => {
	if(!exists){
		console.log("file not exist : " + filepath)
		return;
	}
	co(function* () {
		client.useBucket('captcha');
		var result = yield client.put('download/' + filedir + path.basename(filepath), filepath);
		console.log(result);
	}).catch(function (err) {
	  	console.log(err);
	});
});
