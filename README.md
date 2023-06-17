# CpuMemMonitor.jl

A simple package to monitor cpu and memory usage of a job with a given PID. Currently it only supports linux system.

## Installation

```julia
] add https://github.com/phymann/CpuMemMonitor.jl
```

## Usage

```julia
function start_monitor(
    pid::Int64,
    fn::String;
    iterations::Int64 = 8,
    interval::Int64 = 1,
    outer_interval::Int64 = 3600
)
```
