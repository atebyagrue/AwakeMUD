FROM ubuntu:18.04


# Set West Coast TZ for R.P. purposes
ENV TZ="US/Pacific"
RUN date

# RUN sudo apt update && sudo apt upgrade -y
RUN apt update && apt upgrade -y
RUN apt-get install -y automake make gcc g++ clang libtool autoconf zlib1g-dev libcurl4-openssl-dev libmysqlclient-dev wget build-essential vim

# TODO: add mysql-client to the list of packages to install, "Install MySQL 5.7, including its development headers (ensure mysql/mysql.h exists in your path)."
# NOTES: you also need mysql server installed & configured...
# � need to ivestigate how to specify the servername so we can determine if separate server is possible
RUN apt-get install -y mysql-server mysql-client libmysqlclient-dev

# to fix UBuntu Boost library weirdness
RUN apt-get install -y libboost-all-dev

# apt cleanup
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Setup App Area (COPY releative to Dcokerfile location...)
RUN mkdir -p /app
COPY . /app
WORKDIR /app

# libsodium - latest stable reelease on 2024-02-22
RUN cd /app/src
ADD https://download.libsodium.org/libsodium/releases/libsodium-1.0.19-stable.tar.gz .
RUN tar -xvf libsodium-1.0.19-stable.tar.gz
RUN cd /app/libsodium-stable && ./configure && make && make check && make install clean

# MySQL Setup
RUN service mysql start
# RUN service mysql start && cd /app/SQL && ./gensql_new.sh

# # Housing
# RUN mv /app/lib/etc/houses.template /app/lib/etc/houses

# # Finally, make for AwakeMUD
# RUN cd /app/src && make clean & make

# # # Runnit
# ENTRYPOINT cd /app && ./bin/awake

# Debug Container
ENTRYPOINT ["tail", "-f", "/dev/null"]