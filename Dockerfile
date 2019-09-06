FROM ubuntu:latest

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y curl unzip wget git build-essential

# install Go
ENV GOLANG_VERSION 1.12.4
RUN wget https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz && \
  tar -C /usr/local -xzf go$GOLANG_VERSION.linux-amd64.tar.gz && \
  rm go${GOLANG_VERSION}.linux-amd64.tar.gz

ENV PATH $PATH:/usr/local/go/bin
ENV GOROOT /usr/local/go
ENV GOPATH=/root/go
ENV PATH $PATH:$GOPATH/bin

# install nodejs
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs

# install hugo
ENV HUGO_VERSION 0.58.0
RUN curl -Lf -o hugo.zip https://github.com/gohugoio/hugo/archive/v${HUGO_VERSION}.zip && \
  unzip hugo.zip && \
  cd hugo-${HUGO_VERSION} && \
  GOBIN=/usr/local/bin go install -tags extended && \
  cd .. && rm -fr hugo* && \
  hugo version

ENTRYPOINT [ "hugo" ]
EXPOSE 1313