-module(testOTP1).

-export([start/0,loop/0]).


start() ->
   io:format("~nHello my name is testOTP1~n"),
   timer:sleep(5000),
   io:format("~nStarted Registered Name: hiya Spawned Process Receive Loop~n"),
   register(hiya, spawn(fun() -> loop() end)),
   hiya ! anybodyhomeyet,
   hiya ! {self(), timetotimeout},

 receive
   Pretimeoutmsg ->
     io:format("PreTimeOutMsgIs: ~p~n",[Pretimeoutmsg]),
     io:format("UnRegistering hiya~n"),
     unregister(hiya)
 end,
   timer:sleep(5000),
   io:format("TimeOut GoodBye from testOTP1.erl~n").

loop() ->
 receive
  {Pid,DaMsg}->
     io:format("Spawned Process Received Pid ~p PreTimeoutMsg: ~p~n",[Pid,DaMsg]),
     Pid ! {gotyourmsg,'now you can proceed to timeout'},
   loop();
  AnyMsg ->
     io:format("Spawned Process Received Msg: ~p~n",[AnyMsg]),
   loop()
 end.
