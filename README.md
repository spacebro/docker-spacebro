Spacebro

# Disclaimer

I am learning Docker, this is the first attempt to make a Docker image to run spacebro with spacebroUI

# Start

## Build

```
docker build -t emmanuelgeoffray/spacebro .
```

## Run

```
docker run -it --name MySpacebroContainer -p 36000:36000 -p 36001:36001 emmanuelgeoffray/spacebro
```

## Log in

```
docker exec -it MySpacebroContainer zsh
```

# Use

## Using it with a local spacebro app

```
git clone https://github.com/soixantecircuits/blurrybro
sudo apt-get install imagemagick
nvm use
yarn
node index.js --service.spacebro.host localhost --service.spacebro.port 36000
```

## Connect to spacebroUI

Open a browser with http://localhost:36001

# Remove

docker rm MySpacebroContainer

# More

## Run as daemon

```
docker run -d --name MySpacebroContainer -p 36000:36000 -p 36001:36001 emmanuelgeoffray/spacebro
```

## Start

```
docker start MySpacebroContainer
```

## Stop

```
docker stop MySpacebroContainer
```

## More more

Learn Docker
