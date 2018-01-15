all: population_generator

population_generator: Person.o pop_generator.o
	g++ -o bin/population_generator obj/pop_generator.o obj/Person.o 

Person.o: src/Person.cpp
	g++ -o obj/Person.o -c src/Person.cpp -std=c++11

pop_generator.o: src/pop_generator.cpp
	g++ -o obj/pop_generator.o -c src/pop_generator.cpp -std=c++11

clean:
	rm bin/*
	rm obj/*

clean_objects:
	rm obj/*

generate:
	make clean
	make all
	../populationGenerator/bin/population_generator
	mv pop_data.txt ../simulation/
