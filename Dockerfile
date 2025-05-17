# Building the binary of the App
FROM golang:1.19 AS build

WORKDIR /go/src/evgenii_app
COPY . .
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /go/src/evgenii_app/app_itself


FROM alpine:3.17.0 as release

WORKDIR /app
COPY --from=build  /go/src/evgenii_app/app_itself .
COPY --from=build  /go/src/evgenii_app/assets ./assets
COPY wizexercise.txt ./wizexercise.txt
EXPOSE 8080
ENTRYPOINT ["/app/app_itself"]


