module CpuMemMonitor

export start_monitor

"""
    function start_monitor(
        pid::Int64,
        fn::String; # file name used for saving info
        iterations::Int64 = 8,
        interval::Int64 = 1,
        outer_interval::Int64 = 3600
    )

    Save CPU and MEM info to two files, respectively.
"""
function start_monitor(
    pid::Int64,
    fn::String;
    iterations::Int64 = 8,
    interval::Int64 = 1,
    outer_interval::Int64 = 3600,
    kwargs...
)
    str = get(kwargs, :additionalStr, 0)
    if str ≠ 0
        fn *= str
    end

    bash_script = "#!/bin/bash
while true; do
    sleep $outer_interval
    if kill -0 $pid > /dev/null 2>&1; then
        for i in \$( seq 1 1 $iterations )
        do
            ps -p $pid -o %cpu | awk \'NR==2\' >> $fn.cpu
            mem_usage=\$(ps -p $pid -o rss | awk \'NR==2\')
            echo \"scale=2; \$mem_usage/1024/1024\" | bc >> $fn.mem
            sleep $interval
        done
    else
        break
    fi
done"

    bashfn = fn*".sh"
    io = open(bashfn, "w")
    println(io, bash_script)
    close(io)

    run(`chmod u+rwx $bashfn`)
    run(`bash -c "nohup bash $bashfn > /dev/null 2>&1 &"`)
    sleep(3)
    run(`rm $bashfn`)

end

end # module CpuMemMonitor
