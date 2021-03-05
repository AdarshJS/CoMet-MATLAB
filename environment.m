cla
close all
side = 5;
small_side = 3;
resolution = 25;
clusters = 6;
n_ped = 30

[pedestrians, idx, C]= generate_groups(small_side, clusters, n_ped);
size = length(pedestrians);

X = pedestrians;
hull = {};
figure;
for cluster = 1:clusters
    plot(X(idx==cluster,1),X(idx==cluster,2),'.','MarkerSize',12);
    ped = X(idx == cluster,:);
    if length(ped) > 2
        [k, av] = convhull(ped);
        hull = [hull; k];
    else
        
        hull = [hull; 1:length(ped)]
    end

    hold on
end

plot(C(:,1),C(:,2),'kx',...
     'MarkerSize',15,'LineWidth',3) 
legend('Cluster 1','Cluster 2','Cluster3','Centroids',...
       'Location','NW')

figure;
for i = 1:clusters
    k = hull{i}
    ped = X(idx == i,:)
    length(ped)
    plot(ped(k,1),ped(k,2));
    hold on;
end
xlim([0 5])
ylim([0 5])

robotRadius = 0.1;
map = generate_map(pedestrians, hull, clusters, idx);
plan_path(map, robotRadius);
% map_matrix = occupancyMatrix(map);
% 
% %about map_matrix
% 
% %bug = Bug2(map_matrix);
% %start = [60, 5];
% goal = [55, 120]; 
% %bug.plot()
% %path = bug.query(start, goal, 'animate', 'current');

function [y, idx, C] = generate_groups(small_side,clusters, n_ped)
    max_groups =6;
    max_group_size = 3;
    groups = [];
    
    % Group size
%     n = randsample(max_groups, 1) 
%     for i = 1:n
%         mu = [(small_side*i/n) randsample(small_side,1)]
%         Sigma = [0.5 0.5; 0.5 2];
%         R = mvnrnd(mu,Sigma,max_group_size)
% %         z = normrnd((small_side+.6*rand(1,1) )*(i/n), .3 , [max_group_size, 2])
%         groups = [groups; R];
%     end
    y = rand(n_ped,2)*small_side;
    [idx,C] = kmeans(y,clusters);
    
end

