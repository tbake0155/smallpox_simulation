#ifndef PERSON_H

#include <iostream>
#include <random>
#include <list>
#include <string>

using namespace std;

class Person
{
    public:
        Person(){}
        Person(int i);
        void setFid(int f){Fid = f; mixgrps.push_back(Fid);}
        void mxguniq(){mixgrps.sort(); mixgrps.unique();}
        void add2mxg(int i){mixgrps.push_back(i);}
        void setAge(int a, default_random_engine * gptr);
        int getPid(){return PID;}
        void display(std::iostream& out);
        list<int>::iterator get_mixgrps_begin(){return mixgrps.begin();}
        list<int>::iterator get_mixgrps_end(){return mixgrps.end();}
        int getFid(){return Fid;}
        int getAge(){return Age;}
        int getsymptom(){return symptom;}
        int getexposedDays(){return exposedDays;}
        int getincubateDays(){return incubateDays;}

    private:
        int PID;
        int Fid;
        int Age;
        int symptom;
        int exposedDays;
        int incubateDays;
        list<int>mixgrps;
        list<int>::iterator iitr;
};

#endif//PERSON.H
