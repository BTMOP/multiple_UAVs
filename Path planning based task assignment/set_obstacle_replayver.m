function [vrt] = set_obstacle_replayver(vrt,OBS_NUM,OBS_VRT,KNOBS_NUM,FLAG)

% FLAG
% 0 : UNKNOWN OBSTACLES
% 1 : KNOWN OBSTACLES

% KNOBS_NUM : known obstacle number.
% the label for obstacle.
% 1 ~ known obstacle number : known obstacles
% known obstacle number+1 ~ total obstacle number : unknown obstacles

% Obstacles
for idx_bldg = 1 : OBS_NUM
    for idx_edge = 1 : OBS_VRT
%         [vrt((OBS_VRT+1)*(idx_bldg-1)+idx_edge,1), vrt((OBS_VRT+1)*(idx_bldg-1)+idx_edge,2)] = ginput(1);
        vrt((OBS_VRT+1)*(idx_bldg-1)+idx_edge,3) = KNOBS_NUM+idx_bldg;
        vrt((OBS_VRT+1)*(idx_bldg-1)+idx_edge,4) = idx_edge;
        if (idx_edge >= 2)
            if (FLAG ~= 0)
                line(vrt([(OBS_VRT+1)*(idx_bldg-1)+idx_edge-1,(OBS_VRT+1)*(idx_bldg-1)+idx_edge],1),vrt([(OBS_VRT+1)*(idx_bldg-1)+idx_edge-1,(OBS_VRT+1)*(idx_bldg-1)+idx_edge],2),'color','black');
            else
                plot(vrt([(OBS_VRT+1)*(idx_bldg-1)+idx_edge-1,(OBS_VRT+1)*(idx_bldg-1)+idx_edge],1),vrt([(OBS_VRT+1)*(idx_bldg-1)+idx_edge-1,(OBS_VRT+1)*(idx_bldg-1)+idx_edge],2),'g--');
            end
        end
    end
    if (FLAG == 0)
        plot(vrt([(OBS_VRT+1)*(idx_bldg-1)+idx_edge,(OBS_VRT+1)*(idx_bldg-1)+idx_edge+1],1),vrt([(OBS_VRT+1)*(idx_bldg-1)+idx_edge,(OBS_VRT+1)*(idx_bldg-1)+idx_edge+1],2),'g--');
    end
    vrt((OBS_VRT+1)*(idx_bldg-1)+(OBS_VRT+1),:) = vrt((OBS_VRT+1)*(idx_bldg-1)+1,:);
    if FLAG == 0
        %patch(vrt((OBS_VRT+1)*(idx_bldg-1)+1:(OBS_VRT+1)*(idx_bldg-1)+OBS_VRT,1),vrt((OBS_VRT+1)*(idx_bldg-1)+1:(OBS_VRT+1)*(idx_bldg-1)+OBS_VRT,2),'cyan');
        %text(vrt((OBS_VRT+1)*(idx_bldg-1)+1,1),vrt((OBS_VRT+1)*(idx_bldg-1)+1,2), sprintf('%d',KNOBS_NUM+idx_bldg));
    else
        patch(vrt((OBS_VRT+1)*(idx_bldg-1)+1:(OBS_VRT+1)*(idx_bldg-1)+OBS_VRT,1),vrt((OBS_VRT+1)*(idx_bldg-1)+1:(OBS_VRT+1)*(idx_bldg-1)+OBS_VRT,2),'green');
        %text(vrt((OBS_VRT+1)*(idx_bldg-1)+1,1),vrt((OBS_VRT+1)*(idx_bldg-1)+1,2), sprintf('%d',idx_bldg));
    end        
end