# TensorFlow Profiler Docker Image

This is a Docker image containing the [TensorFlow Profiler](https://github.com/tensorflow/tensorflow/tree/master/tensorflow/core/profiler).

## Usage

Assuming you have the existing TensorFlow profile `profile_0` in the current working directory:

```
docker run --rm -it -v $(pwd):/profiles mzur/tfprof tfprof --profile_path=/profiles/profile_0
```

## Build

```
docker build -t mzur/tfprof .
```
