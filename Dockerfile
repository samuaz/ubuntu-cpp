FROM amd64/ubuntu:bionic
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y apt-utils cmake g++ make build-essential
RUN apt-get install -y git maven gradle
RUN apt-get install -y postgresql postgresql-contrib libpqxx-4.0v5 libpq-dev libpqxx-dev
RUN apt-get install -y libmysqlcppconn-dev
RUN git clone https://github.com/oktal/pistache.git
RUN cd pistache && git submodule update --init && mkdir build && cd build && cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release .. && make && make install

CMD ["/bin/bash"]
