FROM amd64/ubuntu:bionic
RUN apt-get update && apt-get install -y apt-utils cmake g++ make build-essential
RUN apt-get install -y postgresql postgresql-contrib libpqxx-4.0v5 libpq-dev libpqxx-dev
RUN apt-get install -y libmysqlcppconn-dev

RUN git clone https://github.com/oktal/pistache.git
&& git submodule update --init
&& cd pistache
&& mkdir build
&& cd build
&& cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release ..
&& make
&& sudo make install

CMD ["/bin/bash"]
