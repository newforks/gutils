%%%-------------------------------------------------------------------
%%% @author zhaoweiguo
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 17. May 2019 10:09 AM
%%%-------------------------------------------------------------------
-module(gutil_http_tests).
-author("zhaoweiguo").

-include_lib("eunit/include/eunit.hrl").


encode_test_() ->
    ?_assert(gutil_http:encode() =:= ok).


tohexl_test_() ->



