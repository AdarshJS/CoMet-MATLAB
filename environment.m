cla
close all
side = 5;
small_side = 3;
resolution = 25;
clusters = 7;
n_ped = 50

[pedestrians, idx, C, idx_fz, C_fz] = generate_groups(small_side, clusters, n_ped);
size = length(pedestrians);

X = pedestrians;
hull = {};

% figure;
for cluster = 1:clusters
%     plot(X(idx==cluster,1),X(idx==cluster,2),'.','MarkerSize',12);
    ped = X(idx == cluster,:);
    if length(ped) > 2
        [k, av] = convhull(ped);
        hull = [hull; k];
    elseif length(ped) == 2
        hull = [hull; 1:length(ped)]
    else 
            hull = [hull; 1]    
    end

%     hold on
end

% plot(C(:,1),C(:,2),'kx',...
%      'MarkerSize',15,'LineWidth',3) 

hull_fz = {};
figure;
% plot(X(1,1)+1,X(1,2)+1,'.','MarkerSize',12);

[k, av] = convhull(pedestrians);
hull_fz = [hull_fz; k];
% temp_p = [-1 0; 0 -1]*pedestrians.' +[2.5;2.5]
% temp_p = temp_p.'

% plot(temp_p(k,1)+1, temp_p(k,2)+1)
% xlim([0 5])
% ylim([0 5])
% figure;
% plot(pedestrians(k,1)+1, pedestrians(k,2)+1)
% xlim([0 5])
% ylim([0 5])



% figure;
% for i = 1:clusters
%    k = hull{i}
%    ped = X(idx == i,:)
%    length(ped)
%    plot(ped(k,1)+1,ped(k,2)+1);
%    hold on;
% end
% xlim([0 5])
% ylim([0 5])

robotRadius = 0.3;
% figure;
map = generate_map(pedestrians, hull, clusters, idx);
%plan_path(map, robotRadius);
map_matrix = occupancyMatrix(map);

% figure;
map_fz = generate_map(pedestrians, hull_fz, 1, idx_fz);
%plan_path(map_fz, robotRadius);
map_matrix_fz = occupancyMatrix(map_fz);
for i = 1:100
    for j = 1:500

        map_matrix_fz(j,i) = 1;
        map_matrix(j,i) = 1;
    end
    
end

for i = 400:500
    for j = 1:500
        map_matrix_fz(j,i) = 1;
        map_matrix(j,i) = 1;

    end
    
end

start = [250, 50];
goal = [240, 490]; 


figure;
bug = Bug2(map_matrix);
bug.plot()
path = bug.query(start, goal);
% path = bug.query(start, goal, 'current');
length(path)
figure;
bug_fz = Bug2(map_matrix_fz);
bug_fz.plot()
path_fz = bug_fz.query(start, goal);

length(path_fz)

%about map_matrix

function [y, idx, C, idx_fz, C_fz] = generate_groups(small_side,clusters, n_ped)
 
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
    [idx_fz,C_fz] = kmeans(y,1); 
end