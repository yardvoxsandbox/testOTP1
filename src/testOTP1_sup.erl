-module(testOTP1_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
     RestartStrategy = {one_for_one, 10, 100},
     Server = {testOTP1, {testOTP1, start, []},
          permanent, 2000, worker, [testOTP1]},
     Children = [Server],
     {ok, {RestartStrategy, Children}}.

%%     Server = {testOTP1, {testOTP1, start, []},
%%    {ok, { {one_for_one, 5, 10}, []} }.
%%     RestartStrategy = {one_for_one, 0, 1},
%%     RestartStrategy = {one_for_one, 1, 1},
%%     RestartStrategy = {one_for_one, 10, 100},
%%          permanent, brutal_kill, worker, [testOTP1]},
%%          permanent, 20, worker, [testOTP1]},
%%          permanent, 2000, worker, [testOTP1]},
%%     RestartStrategy = {one_for_one, 2, 20},
