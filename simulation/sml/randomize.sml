val x = Random.rand(1,1);
fun seeder (x) = 
   let
     val nextInt = Random.randRange(0,20)
   in
     (nextInt x)
   end;

val a = seeder(x);

val b = seeder(x);

val c = seeder(x);

val d = seeder(x);

val i = seeder(Random.rand(a,b));

val j = seeder(Random.rand(c,d));

val r = Random.rand(i, j);

val q = Random.rand(8, 5);

fun getRandInt(r , min : int, max : int) =
  let 
	  val nextInt = Random.randRange(min,max)
  in
	  (nextInt r)
  end;

fun randomMixingGroup(q) = 
    let 
      val nextInt = Random.randRange(1, 300)
    in 
      nextInt q 
    end;

val randomly_chosen_sadly_to_die = randomMixingGroup(q);
val randomly_chosen_sadly_to_die = 6;
