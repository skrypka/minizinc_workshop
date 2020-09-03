int: nb_workers;
set of int: WORKERS = 1..nb_workers;
set of int: HOURS = 1..168;

array[WORKERS, HOURS] of 0..1: working_hours;

array[HOURS] of var WORKERS: assignment;

array[WORKERS] of var int: total_hours = [
    sum( [assignment[h]=w | h in HOURS ] )
    | w in WORKERS
];

 
solve :: int_search(assignment, first_fail, indomain_random)
      minimize max(total_hours) - min(total_hours);
