-module(testOTP1).

-export([start/0,loop/0]).


start() ->
   io:format("~nHello my name is testOTP1~n"),
   timer:sleep(3000),
    Handle = bitcask:open("testOTP1_database", [read_write]),
    N = fetch(Handle),
    store(Handle, N+1),
    io:format("testOTP1 has been run ~p times~n",[N]),
    bitcask:close(Handle),
   io:format("~nStarted Registered Name: hiya Spawned Process Receive Loop~n"),
   register(hiya, spawn(fun() -> loop() end)),
   timer:sleep(2000),
   hiya ! anybodyhomeyet,
   timer:sleep(2000),
   hiya ! {self(), timetotimeout},

 receive
   Pretimeoutmsg ->
     io:format("PreTimeOutMsgIs: ~p~n",[Pretimeoutmsg]),
     io:format("UnRegistering hiya~n"),
     unregister(hiya)
 end,
   timer:sleep(5000),
   io:format("TimeOut GoodBye from testOTP1.erl~n"),
   io:format("Doing init:stop~n"),
   init:stop().


store(Handle, N) ->
    bitcask:put(Handle, <<"testOTP1_executions">>, term_to_binary(N)).  

fetch(Handle) ->
    case bitcask:get(Handle, <<"testOTP1_executions">>) of
	not_found -> 1;
	{ok, Bin} -> binary_to_term(Bin)
    end.


loop() ->
 receive
  {Pid,DaMsg}->
     io:format("Spawned Process Received Pid ~p PreTimeoutMsg: ~p~n",[Pid,DaMsg]),
     timer:sleep(2000),
     Pid ! {gotyourmsg,'now you can proceed to timeout'},
   loop();
  AnyMsg ->
     io:format("Spawned Process Received Msg: ~p~n",[AnyMsg]),
   loop()
 end.
