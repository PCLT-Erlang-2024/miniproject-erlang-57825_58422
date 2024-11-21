-module(task2).
-export([main/4, producer/3, conveyor/1, trucks/2]).



launchConveyers(0, _, _, _ ) ->
    exit;
launchConveyers(Num_conveyor, Num_packages_per_conveyor, Deafault_truck_size, Max_package_size) ->
    Pid_trucks = spawn(?MODULE, trucks, [Deafault_truck_size, Deafault_truck_size]),
    Pid_conveyer = spawn(?MODULE, conveyor, [Pid_trucks]),
    spawn(?MODULE, producer, [Num_packages_per_conveyor, Pid_conveyer, Max_package_size]),
    launchConveyers(Num_conveyor-1, Num_packages_per_conveyor, Deafault_truck_size, Max_package_size).



producer(0, _, _) ->
    exit;
producer(Num_packages_per_conveyor, Pid, Max_package_size) ->
    Package_size = rand:uniform(Max_package_size),
    io:format("Producer ~p, sending package with size, ~p, to conveyor ~p.~n", [self(), Package_size, Pid]),
    Pid ! {self(), package, Package_size},
    producer(Num_packages_per_conveyor-1, Pid, Max_package_size),
    exit.


conveyor(Pid_trucks) -> 
    receive
        {Pid, package, Max_package_size} -> 
            io:format("Conveyor ~p, received from producer ~p.~n", [self(), Pid]),
            Pid_trucks ! {self(), package, Max_package_size},
            conveyor(Pid_trucks)
    end.

trucks(Truck_size, Deafault_truck_size) ->
    receive 
        {Pid, package, Max_package_size} -> 
            io:format("Truck depot ~p, received from conveyor ~p.~n", [self(), Pid]),
            if 
                Max_package_size > Truck_size -> 
                    io:format("Truck can't take this package new truck needed.~n"),
                    trucks(Deafault_truck_size, Deafault_truck_size);
                Truck_size >= Max_package_size ->
                    trucks(Truck_size - Max_package_size, Deafault_truck_size)
            end
    end.


main(Num_conveyor, Num_packages_per_conveyor, Truck_size, Max_package_size ) ->
    Package_size = rand:uniform(Max_package_size),
    io:format("testing random value ~p~n", [Package_size]),
    launchConveyers(Num_conveyor, Num_packages_per_conveyor, Truck_size, Max_package_size).


