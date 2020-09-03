int: nb_workers;
set of int: WORKERS = 1..nb_workers;
set of int: WORKERS0 = 0..nb_workers;
set of int: HOURS = 1..168;

array[WORKERS, HOURS] of 0..1: working_hours;

array[HOURS] of var WORKERS0: assignment;

array[HOURS] of var int: is_worker_available = [
    max( [working_hours[w, h] | w in WORKERS] )
    | h in HOURS
];

% Always assign someone if there is someone available
constraint forall(h in HOURS)(
    is_worker_available[h] = 1 -> assignment[h] != 0
);

% Never assign someone if they are not available
constraint forall(h in HOURS, w in WORKERS)(
    working_hours[w, h] = 0 -> assignment[h] != w
);

array[WORKERS] of var int: total_hours = [
    sum( [assignment[h]=w | h in HOURS ] )
    | w in WORKERS
];

var int: absolute_diff = sum(w in WORKERS, w2 in WORKERS where w > w2)(
     abs(total_hours[w] - total_hours[w2])
);
solve :: int_search(assignment, first_fail, indomain_random)
      minimize absolute_diff;
