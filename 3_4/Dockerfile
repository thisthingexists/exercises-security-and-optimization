FROM docker:cli
WORKDIR /usr/src/app
COPY builder.sh .
RUN chmod +x ./builder.sh
ENTRYPOINT [ "./builder.sh" ]

