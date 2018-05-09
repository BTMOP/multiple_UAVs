function [det] = check_on_line(chk_pt, chk_line)

slp = (chk_line(2,2)-chk_line(1,2))/(chk_line(2,1)-chk_line(1,1));
if abs(slp*chk_pt(1,1)-slp*chk_line(1,1)+chk_line(1,2)-chk_pt(1,2)) < 0.01
    if (determine_on_line(chk_pt, chk_line(1,:),chk_line(2,:)) ~= 1)
        det = 1; % Ȯ���ؾ� �� landmark.
    else
        det = 2; % ������ �� landmark.
    end
else
    det = 3; % ���ο� �𼭸� landmark.
end

