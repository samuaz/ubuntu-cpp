FROM amd64/ubuntu:bionic as ubuntu
RUN apt-get update && apt-get install -y apt-utils cmake g++ make build-essential
# Build the command inside the container.
# (You may fetch or manage dependencies here,
# either manually or with a tool like "godep".)

RUN git clone https://github.com/oktal/pistache.git
&& git submodule update --init
&& cd pistache
&& mkdir build
&& cd build
&& cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release ..
&& make
&& sudo make install

# Copy local code to the container image.
WORKDIR hellogcp
COPY . .

RUN ls
RUN mkdir build && cd build && cmake .. && make

RUN ls
RUN ls /home

# Use a Docker multi-stage build to create a lean production image.
# https://docs.docker.com/develop/develop-images/multistage-build/#use-multi-stage-builds
FROM alpine

RUN ls

RUN ls /home

# Copy the binary to the production image from the builder stage.
COPY --from=ubuntu hellogcp/build/hellogcp /hellogcp

# Run the web service on container startup.
CMD ["/hellogcp"]