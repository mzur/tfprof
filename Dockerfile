FROM openjdk:8

RUN echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list \
  && curl https://bazel.build/bazel-release.pub.gpg | apt-key add -

RUN apt-get update \
    && apt-get install -y --no-install-recommends bazel patch \
    && rm -rf /var/lib/apt/lists/*

ARG TF_VERSION=1.12.0
RUN curl -L https://github.com/tensorflow/tensorflow/archive/v${TF_VERSION}.tar.gz -o v${TF_VERSION}.tar.gz \
    && tar -xzf v${TF_VERSION}.tar.gz \
    && cd tensorflow-${TF_VERSION} \
    && bazel build --incompatible_remove_native_http_archive=false //tensorflow/core/profiler/... \
    && mv bazel-bin/tensorflow/core/profiler/profiler /usr/bin/tfprof \
    && rm -r /tensorflow-${TF_VERSION} \
    && rm /v${TF_VERSION}.tar.gz

FROM debian
COPY --from=0 /usr/bin/tfprof /usr/bin/tfprof
CMD tfprof
