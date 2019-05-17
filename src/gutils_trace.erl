%%%-------------------------------------------------------------------
%% @doc gutils public API
%% @end
%%%-------------------------------------------------------------------

-module(gutils_trace).

-export([trace_process/1, trace_process/2]).
 
trace_process(Pid) when is_pid(Pid)->
    trace_process(Pid, "/tmp/dbg.log").
 
trace_process(Pid, FileName) when is_pid(Pid)->
    dbg:stop(),
    dbg:start(),
    {ok, IO} = file:open(FileName, [append]),
    {ok, Pid} = dbg:tracer(process, {fun dbg:dhandler/2, IO}),
    erlang:spawn(fun() -> monitor_init(Pid, IO) end),
    dbg:p(Pid,[m,p]).

monitor_init(Pid, IO) ->
    Mref = erlang:monitor(process, Pid),
    monitor_loop(Mref, IO).
monitor_loop(Mref, IO) ->
    receive
        {'DOWN', Mref, _, _, _} ->
            file:close(IO),
            dbg:stop()
    after 1800000 ->
        file:close(IO),
        dbg:stop()
    end.
 







