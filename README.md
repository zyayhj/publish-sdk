# touclick sdk 自动上传至CDN

### Author
	
	zyayhj

###	Usage

	$ ./publish.sh

	$ cd ../captcha-demo

	$ git add download-url.json

	$ git commit -m 'update download-url.json'

	$ git push origin master

	# login touclick-site server

	$ cd touclick-site/data/captcha-demo 

	$ git pull
