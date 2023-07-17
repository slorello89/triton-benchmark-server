# Benchmarking triton server

Run this in a GCP instance with a minimum of an n-1-standard-4 with a NVIDIA T4 GPU

Run

```sh
sh setup.sh
```

to configure the instance

## Testing no cache

run
`docker compose up`
on a separate client instance run 

```sh
perf_analyzer -u your_host:port -m simple
```