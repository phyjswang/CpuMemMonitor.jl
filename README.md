# CpuMemMonitor.jl

A simple package to monitor cpu and memory usage of a job with a given PID. Currently it only supports linux system.

## Installation

```julia
] add https://github.com/phymann/CpuMemMonitor.jl
```

## Usage

Using the following function, two files, named `$fn.cpu` and `$fn.mem` will be used to save cpu and mem info, respectively.

The info will be recorded every `interval` seconds for `iterations` times, and wait for another `outer_interval` seconds to repeat.

This process will end if the corresponding `pid` does not exist.

```julia
function start_monitor(
    pid::Int64,
    fn::String; # file name for saving info
    iterations::Int64 = 8,
    interval::Int64 = 1,
    outer_interval::Int64 = 3600
)
```

Note the `pid` for the current job can be obtained using `getpid()` in julia.
