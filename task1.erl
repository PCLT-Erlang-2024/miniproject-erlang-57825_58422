-module(task1).
-export([main/3, producer/2, conveyor/1, trucks/2]).



launchConveyers(0, _, _) ->
    exit;
launchConveyers(Num_conveyor, Num_packages_per_conveyor, Default_Truck_capacity) ->
    Pid_trucks = spawn(?MODULE, trucks, [Default_Truck_capacity, Default_Truck_capacity]),
    Pid_conveyer = spawn(?MODULE, conveyor, [Pid_trucks]),
    spawn(?MODULE, producer, [Num_packages_per_conveyor, Pid_conveyer]),
    launchConveyers(Num_conveyor-1, Num_packages_per_conveyor, Default_Truck_capacity).



producer(0, _) ->
    exit;
producer(Num_packages_per_conveyor, Pid) ->
    io:format("Producer ~p, sending package to conveyor ~p.~n", [self(), Pid]),
    Pid ! {self(), package},
    producer(Num_packages_per_conveyor-1, Pid),
    exit.

conveyor(Pid_trucks) -> 
    receive
        {Pid, package} -> 
            io:format("Conveyor ~p, received from producer ~p.~n", [self(), Pid]),
            Pid_trucks ! {self(), package},
            conveyor(Pid_trucks)
    end.


trucks(0, Default_Truck_capacity) -> 
    io:format("Truck can't take this package new truck needed.~n"),
    trucks(Default_Truck_capacity, Default_Truck_capacity);
trucks(Truck_capacity, Default_Truck_capacity) ->
    receive 
        {Pid, package} -> 
            io:format("Truck depot ~p, received from conveyor ~p.~n", [self(), Pid]),
            trucks(Truck_capacity-1, Default_Truck_capacity)
    end.


main(Num_conveyor, Num_packages_per_conveyor, Truck_capacity) ->
    launchConveyers(Num_conveyor, Num_packages_per_conveyor, Truck_capacity).


