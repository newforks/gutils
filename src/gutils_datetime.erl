%%%-------------------------------------------------------------------
%%% @author zhaoweiguo
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 02. Mar 2019 11:43 AM
%%%-------------------------------------------------------------------
-module(gutils_datetime).
-author("zhaoweiguo").

%% API
-export([localtime_ms/1]).


%% returns localtime with milliseconds included
localtime_ms() ->
    Now = os:timestamp(),
    localtime_ms(Now).

localtime_ms(Timestamp) ->
    {_, _, Micro} = Timestamp,
    {Date, {Hours, Minutes, Seconds}} = calendar:now_to_local_time(Timestamp),
    {Date, {Hours, Minutes, Seconds, Micro div 1000 rem 1000}}.




