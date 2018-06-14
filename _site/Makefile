
build: build-i2pd build-torhost build-github

run: i2pd torhost github

build-i2pd:
	docker build --rm -f Dockerfile.i2pd -t eyedeekay/github-i2pd .

run-i2pd: network
	docker run --restart=always -i -d -t \
		--name github-i2pd \
		--network eepsite \
		--network-alias github-i2pd \
		--hostname github-i2pd \
		--ip 172.81.81.4 \
		-p :4567 \
		-p 127.0.0.1:7070:7070 \
		-v eepsite:/var/lib/i2pd \
		eyedeekay/github-i2pd; true

i2pd: build-i2pd run-i2pd

build-github:
	docker build --rm \
		--build-arg PAGES_REPO_NWO="j-tt/r-i2p-wiki" \
		--build-arg  proxy=socks5://172.81.81.6:9150 \
		--build-arg theme=jekyll-theme-minimal \
		-f Dockerfile.github -t eyedeekay/eepsite-github .

run-github: network clean-github
	docker run --restart=always -i -t -d \
		--name eepsite-github \
		--network eepsite \
		--network-alias eepsite-github \
		--hostname eepsite-github \
		--link eepsite-tor \
		--ip 172.81.81.5 \
		-p 8090:8090 \
		eyedeekay/eepsite-github

clean-github:
	docker rm -f eepsite-github; true

github: build-github run-github

site:
	markdown README.md > website/index.html

build-torhost: network
	docker build --force-rm \
		--build-arg TOR_SOCKS_PORT=9150 \
		--build-arg TOR_SOCKS_HOST=172.81.81.6 \
		--build-arg TOR_CONTROL_PORT=9151 \
		--build-arg TOR_CONTROL_HOST=172.81.81.6 \
		--network eepsite \
		-f Dockerfile.torhost -t eyedeekay/tor-host .

run-torhost: build-torhost network
	docker run --rm -i -t -d \
		--net tbb \
		--name eepsite-tor \
		--network eepsite \
		--network-alias eepsite-tor \
		--hostname eepsite-tor \
		--link eepsite-github \
		--expose 9150 \
		--ip 172.81.81.6 \
		eyedeekay/tor-host; true

torhost: build-torhost run-torhost

network:
	docker network create --subnet 172.81.81.0/29 eepsite; true
