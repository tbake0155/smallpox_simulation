(*   *)
val population = [];

(*   *)
val placeHolder = 0;

(*   *)
fun itemFromList(pop:(int * int * int * int * int * int * int list) list, 
                 place:int) =
                  List.nth(pop,place);

(*   *)
fun unique [] = [] 
  | unique (x::xs) = x::unique(List.filter(fn y => y <> x) xs);

(*   *)
fun getmxgrps (pop:(int * int * int * int * int * int * int list) 
               list, 
               place:int) =
                let
                  val x = itemFromList(pop,place) 
                in 
                  #7x 
                end;

(*   *)
fun add2list(L, n)=(n)::L;

(*   *)
fun delete (item, list) = List.filter(fn x => x <> item) list;

(*   *)
fun findone(x::xs, t:int) = 
            if
              t = x
            then
              x 
            else 
              findone(xs,t) 
  | findone([], t:int) = 1000000000;

(*   *)
fun person( Pid:int, 
            Age:int,
            Fid:int, 
            symptom:int, 
            exposedDays:int, 
            incubateDays:int, 
            mixgrps:int list) = 
             [(Pid, Age, Fid, symptom, exposedDays, incubateDays, mixgrps)];

(*   *)
use "pop_data.txt";

(*   *)
val oringal_population_length = length population - 1;
val pop_length = length population -1;


