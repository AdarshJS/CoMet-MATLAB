cla
close all
side = 5;
small_side = 3;
resolution = 25;

pedestrians= generate_groups(small_side);

[k, av] = convhull(pedestrians(1,:), pedestrians(2,:));

plot(pedestrians(1,:),pedestrians(2,:),'*');
hold on;
plot(pedestrians(1,k),pedestrians(2,k));
xlim([0 5])
ylim([0 5])
% pedestrians(1,k),pedestrians(2,k)

robotRadius = 0.1;
map = generate_map(side, resolution, pedestrians, k);
plan_path(map, robotRadius);
map_matrix = occupancyMatrix(map);

about map_matrix

bug = Bug2(map_matrix);
start = [60, 5];
goal = [55, 120]; 
bug.plot()
path = bug.query(start, goal, 'animate', 'current');

function y = generate_groups(small_side)
    
    y = rand(2,20)*small_side;
end
