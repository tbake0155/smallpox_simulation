fun contamChance(x::xs, y) =
     let
       val ran = Random.rand(#1y, #3y)
       val ran = getRandInt(ran, 0, 100)
     in 
       if
         ran < 3
       then
         viralInjection(x::xs, y)
       else
         x::xs
     end;

fun infectChance(x::xs, y) =
     let
       val ran = Random.rand(#1y, #3y)
       val ran = getRandInt(ran, 0, 100)
     in 
       if
         ran < 6
       andalso
         #2y < 15
       then
         viralInfection(x::xs, y)
       else if
         ran < 3
       then
         viralInfection(x::xs, y)
       else 
         x::xs
     end;

fun originalInfectionChance(x::xs, y) =
     let
       val ran = Random.rand(#1y, #3y)
       val ran = getRandInt(ran, 0, 100)
     in 
       if
         ran < 30
       then
         viralInfection(x::xs, y)
       else
         healingTouch(x::xs, y)
     end;

fun feverChance([], y, daysExposed:int) = []
  | feverChance(x::xs, y, daysExposed:int) =
     let
       val ran = Random.rand(#1y, #3y)
       val ran = getRandInt(ran, 0, 100)
     in 
       if
         daysExposed > 16
       then
         immunoSufficient(x::xs, y)
       else if
           daysExposed = 16
         andalso
           ran < 3
         then
           feverRising(x::xs, y)
       else if
           daysExposed = 15
         andalso
           ran < 3
         then
           feverRising(x::xs, y)
       else if
           daysExposed = 14
         andalso
           ran < 5
         then
           feverRising(x::xs, y)
       else if
           daysExposed = 13
         andalso
           ran < 8
         then
           feverRising(x::xs, y)
       else if
           daysExposed = 12
         andalso
           ran < 16
         then
           feverRising(x::xs, y)
       else if
           daysExposed = 11
         andalso
           ran < 20
         then
           feverRising(x::xs, y)
       else if
           daysExposed = 10
         andalso
           ran < 18
         then
           feverRising(x::xs, y)
       else if
           daysExposed = 9
         andalso
           ran < 12
         then
           feverRising(x::xs, y)
       else if
           daysExposed = 8
         andalso
           ran < 8
         then
           feverRising(x::xs, y)
       else if
           daysExposed = 7
         andalso
           ran < 5
         then
           feverRising(x::xs, y)
       else if
           daysExposed = 6
         andalso
           ran < 2
         then
           feverRising(x::xs, y)
       else
           x::xs
     end;

fun diceOfFever(x::xs, y::yz) =
     let 
       val daysExposed = #5x
       val noChange = y::yz
       val status = healthStatus(x)
       val perps = (feverChance( y::yz, x, daysExposed))
     in
       if
         status = 2
       then
         diceOfFever(xs, perps)
       else
         diceOfFever(xs, noChange)
     end
  | diceOfFever(x::xs, []) = []
  | diceOfFever([], y::yz) = y::yz
  | diceOfFever([],[]) = []

fun diceOfRash(x::xs, y::yz) =      
    let 
       val daysExposed = #5x
       val noChange = y::yz
       val status = healthStatus(x)
       val perps = y::yz@[(#1x, #2x, #3x, 3, #5x, 1, #7x)]
       val perps = delete(x,perps)
     in
       if
         status = 2
       andalso
         daysExposed = 4
       then
         diceOfRash(xs, perps)
       else
         diceOfRash(xs, noChange)
     end
  | diceOfRash(x::xs, []) = []
  | diceOfRash([], y::yz) = y::yz
  | diceOfRash([],[]) = [];

fun diceOfPustules(x::xs, y::yz) = 
    let 
       val daysExposed = #5x
       val noChange = y::yz
       val status = healthStatus(x)
       val perps = y::yz@[(#1x, #2x, #3x, 4, #5x, #6x, #7x)]
       val perps = delete(x,perps)
     in
       if
         status = 3
       andalso
         daysExposed = 6
       then
         diceOfPustules(xs, perps)
       else
         diceOfPustules(xs, noChange)
     end
  | diceOfPustules(x::xs, []) = []
  | diceOfPustules([], y::yz) = y::yz
  | diceOfPustules([],[]) = [];

fun diceOfDeath(x::xs, y::yz) = 
    let 
       val ran = Random.rand(1,4)
       val ran = getRandInt(ran, 0, 100) 
       val daysExposed = #5x
       val noChange = y::yz
       val status = healthStatus(x)
       val perps = y::yz
       val perps = delete(x,perps)
     in
       if
         status = 4
       andalso
         daysExposed > 1
       andalso
         ran < 40
       then
         diceOfDeath(xs, perps)
       else
         diceOfDeath(xs, noChange)
     end
  | diceOfDeath(x::xs, []) = []
  | diceOfDeath([], y::yz) = y::yz
  | diceOfDeath([],[]) = [];

fun diceOfHealth(x::xs, y::yz) = 
    let 
       val ran = Random.rand(1,4)
       val ran = getRandInt(ran, 0, 100) 
       val daysExposed = #5x
       val noChange = y::yz
       val status = healthStatus(x)
       val perps = y::yz@[(#1x, #2x, #3x, 9, #5x, #6x, #7x)]
       val perps = delete(x,perps)
     in
       if
         status = 4
       andalso
         daysExposed > 16
       then
         diceOfHealth(xs, perps)
       else
         diceOfHealth(xs, noChange)
     end
  | diceOfHealth(x::xs, []) = []
  | diceOfHealth([], y::yz) = y::yz
  | diceOfHealth([],[]) = [];

fun diceOfInitialInfection(x::xs, y::yz) =
     let 
       val perps = (originalInfectionChance(y::yz, x))
     in
       diceOfInitialInfection(xs, perps)
     end
  | diceOfInitialInfection([], y::yz) = y::yz
  | diceOfInitialInfection(x::xs, []) = []
  | diceOfInitialInfection([],[]) = [];

fun diceOfContam(x::xs, y::yz:(int * int )list, f::fg, j::jk) =
     let 
       val group = #1y
       val groups = #7x 
       val perps = (contamChance( f::fg, x))
     in
       if
         findone(groups, group) = group
       then
         diceOfContam(x::xs, yz, perps, j::jk)
       else
         diceOfContam(x::xs, yz, f::fg, j::jk)
     end
  | diceOfContam(x::xs,y::yz,f::fg, []) = 
     let 
       val group = #1y
       val groups = #7x 
       val perps = (contamChance( f::fg, x))
     in
       if
         findone(groups, group) = group
       then
         diceOfContam(x::xs, yz, perps, y::yz)
       else
         diceOfContam(x::xs, yz, f::fg, y::yz)
     end
  | diceOfContam([],y::yz, f::fg, j::jk) = f::fg
  | diceOfContam(x::xs,[], f::fg, y::yz) = diceOfContam(xs, y::yz, f::fg, [])
  | diceOfContam(x::xs,j::jk, [], y::yz) = []
  | diceOfContam([],[], f::fg, j::jk) = f::fg
  | diceOfContam([],y::yz, [], j::jk) = []
  | diceOfContam([],y::yz, f::fg, []) = f::fg
  | diceOfContam(x::xs,[], [], y::yz) = []
  | diceOfContam(x::xs,[], y::yz, []) = y::yz
  | diceOfContam([],[], [], y::yz) = []
  | diceOfContam([], [], x::xs, []) = x::xs
  | diceOfContam([],x::xs, [], []) = []
  | diceOfContam(x::xs,[], [], []) = []
  | diceOfContam([],[], [], []) = [];

fun diceOfInfect(x::xs, y::yz:(int * int )list, f::fg, j::jk) =
     let 
       val group = #1y
       val groups = #7x 
       val perps = (infectChance( f::fg, x))
     in
       if
         findone(groups, group) = group
       then
         diceOfInfect(x::xs, yz, perps, j::jk)
       else
         diceOfInfect(x::xs, yz, f::fg, j::jk)
     end
  | diceOfInfect(x::xs,y::yz,f::fg, []) = []
  | diceOfInfect([],y::yz, f::fg, j::jk) = f::fg
  | diceOfInfect(x::xs,[], f::fg, y::yz) = diceOfInfect(xs, y::yz, f::fg, y::yz)
  | diceOfInfect(x::xs,j::jk, [], y::yz) = []
  | diceOfInfect([],[], f::fg, j::jk) = f::fg
  | diceOfInfect([],y::yz, [], j::jk) = []
  | diceOfInfect([],y::yz, f::fg, []) = f::fg
  | diceOfInfect(x::xs,[], [], y::yz) = []
  | diceOfInfect(x::xs,[], y::yz, []) = y::yz
  | diceOfInfect([],[], [], y::yz) = []
  | diceOfInfect([], [], x::xs, []) = x::xs
  | diceOfInfect([],x::xs, [], []) = []
  | diceOfInfect(x::xs,[], [], []) = []
  | diceOfInfect([],[], [], []) = [];
