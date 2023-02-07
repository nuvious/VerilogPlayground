FROM alpine:latest as builder

# Install dependencies
RUN apk --no-cache update
RUN apk --no-cache add build-base autoconf make automake gperf dos2unix flex bison

# Copy code over
RUN mkdir -p /app
COPY iverilog/ /app/iverilog/

# Attemp to convert line endings to unix; some files were problematic after a fresh git pull
RUN find . -type f -print0 | xargs -0 dos2unix || exit 0

# Install iverilog
WORKDIR /app/iverilog
RUN /bin/sh autoconf.sh
RUN /bin/sh ./configure
RUN make

# Final stage of container
FROM alpine:latest as final

# Install minimum dependencies for running regression testing
# TODO: See if perl and build-base can be removed/reduced further
RUN apk --no-cache add perl build-base make

# Copy files from builder with compiled binaries
COPY --from=builder /app/iverilog/ /app/iverilog/
WORKDIR /app/iverilog

# Install the built binaries
RUN make install

# Run unit tests
WORKDIR /app/iverilog/ivtest
RUN perl vvp_reg.pl

# Cleanup, copy examples over and make /workspace default directory
RUN rm -rf /app
COPY --from=builder /app/iverilog/examples/ /examples/
WORKDIR /workspace 

ENTRYPOINT [ "/bin/sh" ]