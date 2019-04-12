FROM amd64/ubuntu:bionic
RUN apt-get update && apt-get install -y apt-utils cmake g++ make build-essential
RUN apt-get install -y postgresql postgresql-contrib libpqxx-4.0v5 libpq-dev libpqxx-dev
RUN apt-get install -y libmysqlcppconn-dev

RUN git clone https://github.com/oktal/pistache.git && git submodule update --init
RUN cd pistache
RUN mkdir build
RUN cd build
RUN cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release ..
RUN make
RUN sudo make install

CMD ["/bin/bash"]
