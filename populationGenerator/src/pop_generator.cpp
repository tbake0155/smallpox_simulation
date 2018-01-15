#include <iostream>
#include <random>
#include <ctime>
#include <fstream>
#include <list>
#include "Person.h"
using namespace std;

#define POPULATION_SIZE 5000
#define FAMILY_ID_START 1000
#define AVERAGE_FAMILY_SIZE 3
#define MIN_MIXING_GROUPS 301
#define MAX_MIXING_GROUPS 700
#define MIX_MIN 0
#define MIX_MAX 6

int main()
{
    // random engine generator
    default_random_engine gen(time(0));

    // create a list of people
    list<Person> population;
    list<Person>::iterator population_itr;
    Person * person_ptr;

    // family id counter
    int Fid = FAMILY_ID_START;

    for(int i=0; i<POPULATION_SIZE; i++)
    {
       person_ptr = new Person(i);
       population.push_back(*person_ptr);
    }

    uniform_int_distribution<int> a0dist(1,145);
    uniform_int_distribution<int> udist(1,59);
    exponential_distribution<double> edist(.11);
    normal_distribution<double> family_dist(AVERAGE_FAMILY_SIZE,1.0);
    uniform_int_distribution<int> other_groups_dist(MIN_MIXING_GROUPS,MAX_MIXING_GROUPS);
    uniform_int_distribution<int> num_groups_dist(MIX_MIN,MIX_MAX);


    // while there are people in the list, 
    // assign them to family groups
    population_itr = population.begin();
    while(population_itr != population.end())
    {
        int age = 0;
        
        // create a head of house, must be 
        // over 18
        while(age < 18)
        {
            age = a0dist(gen);
            if(age > 120)
            {
                age = 59 + edist(gen);
            }
            else
            {
                age = udist(gen);
            }
        }
        population_itr->setAge(age, &gen);
        population_itr->setFid(Fid);

        // generate a new family size, and subtract
        // the head of the house that we just created
        int family_size = int(family_dist(gen)) -1;
        
        // populate the family
        for(int i=0; i < family_size; i++)
        {
            // create the family members one at a 
            // time
            population_itr++;
            age = a0dist(gen);
            if(age > 120)
            {
                age = 59 + edist(gen);
            }
            else
            {
                age = udist(gen);
            }
            population_itr->setAge(age,&gen);
            population_itr->setFid(Fid);
        }
        
        // increment the family id
        Fid++;
        
        // increment to the next head of house
        population_itr++;
    }
    
    // add everyone to other mixing groups
    population_itr = population.begin();
    while(population_itr != population.end())
    {
        for(int i=0; i<num_groups_dist(gen); i++)
        {
            population_itr->add2mxg(other_groups_dist(gen));
        }
        population_itr->mxguniq();
        population_itr++;
    }

    //  generate the output file
    fstream fout;
    fout.open("pop_data.txt",ios::out);

    population_itr = population.begin();
    while(population_itr != population.end())
    {
        population_itr->display(fout);
        population_itr++;
    }
    fout.close();

    return 0;
}
