FROM alpine:latest as builder

RUN apk --no-cache update
RUN apk --no-cache add build-base autoconf make automake gperf dos2unix flex bison

RUN mkdir -p /app
COPY iverilog/ /app/iverilog/

# Attemp to convert line endings to unix
RUN find . -type f -print0 | xargs -0 dos2unix || exit 0

# Install iverilog
WORKDIR /app/iverilog
RUN /bin/sh autoconf.sh
RUN /bin/sh ./configure
RUN make

FROM alpine:latest

RUN apk --no-cache add perl build-base make
COPY --from=builder /app/iverilog/ /app/iverilog/
WORKDIR /app/iverilog
RUN make install
WORKDIR /app/iverilog/ivtest
RUN perl vvp_reg.pl
WORKDIR /workspace 
COPY --from=builder /app/iverilog/examples/ /examples/
RUN rm -rf /app

ENTRYPOINT [ "/bin/sh" ]