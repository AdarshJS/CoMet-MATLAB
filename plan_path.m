function path = plan_path(map, robotRadius)
    mapInflated = copy(map);
    %inflate(mapInflated, robotRadius);
    show(mapInflated);
    path = map;
end 