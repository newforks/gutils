%%%-------------------------------------------------------------------
%%% @author zhaoweiguo
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 16. May 2019 6:07 PM
%%%-------------------------------------------------------------------
-module(gutil_http).
-author("zhaoweiguo").

%% API
-export([encode/0]).
-export([urldecode/3, urlencode/1]).

encode() ->
    ok.


-spec urldecode(binary(), binary(), crash | skip) -> binary().
urldecode(<<$%, H, L, Rest/binary>>, Acc, OnError) ->
    G = unhex(H),
    M = unhex(L),
    if	G =:= error; M =:= error ->
        case OnError of skip -> ok; crash -> erlang:error(badarg) end,
        urldecode(<<H, L, Rest/binary>>, <<Acc/binary, $%>>, OnError);
        true ->
            urldecode(Rest, <<Acc/binary, (G bsl 4 bor M)>>, OnError)
    end;
urldecode(<<$%, Rest/binary>>, Acc, OnError) ->
    case OnError of skip -> ok; crash -> erlang:error(badarg) end,
    urldecode(Rest, <<Acc/binary, $%>>, OnError);
urldecode(<<$+, Rest/binary>>, Acc, OnError) ->
    urldecode(Rest, <<Acc/binary, $ >>, OnError);
urldecode(<<C, Rest/binary>>, Acc, OnError) ->
    urldecode(Rest, <<Acc/binary, C>>, OnError);
urldecode(<<>>, Acc, _OnError) ->
    Acc.


-spec unhex(byte()) -> byte() | error.
unhex(C) when C >= $0, C =< $9 -> C - $0;
unhex(C) when C >= $A, C =< $F -> C - $A + 10;
unhex(C) when C >= $a, C =< $f -> C - $a + 10;
unhex(_) -> error.


%% @doc URL encode a string binary.
%% @equiv urlencode(Bin, [])
-spec urlencode(binary()) -> binary().
urlencode(Bin) ->
    urlencode(Bin, []).


%% @doc URL encode a string binary.
%% The `noplus' option disables the default behaviour of quoting space
%% characters, `\s', as `+'. The `upper' option overrides the default behaviour
%% of writing hex numbers using lowecase letters to using uppercase letters
%% instead.
-spec urlencode(binary(), [noplus|upper]) -> binary().
urlencode(Bin, Opts) ->
    Plus = not lists:member(noplus, Opts),
    Upper = lists:member(upper, Opts),
    urlencode(Bin, <<>>, Plus, Upper).

-spec urlencode(binary(), binary(), boolean(), boolean()) -> binary().
urlencode(<<C, Rest/binary>>, Acc, P=Plus, U=Upper) ->
    if	C >= $0, C =< $9 -> urlencode(Rest, <<Acc/binary, C>>, P, U);
        C >= $A, C =< $Z -> urlencode(Rest, <<Acc/binary, C>>, P, U);
        C >= $a, C =< $z -> urlencode(Rest, <<Acc/binary, C>>, P, U);
        C =:= $.; C =:= $-; C =:= $~; C =:= $_ ->
            urlencode(Rest, <<Acc/binary, C>>, P, U);
        C =:= $ , Plus ->
            urlencode(Rest, <<Acc/binary, $+>>, P, U);
        true ->
            H = C band 16#F0 bsr 4, L = C band 16#0F,
            H1 = if Upper -> tohexu(H); true -> tohexl(H) end,
            L1 = if Upper -> tohexu(L); true -> tohexl(L) end,
            urlencode(Rest, <<Acc/binary, $%, H1, L1>>, P, U)
    end;
urlencode(<<>>, Acc, _Plus, _Upper) ->
    Acc.



-spec tohexu(byte()) -> byte().
tohexu(C) when C < 10 -> $0 + C;
tohexu(C) when C < 17 -> $A + C - 10.

-spec tohexl(byte()) -> byte().
tohexl(C) when C < 10 -> $0 + C;
tohexl(C) when C < 17 -> $a + C - 10.





