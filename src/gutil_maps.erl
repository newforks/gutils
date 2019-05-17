%%%-------------------------------------------------------------------
%%% @author zhaoweiguo
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 10. May 2019 4:48 PM
%%%-------------------------------------------------------------------
-module(gutil_maps).
-author("zhaoweiguo").

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.
-record(test_record, {id, name, desc, datetime, num}).


%% API
-export([from_record/2]).


from_record(Records, Name) ->
    Keys = get_record_fields(Name),
    Fun= fun(Key, {Lists, Index}) ->
        Value = element(Index, Records),
        {[{gutils:to_list(Key), gutils:to_binary(Value)} | Lists], Index +1}
         end,
    {RecordList, _Index} = lists:foldl(Fun, {[], 2}, Keys),
    io:format(user, "RecordList=~p", [RecordList]),
    maps:from_list(RecordList).



get_record_fields(test_record) ->
    record_info(fields, test_record).



-ifdef(TEST).

normal_test() ->
    Record = #test_record{
        id      = 1,
        name    = binary_to_list(unicode:characters_to_binary("名称")),
%%        name    = unicode:characters_to_list("名称"),
        desc    = binary_to_list(unicode:characters_to_binary("各种不同样的描述在这儿展示")),
        datetime = erlang:timestamp(),
        num     = {a, b, c, d}
    },
    gutil_maps:from_record(Record, test_record).


-endif.