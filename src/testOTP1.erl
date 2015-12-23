-module(testOTP1).

-export([start/0]).


start() ->
   io:format("Hello my name is testOTP1~n"),
   timer:sleep(5000),
   io:format("TimeOut GoodBye from testOTP1.erl~n").
