#include "Person.h"


Person::Person(int i)
{
    PID = i; 
    symptom = 0;
    exposedDays = 0;
    incubateDays = 0;
}

void Person::setAge(int a, default_random_engine * gptr)
{
    Age = a;
    int school;
    int hosp;
    int work;
    int highschool_id = 1;
    int hospital_id = 16;
    uniform_int_distribution<int> playdist(9,15);
    uniform_int_distribution<int> elemdist(4,8);
    uniform_int_distribution<int> msdist(2,3);
    uniform_int_distribution<int> dice(0,100);
    uniform_int_distribution<int> wdist(17,300);
    if (a<5)
    {
        school = playdist(*gptr);
        mixgrps.push_back(school);
    }
    else if(a<11)
    {
        school = elemdist(*gptr);
        mixgrps.push_back(school);
    }
    else if(a<14)
    {
        school = msdist(*gptr);
        mixgrps.push_back(school);
    }
    else if(a<19)
    {
        mixgrps.push_back(highschool_id);
    }
    else if(a<65)
    {
        hosp=dice(*gptr);
        if(hosp<=4)
        {
            mixgrps.push_back(hospital_id);
        }
        else
        {
            work = wdist(*gptr);
            mixgrps.push_back(work);
        }
    }
}

void Person::display(std::iostream& out)
{
    out<<"val population = population@ person("<<PID<<", "<<Age<<", "<<Fid
       <<", "<<symptom<<", "<<exposedDays<<", "
       <<incubateDays<<", [";
    iitr=mixgrps.begin();
    while(iitr!=mixgrps.end())
    {
        if(iitr!=mixgrps.begin())
        {
            out<<", "<<*iitr;
        }
        else
        {
            out<<*iitr;
        }
        iitr++;
    }
    out<<"]);"<<std::endl;
}



//endoffile
