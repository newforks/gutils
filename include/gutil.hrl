

-define(LOG(M), io:format("[~p~p:~p ~p()]  "++M, [self(), ?MODULE, ?LINE, ?FUNCTION_NAME])).
-define(LOGLN(M), io:format("[~p~p:~p ~p()]  "++M++"~n", [self(), ?MODULE, ?LINE, ?FUNCTION_NAME])).
-define(LOGF(M, P), io:format("[~p~p:~p ~p()]  "++M, [?MODULE, ?LINE, ?FUNCTION_NAME] ++ P)).

-define(FILE_DEBUG(Msg),
  {ok,F} = file:open("abc.txt", [append]),
  file:write(F, io_lib:format("~p~n", [Msg]))
).


-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

-define(CHILD_PARAM(I, Type, Param), {I, {I, start_link, Param}, permanent, 5000, Type, [I]}).


-define(TEXT_HEAD2,
  #{<<"content-Type">> => <<"text/plain; charset=utf-8">>}).

-define(TEXT_HEAD,
  #{<<"content-Type">> => <<"text/plain; charset=utf-8">>
    ,<<"Cache-Control">> => <<"no-cache">>
    ,<<"Expires">> => <<"Sat, 25 Dec 1999 00:00:00 GMT">>
    ,<<"Pragma">> => <<"no-cache">>
    ,<<"Access-Control-Allow-Credentials">> => <<"true">>
    ,<<"Access-Control-Allow-Origin">> => <<"null">>}).


