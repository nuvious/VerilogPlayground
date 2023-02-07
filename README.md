# iverilog Playground

Just a code playground for verilog.

## Development Environment

The development environment is based off of v12 of iverilog. To build the
container simply run the following:

```bash
docker build -t iverilog .
```

To launch the development environment in interactive mode run:

```bash
# Powershell or unix shell; assumes you're launching from your root source directory
docker run -it --rm -v $PWD:/workspace /bin/sh
```

You can then run compilations and executions from the internal shell:

```bash
/workspace # iverilog /examples/hello.vl
/workspace # ./a.out
Hello, World
/examples/hello.vl:46: $finish called at 0 (1s)
```

## Examples

- [Simple N-bit counter](examples/division/README.md)
- [Naive integer division](examples/division/README.md)
- [Fastmod implementation](examples/fastmod/README.md)