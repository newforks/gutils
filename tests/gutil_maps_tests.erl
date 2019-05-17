%%%-------------------------------------------------------------------
%%% @author zhaoweiguo
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 10. May 2019 4:50 PM
%%%-------------------------------------------------------------------
-module(gutil_maps_tests).
-author("zhaoweiguo").

-include_lib("eunit/include/eunit.hrl").
-record(store, {id, name, desc, datetime, num}).

normal_test() ->
    Record = #store{
        id      = 1,
        name    = "名称",
        desc    = "各种不同样的描述在这儿展示",
        datetime = erlang:timestamp(),
        num     = {a, b, c, d}
    },
    gutil_maps:from_record(Record, store).





