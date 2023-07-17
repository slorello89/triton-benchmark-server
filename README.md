# Benchmarking Triton Server

On a GCP VM (minimum specs n-1-standard-4 with a NVIDIA T4 GPU, 30GB of storage)

clone this repo:

```sh
git clone https://github.com/slorello89/triton-benchmark-server
cd triton-benchmark-server
```

Run the following to configure the vm

```sh
sh setup.sh
```

## Testing no cache

run

`docker compose up`

on a separate client instance run the client image:

```sh
docker run -it --rm --net=host nvcr.io/nvidia/tritonserver:23.06-py3-sdk
```

then you can run the benchmark by running the following from the client image
```sh
perf_analyzer -u your_host:port -m densenet_onnx
```

## Testing local cache

run

`docker compose -f docker-compose-local.yml up`

on a separate client instance run the client image:

```sh
docker run -it --rm --net=host nvcr.io/nvidia/tritonserver:23.06-py3-sdk
```

then you can run the benchmark by running the following from the client image
```sh
perf_analyzer -u your_host:port -m densenet_onnx
```

## Testing local cache

On your triton server machine run

`docker compose -f docker-compose-local.yml up`

on a separate client instance run the client image:

```sh
docker run -it --rm --net=host nvcr.io/nvidia/tritonserver:23.06-py3-sdk
```

then you can run the benchmark by running the following from the client image

```sh
perf_analyzer -u your_host:port -m densenet_onnx
```

## Testing Redis cache

Ensure that you have a separate VM running in the same sub-net / vpc reachable from your triton server instance.
Take the host-name or IP along with the port of Redis and modify `docker-compose-redis.yml` to the correct values

On your triton server machine run

`docker compose -f docker-compose-redis.yml up`

on a separate client instance run the client image:

```sh
docker run -it --rm --net=host nvcr.io/nvidia/tritonserver:23.06-py3-sdk
```

then you can run the benchmark by running the following from the client image

```sh
perf_analyzer -u your_host:port -m densenet_onnx
```