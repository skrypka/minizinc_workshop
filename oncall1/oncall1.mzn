int: nb_workers;
set of int: WORKERS = 1..nb_workers;
set of int: HOURS = 1..168;

array[WORKERS, HOURS] of 0..1: working_hours;

constraint forall(h in HOURS, w in WORKERS)(
    working_hours[w, h] = 0 -> assignment[h] != w
);

array[HOURS] of var WORKERS: assignment;

solve satisfy;
