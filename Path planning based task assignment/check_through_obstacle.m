function [det] = check_through_obstacle(wpt_tmp,wpt_prev,wpt,OBS_NUM,OBS_VRT,vrt_config)

% Check whether the new path through ANOTHER obstacle.
%  this procedure is a kind of filtering process to prevent from generating
%  non-admissible path. Although the path is generated by using the
%  fundamental and the core of this algorithm, it should be admissible.
%  there is a path which passes through another obstacle. If so, the
%  filtering and regeneration by using that obstacle is required.
%  This procedure is different from the filtering in the "find_waypoint.m".
%  On that file, the filtering procedure is activated when the path
%  through the obstacle which has the new and previous waypoints.
%
%%%% REVISION NOTE %%%
%
% REVISION VERSION : 1.10
% REVISION DATE : 2009. 11. 3
% REVISED BY SANGWOO MOON.


% Find the meeting point :
%  use the "find_meeting_points.m" with new waypoint and previous one.
[meet_pts,det_meet_pts] = find_meeting_points(OBS_NUM,OBS_VRT,vrt_config,wpt_tmp,wpt_prev);
meet_pts(:,5) = 0;

% Assume that there are no obstacle which is on the path.
det = 0;

% Among meeting points, there should be previous waypoints becuase of
% calculation. To prevent, erase meeting points which is the same as 
% the previous waypoints.
if det_meet_pts == 1
    for iter_mtpt = 1 : length(meet_pts(:,1))
        for iter_wpt = 1 : length(wpt(:,1))
            if abs(meet_pts(iter_mtpt,1)-wpt(iter_wpt,1)) < 0.001 && abs(meet_pts(iter_mtpt,2)-wpt(iter_wpt,2)) < 0.001 % in mathematical represent, meet_pts and wpt are same.
                meet_pts(iter_mtpt,5) = 1;
            end
        end
        % if the FRESH point is detected, this bad situation was happened.
        % Check this one.
        if meet_pts(iter_mtpt,5) == 0
            det = 1;
        end
    end
else
    det = 0;
end