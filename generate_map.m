
function map = generate_map(pedestrians, hull, n_clusters, idx)
    side = 5;
    resolution = 100;
    n_clusters
    map = binaryOccupancyMap(side, side, resolution);
    for i = 1:n_clusters
        k = hull{i}
        ped = pedestrians(idx == i,:)
        for id = 1:length(k)-1
           if length(ped) == 1
               continue
           end
           [x, y] = fillline(ped(k(id),:), ped(k(id+1),:), 100) ;
           setOccupancy(map, [x(:)+1, y(:)+1], 1);
           
        end
    
    end
    
    inflate(map, 0.07)
       % setOccupancy(map, [x(:)+1, y(:)+1], 1);      
%     show(map)
end 

function [xx,yy]=fillline(startp,endp,pts)
        m=(endp(2)-startp(2))/(endp(1)-startp(1)); %gradient 
        if m==Inf %vertical line
            xx(1:pts)=startp(1);
            yy(1:pts)=linspace(startp(2),endp(2),pts);
        elseif m==0 %horizontal line
            xx(1:pts)=linspace(startp(1),endp(1),pts);
            yy(1:pts)=startp(2);
        else %if (endp(1)-startp(1))~=0
            xx=linspace(startp(1),endp(1),pts);
            yy=m*(xx-startp(1))+startp(2);
        end
end
