
(*  *)
fun incrementExposure(x::xs, j::jk) =
     let 
       val s = healthStatus(x)
       val days = #5x + 1
       val noChange = j::jk
       val perps = j::jk@[(#1x,#2x,#3x,#4x,days,#6x,#7x)]
       val perps = delete(x, perps)
     in 
       if
         s > 1
       then
         incrementExposure(xs, perps)
       else 
         incrementExposure(xs, noChange)
     end
  | incrementExposure(x::xs,[])= []
  | incrementExposure([], j::jk) = j::jk
  | incrementExposure([],[]) = [];

(*  *)
fun incrementIncubation(x::xs, j::jk) =
     let 
       val s = healthStatus(x)
       val days = #6x + 1
       val noChange = j::jk
       val perps = j::jk@[(#1x,#2x,#3x,#4x,#5x,days,#7x)]
       val perps = delete(x, perps)
     in 
       if
         s > 2
       then
         incrementIncubation(xs, perps)
       else 
         incrementIncubation(xs, noChange)
     end
  | incrementIncubation(x::xs,[])= []
  | incrementIncubation([], j::jk) = j::jk              
  | incrementIncubation([],[]) = [];

(* daysOfOurLives(population, infected, healthy, infected_groups) *)
fun daysOfOurLives(x::xs, y::yz, j::jk, f::fg) = 
     let
       val infected = incrementExposure(y::yz, y::yz)
       val infected = incrementIncubation(infected, infected)
       val infected = diceOfFever(infected, infected)
       val infected = diceOfRash(infected, infected)
       val infected = diceOfPustules(infected, infected)
       val infected = diceOfDeath(infected, infected)
       val infected = diceOfHealth(infected, infected)
       val healthy = diceOfInfect(j::jk, f::fg, j::jk, f::fg)
       val population = healthy@infected
       val population = unique(population)
       val pop_length = length population -1
       val healthy = findHealthy(population, pop_length)
       val infected = findInfected(population, pop_length)
       val num_infected = length infected - 1
       val infected_groups = infectedGroups(infected, num_infected, [])
       val infected_groups = sort(infected_groups)
       val infected_groups = tuplefy(infected_groups, [])
       val infected_groups = unique(infected_groups)
     in
       if 
         num_infected = 0 - 1 
       then 
         daysOfOurLives(population, [], healthy, [])
       else 
         daysOfOurLives(population,infected,healthy,infected_groups)
     end    
  (* The next state is the success state *)
  | daysOfOurLives(x::xs, [], j::jk, []) = x::xs
  | daysOfOurLives([], y::yz, j::jk, f::fg) = []
  | daysOfOurLives(x::xs, [], j::jk, f::fg) = []
  | daysOfOurLives(x::xs, y::yz, [], f::fg) = []
  | daysOfOurLives(x::xs, y::yz, j::jk, []) = []
  | daysOfOurLives([], [], j::jk, f::fg) = []
  | daysOfOurLives([], y::yz, [], f::fg) = []
  | daysOfOurLives([], y::yz, j::jk, []) = []
  | daysOfOurLives(x::xs, [], [], f::fg) = []
  | daysOfOurLives(x::xs, y::yz, [], []) = []
  | daysOfOurLives([], [], [], f::fg) = []
  | daysOfOurLives([], [], j::jk, []) = []
  | daysOfOurLives([], y::yz, [], []) = []
  | daysOfOurLives(x::xs, [], [], []) = []
  | daysOfOurLives([], [], [], []) = [];
