# Compilation step
FROM golang:alpine AS compiler

WORKDIR /usr/src/app

COPY . .

# Generating mod in container because it's not needed to have Go in local machine
RUN go mod init rodrigoorlandini/golang && go build -o compiled

# Execution step
FROM scratch

COPY --from=compiler /usr/src/app/compiled compiled

ENTRYPOINT [ "./compiled" ] 