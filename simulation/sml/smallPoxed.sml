(* creates our random variables *)
 use "randomize.sml";

(* generates the population and provides some functionality *)
 use "population.sml";

(* let's get this party started... *)
 use "peskySmallPox.sml";

(* los dados de la vida *)
 use "dice.sml";

(* these were the days of our lives *)
 use "daysOfOurLives.sml";

(* initial infection of a group *)
 val population = isVictim(population,pop_length,randomly_chosen_sadly_to_die);

(* seperate the living from the living-dead *)
 val healthy = findHealthy(population, pop_length);
 val infected = findInfected(population, pop_length);

(* make a list of tuples containing infected groups and the number of people in the group *)
 val num_infected = length infected ;
 val infected_groups = infectedGroups(infected, num_infected - 1, []); 
 val infected_groups = sort(infected_groups);
 val infected_groups = tuplefy(infected_groups, []);
 val infected_groups = unique(infected_groups);

(* 48 hours of initial spread of contamination simulated by two rolls of the dice of contam *)
 val healthy = diceOfContam(healthy, infected_groups, healthy, []);
 val population = healthy@infected;
 val population = unique(population);
 val pop_length = length population -1;
 val healthy = findHealthy(population, pop_length);
 val infected = findInfected(population, pop_length);
 val num_infected = length infected - 1;
 val infected_groups = infectedGroups(infected, num_infected, []); 
 val infected_groups = sort(infected_groups);
 val infected_groups = tuplefy(infected_groups, []);
 val infected_groups = unique(infected_groups);
 val healthy = diceOfContam(healthy, infected_groups, healthy, []);
 val population = healthy@infected;
 val population = unique(population);
 val pop_length = length population -1;
 val healthy = findHealthy(population, pop_length);
 val infected = findInfected(population, pop_length);
 val num_infected = length infected - 1;
 val infected_groups = infectedGroups(infected, num_infected, []); 
 val infected_groups = sort(infected_groups);
 val infected_groups = tuplefy(infected_groups, []);
 val infected_groups = unique(infected_groups);

(* each contaminated person has a chance of becoming infected *)
 val infected = diceOfInitialInfection(infected, infected);
 val population = healthy@infected;
 val population = unique(population);
 val pop_length = length population -1;
 val healthy = findHealthy(population, pop_length);
 val infected = findInfected(population, pop_length);
 val num_infected = length infected - 1;
 val infected_groups = infectedGroups(infected, num_infected, []); 
 val infected_groups = sort(infected_groups);
 val infected_groups = tuplefy(infected_groups, []);
 val infected_groups = unique(infected_groups);

(* run the first few days manually, all following days will be recursive days of our lives *)
 val infected = incrementExposure(infected, infected);
 val infected = incrementIncubation(infected, infected);
 val infected = diceOfFever(infected, infected);
 val infected = diceOfRash(infected, infected);
 val infected = diceOfPustules(infected, infected);
 val infected = diceOfDeath(infected, infected);
 val infected = diceOfHealth(infected, infected);
 val healthy = diceOfInfect(healthy, infected_groups, healthy, infected_groups);
 val population = healthy@infected;
 val population = unique(population);
 val pop_length = length population -1;
 val healthy = findHealthy(population, pop_length);
 val infected = findInfected(population, pop_length);
 val num_infected = length infected;
 val infected_groups = infectedGroups(infected, num_infected -1, []);
 val infected_groups = sort(infected_groups);
 val infected_groups = tuplefy(infected_groups, []);
 val infected_groups = unique(infected_groups);

 val infected = incrementExposure(infected, infected);
 val infected = incrementIncubation(infected, infected);
 val infected = diceOfFever(infected, infected);
 val infected = diceOfRash(infected, infected);
 val infected = diceOfPustules(infected, infected);
 val infected = diceOfDeath(infected, infected);
 val infected = diceOfHealth(infected, infected);
 val healthy = diceOfInfect(healthy, infected_groups, healthy, infected_groups);
 val population = healthy@infected;
 val population = unique(population);
 val pop_length = length population -1;
 val healthy = findHealthy(population, pop_length);
 val infected = findInfected(population, pop_length);
 val num_infected = length infected;
 val infected_groups = infectedGroups(infected, num_infected - 1, []);
 val infected_groups = sort(infected_groups);
 val infected_groups = tuplefy(infected_groups, []);
 val infected_groups = unique(infected_groups);

(* recursively pass through days until either no one is alive, or no one is infected  *)
 print  "\n\nentering recursive phase ... and it could take a while\n\n";
 val population = daysOfOurLives(population, infected, healthy, infected_groups);
 val population = unique(population);
 val healthy = findHealthy(population, length population -1 );
 val infected = findInfected(population, length population - 1);
 length population;
 oringal_population_length;
