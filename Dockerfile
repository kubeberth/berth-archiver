FROM ubuntu:20.04

ENV TZ=Asia/Tokyo

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update && apt install -y golang-go wget qemu-utils
RUN wget "https://dl.min.io/client/mc/release/`go env GOOS`-`go env GOARCH`/mc" > /dev/null && \
	chmod +x ./mc && mv ./mc /usr/local/bin

ADD ./scripts/entrypoint.sh ./

CMD ["./entrypoint.sh"]
