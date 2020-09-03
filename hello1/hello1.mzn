int: total_nb_battery = 100;  % fixed, input parameters
int: total_kg_metal = 190000; % fixed, input parameters

% variable, possible number of different cars
var 0..total_nb_battery: nb_cybertruck;
var 0..total_nb_battery: nb_model3;

var int: profit = nb_cybertruck * 40000 + nb_model3 * 35000;

% limit number of kilograms
constraint nb_cybertruck * 2500 + nb_model3 * 1500 <= total_kg_metal;
% limit number of batteries
constraint nb_cybertruck + nb_model3 <= total_nb_battery;

solve maximize profit;
