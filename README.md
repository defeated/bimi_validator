# BIMI Validator

## Build

```
docker build -t bimi-app:latest .
```

## Run

```
docker run \
  --rm -it \
  -v "$PWD:/app:delegated" \
  -p "3000:3000" \
  bimi-app:latest
```
