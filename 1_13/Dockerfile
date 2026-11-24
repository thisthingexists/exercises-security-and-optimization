FROM golang:1.16
EXPOSE 8080
WORKDIR /usr/src/app
COPY . .
ENV ping=pong
RUN go build
CMD ["./server"]