# build the server binary
FROM golang:1.16.3-alpine AS builder
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 go build -mod=vendor -o example cmd/example/main.go

# copy the server binary from builder stage; run the server binary
FROM alpine:latest AS runner
WORKDIR /bin
COPY --from=builder /app/example .
COPY --from=builder /app/assets/ /app/assets/
CMD ["./example"]
