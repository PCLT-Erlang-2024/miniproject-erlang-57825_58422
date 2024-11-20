# miniproject-erlang
# PCLT - Actor-based Concurrency Module

## Erlang Lab Class #2 - Miniproject

**Note that the mini-project is the same for the three modules (Go, Rust, Erlang).** 

**DEADLINE** 27/11/2024 23:59

---
To submit your answers, simply push your files onto the repository. The problem will be graded.

---

## Product Distribution System
The goal of this mini-project is to design and implement a concurrent product distribution system using Erlang’s process-based concurrency model. The system will simulate a factory that handles the shipment of products to clients using a fleet of trucks and multiple conveyor belts.

### General Requirements
* Concurrency: The system must use independent Erlang processes to model conveyor belts and trucks.
* Deadlock-Free: Ensure the absence of deadlocks; all packages must eventually be loaded onto trucks.
* Progress Guarantee: All parts of the system must keep working to process and deliver packages.
* Message Passing: Use Erlang’s message-passing mechanisms for synchronization and coordination.

## Task 1: Core System
#### Goal: Implement the basic system with continuous operation.

* Implement the core system.
* Must account for multiple conveyor belts being “fed” packages continuously and multiple trucks.
* Assume that when a truck is full it can be replaced instantly.
* Conveyor belts can run continuously.
* You need not be very realistic or precise with time, but the relative order of events should be the expected one: a package is loaded onto a conveyor belt before it gets loaded onto a non-full truck.
* The order of events must follow logical steps: a package is created, placed on a conveyor belt, and then loaded onto a non-full truck.

**Note:** Add a small report to the task 1 folder that explains what correctness properties your system has and what achieves them.

## Task 2: Variable Package Sizes
### Goal: Extend the system to support packages of different sizes.

#### Enhancements:
* Each package generated by a conveyor belt has a size (randomly determined or specified).
* Trucks are loaded unevenly based on the size of the packages.
#### Behavior:
* A truck can only load a package if it has enough remaining capacity.
* The system must log package sizes and the updated capacity of trucks after each loading.
  
**Note:** Add a small report to the task 2 folder that explains what correctness properties your system has and what achieves them.

## Task 3: Non-Instant Truck Replacement
#### Goal: Extend the system to introduce delays for replacing trucks.

#### Enhancements:
* When a truck is full, it takes a non-zero amount of time to be replaced.
* Conveyor belts must pause their operation while waiting for the replacement of a truck at their endpoint.
#### Behavior:
* During truck replacement, a conveyor belt must stop feeding packages to avoid overflows.
* Once the truck is replaced, the conveyor belt resumes its operation.

**Note:** Add a small report to the task 3 folder that explains what correctness properties your system has and what achieves them.
