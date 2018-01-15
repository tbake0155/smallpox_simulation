
(* change the status of a person to contaminated *)
fun viralInjection(x::xs,
                   sap:(int * int * int * int * int * int * int list)) = 
                    let
                      val p = x::xs@[(#1sap,#2sap,#3sap,1,#5sap,#6sap,#7sap)]
                    in
                      delete(sap, p)
                    end;

(* change the status of a person to infected *)
fun viralInfection(x::xs,
                   sap:(int * int * int * int * int * int * int list)) = 
                    let
                      val p = x::xs@[(#1sap,#2sap,#3sap,2,1,#6sap,#7sap)]
                    in
                      delete(sap, p)
                    end;

(* change the status of a person to IMMUNE*)
fun immunoSufficient(x::xs,
                   sap:(int * int * int * int * int * int * int list)) = 
                    let
                      val p = x::xs@[(#1sap,#2sap,#3sap,9,0,#6sap,#7sap)]
                    in
                      delete(sap, p)
                    end;

(* change the status of a person to feverish*)
fun feverRising(x::xs,
                   sap:(int * int * int * int * int * int * int list)) = 
                    let
                      val p = x::xs@[(#1sap,#2sap,#3sap,3,#5sap,1,#7sap)]
                    in
                      delete(sap, p)
                    end;

(* change the status of a person to healthy *)
fun healingTouch(x::xs,
                   sap:( int * int * int * int * int * int * int list)) = 
                    let
                      val p = x::xs@[(#1sap,#2sap,#3sap,0,#5sap,#6sap,#7sap)]
                    in
                      delete(sap, p)
                    end;

(* get the specified person from the list and inject the virus *)
fun contaminate(pop:(int * int * int * int * int * int * int list) list, 
                place:int) = 
                 let 
                   val j = List.nth(pop,place) 
                 in 
                   viralInjection(pop, j) 
                 end;

(* initial contamination on specified group *)
fun contact (n:int, 
             attackedGroup:int, 
             pop:(int * int * int * int * int * int * int list) list, 
             size:int) = 
              if 
                n = attackedGroup 
              then 
                contaminate(pop, size) 
              else 
                pop;

(* search each person's mixing groups for the attacked group *)
fun attackedGroup (pop:(int * int * int * int * int * int * int list) list, 
                   human: int * int * int * int * int * int * int list, 
                   attacked:int, 
                   size:int) = 
                    let 
                      val p = #7human 
                      val n = findone(p, attacked) 
                    in 
                      contact(n, attacked, pop, size) 
                    end;

(* go through the entire population and determine if a person was struck by the initial  attack *)
fun isVictim(pop:(int * int * int * int * int * int * int list) list, 
             size:int, 
             attacked:int) = 
              if 
                size = 0 
              then 
                pop 
              else 
                let
                  val x = List.nth(pop,size)
                  val pop = attackedGroup(pop,x,attacked,size)
                  val next = size - 1
                in 
                  isVictim(pop, next, attacked) 
                end;

(*   *)
fun perpFromPop(pop:( int * int * int * int * int * int * int list) list, 
                place:int) = 
                 List.nth(pop,place);

(*   *)
fun healthStatus(p:int * int * int * int * int * int * int list) = #4p;

(*   *)
fun remHealthy(infected:(int * int * int * int * int * int * int list) list, 
               size:int) = 
                let 
                  val s = healthStatus(perpFromPop(infected, size)) 
                in 
                  if 
                    s = 0 
                  then  
                    delete(perpFromPop(infected, size),infected) 
                  else if
                    s = 9
                  then
                    delete(perpFromPop(infected, size), infected)
                  else
                    infected 
                end;

(*   *)
fun findInfected(i:(int * int * int * int * int * int * int list) list, 
                 size:int) = 
                  if 
                    size = 0 
                  then 
                    remHealthy(i,size) 
                  else 
                    let
                      val i = remHealthy(i,size)
                      val next = size - 1
                    in 
                      findInfected(i, next) 
                    end;

(*   *)
fun removeInfected(h:(int * int * int * int * int * int * int list) list, 
                   size:int) = 
                    let 
                      val s = healthStatus(perpFromPop(h, size)) 
                    in 
                      if 
                        s = 0 
                      then 
                        h
                      else if
                        s = 9 
                      then
                        h
                      else 
                        delete(perpFromPop(h, size),h) 
                    end;

(*   *)
fun findHealthy(h:(int * int * int * int * int * int * int list) list, 
                size:int) = 
                 if 
                   size = 0 
                 then 
                   removeInfected(h,size) 
                 else 
                   let
                     val h = removeInfected(h,size)
                     val next = size - 1
                   in 
                     findHealthy(h, next) 
                   end;

(*  *)
fun proceed(i:(int * int * int * int * int * int * int list) list, 
                 place:int) = 
                  let
                    val x = List.nth(i, place);
                  in
                    #7x
                  end;

(*   *)
fun getGroups(i:(int * int * int * int * int * int * int list) list, 
                 place:int) = 
                    if
                      place < 0
                    then 
                      []
                    else 
                     proceed(i, place);

(*   *)
fun gatherGroups(i:(int * int * int * int * int * int * int list) list, 
                 place:int, 
                 []) = 
                  let 
                     val groups = getGroups(i, place) 
                  in 
                    if
                      place = 0 -1
                    then
                      []
                    else
                      groups 
                  end 
  | gatherGroups(i:( int * int * int * int * int * int * int list) list, 
                 place:int, 
                 infectedGrps:int list) = 
                  let 
                    val groups = getGroups(i, place) 
                  in 
                    infectedGrps@groups 
                  end;

(*   *)
fun infectedGroups(i:(int * int * int * int * int * int * int list) list, 
                   size:int, 
                   []) = 
                    let 
                      val infectedGrps = gatherGroups(i, size,[]) 
                    in 
                      if 
                        size = 0 - 1
                      then  
                        []
                      else 
                        infectedGroups(i,size,infectedGrps) 
                    end 
   | infectedGroups(i:(int * int * int * int * int * int * int list) list, 
                    size:int, 
                    infectedGrps:(int list)) = 
                      if 
                        size = 0 - 1 
                      then 
                        infectedGrps 
                      else 
                        let 
                          val next = size - 1 
                          val infectedGrps = gatherGroups(i,size,infectedGrps) 
                        in 
                          infectedGroups(i, next, infectedGrps) 
                        end;

(*   *)
fun partition  (p,[  ])  =  ([  ],[  ])
  | partition  (p,x::xs)  =
     let   
       val (S,B)  =  partition  (p,xs)
     in    
       if
         x  <  p
       then
         (x::S,B)
       else
         (S,x::B)
       end;

(*  *)
fun sort  [  ]  =  [  ]
  | sort  (x::xs)  =
    let  
      val (S,B)  =  partition  (x,xs)
    in
      (sort  S)  @  (x  ::  (sort  B))
    end;

(*  *)
fun couple(group:int, num:int) =
     [(group, num)];

(*  *)
fun addCouple([], group:int, num:int) = 
     let
       val couples = []
       val c = couple(group, num)
     in
       couples@c
     end
  | addCouple(couples:(int * int) list, group:int, num:int) =
     let 
       val c = couple(group, num)
     in
       couples@c
     end;

(*  *)
fun numberInGroup([], group:int, num:int ) = num
  | numberInGroup(x::xs, group:int, num:int ) =
     if
       x = group
     then
       let 
         val num = num + 1
       in
         numberInGroup(xs, group, num)
       end
     else
      num;

(*  *)
fun tuplefy(x::xs, []) =
     let 
       val numInGroup = numberInGroup(x::xs, x, 0)
       val couples = addCouple([],x, numInGroup)
       val xs = delete(x, xs)
     in
       tuplefy(xs, couples)
     end
  | tuplefy(x::xs, couples:(int * int) list) =
     let 
       val numInGroup = numberInGroup(x::xs, x, 0)
       val couples = addCouple(couples,x, numInGroup)
       val xs = delete(x, xs)
     in
       tuplefy(xs, couples)
     end
  | tuplefy([], couples:(int * int) list) = couples;
  



