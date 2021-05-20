# build the server binary
FROM golang:1.16.3 AS builder
WORKDIR /app

COPY . .
RUN go build -mod=vendor -o example cmd/example/main.go

# copy the server binary from builder stage; run the server binary
FROM alpine:latest AS runner
WORKDIR /bin

WORKDIR /root/
COPY --from=builder /app/example .
CMD ["./example"]
