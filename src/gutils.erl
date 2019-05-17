%%%-------------------------------------------------------------------
%%% @author zhaoweiguo
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 10. May 2019 5:59 PM
%%%-------------------------------------------------------------------
-module(gutils).
-author("zhaoweiguo").

%% API
-export([to_binary/1, to_list/1, to_map_elem/1]).



%  任何类型转为binary
to_map_elem(M) when is_map(M) ->
    M;
to_map_elem(M) ->
    to_binary(M).



%  任何类型转为binary
to_binary(M) when is_binary(M) ->
    M;
to_binary(M) ->
    Str = to_list(M),
    list_to_binary(Str).



%  任何类型转为list
to_list(M) when is_list(M) ->
    M;
to_list(M) when is_binary(M) ->
    binary_to_list(M);
to_list(M) when is_pid(M) ->
    pid_to_list(M);
to_list(M) when is_integer(M) ->
    integer_to_list(M);
to_list(M) when is_float(M) ->
    float_to_list(M);
to_list(M) when is_atom(M) ->
    erlang:atom_to_list(M);
to_list(M) ->
    io_lib:format("~p", [M]).


