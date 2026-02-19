FROM golang:1.23 AS builder
WORKDIR /app

# copy 
COPY go.mod ./
COPY main.go ./
COPY templates ./templates

# build static binary 
RUN CGO_ENABLED=0 go build -o app .

FROM scratch
WORKDIR /

COPY --from=builder /app/app /app
COPY --from=builder /app/templates /templates

# port 8080
EXPOSE 8080

# run the binary 
ENTRYPOINT ["/app"]