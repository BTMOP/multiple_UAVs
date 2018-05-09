function [wpt,landmark_prev] = find_dynamic_path(wpt_origin,v,p_i,p_f,HLI_vel,dt,HLI_max_dyaw,landmark_prev,theta)


for iter = 1 : 2 : length(v(:,1))-1
    det_meet_pt = 0;
    if abs(v(iter+1,1)-v(iter,1)) < 0.0000001
        v(iter+1,1) = v(iter+1,1) + 0.0001;
    end
    if abs(p_f(1,1)-p_i(1,1)) < 0.0000001
        p_f(1,1) = p_f(1,1) + 0.0001;
    end
    a = (v(iter+1,2)-v(iter,2))/(v(iter+1,1)-v(iter,1));   
    b = (p_f(1,2)-p_i(1,2))/(p_f(1,1)-p_i(1,1));

    mpt_tmp(1,1) = (-a*v(iter,1)+v(iter,2)+b*p_i(1,1)-p_i(1,2))/(-a+b);
    mpt_tmp(1,2) = (-a*b*v(iter,1)+b*v(iter,2)+a*b*p_i(1,1)-a*p_i(1,2))/(-a+b);

    % �������� �ɸ� ��쿡 ���ؼ��� ������� �ʾ���.
    if (determine_on_line(mpt_tmp,v(iter,:),v(iter+1,:)))
        meet_pts = mpt_tmp;
        det_meet_pt = 1;
        landmark_now([1,2],[1,2]) = v([iter,iter+1],:);
        % ������ �������� ���� sink point ȸ�� �˰��� : �ϰ����ְ� �����Ѵ�.
        if (landmark_prev == zeros(2,3))
            landmark_prev([1,2],[1,2]) = landmark_now([1,2],[1,2]);
        else
            % singular case�� ���� ���� ���.
            if abs(landmark_prev(2,1)-landmark_prev(1,1)) < 0.0000001
                landmark_prev(2,1) = landmark_prev(2,1) + 0.0001;
            end
            slp = (landmark_prev(2,2)-landmark_prev(1,2))/(landmark_prev(2,1)-landmark_prev(1,1));
            if (abs(slp*landmark_now(1,1)-slp*landmark_prev(1,1)+landmark_prev(1,2)-landmark_now(1,2)) < 0.01) && (abs(slp*landmark_now(2,1)-slp*landmark_prev(1,1)+landmark_prev(1,2)-landmark_now(2,2)) < 0.01)
%                 theta = atan2(landmark_now(landmark_prev(1,3),2)-wpt_origin(1,2),landmark_now(landmark_prev(1,3),1)-wpt_origin(1,1));
                if abs(theta-p_i(1,3)) > HLI_max_dyaw*dt
                    if (theta-p_i(1,3) < -HLI_max_dyaw*dt)
                        theta = -HLI_max_dyaw*dt+p_i(1,3);
                    elseif (theta-p_i(1,3) > HLI_max_dyaw*dt)
                        theta = HLI_max_dyaw*dt+p_i(1,3);
                    end
                end
                wpt = [wpt_origin(1,1)+HLI_vel*dt*cos(theta),wpt_origin(1,2)+HLI_vel*dt*sin(theta),theta];
                det_meet_pt = 2;
            end            
        end
    end        
end

if (det_meet_pt == 1)
    if (distance(meet_pts,landmark_now(1,:)) < distance(meet_pts,landmark_now(2,:)))
%         theta = atan2(landmark_now(1,2)-wpt_origin(1,2),landmark_now(1,1)-wpt_origin(1,1));
        if abs(theta-p_i(1,3)) > HLI_max_dyaw*dt
            if (theta-p_i(1,3) < -HLI_max_dyaw*dt)
                theta = -HLI_max_dyaw*dt+p_i(1,3);
            elseif (theta-p_i(1,3) > HLI_max_dyaw*dt)
                theta = HLI_max_dyaw*dt+p_i(1,3);
            end
        end
        landmark_prev(1,3) = 1;
    else
%         theta = atan2(landmark_now(2,2)-wpt_origin(1,2),landmark_now(2,1)-wpt_origin(1,1));
        if abs(theta-p_i(1,3)) > HLI_max_dyaw*dt
            if (theta-p_i(1,3) < -HLI_max_dyaw*dt)
                theta = -HLI_max_dyaw*dt+p_i(1,3);
            elseif (theta-p_i(1,3) > HLI_max_dyaw*dt)
                theta = HLI_max_dyaw*dt+p_i(1,3);
            end
        end
        landmark_prev(1,3) = 2;
    end
    %%% ���߿� wpt �����ϴ� �� �ϳ��� ��ġ��.    
    wpt = [wpt_origin(1,1)+HLI_vel*dt*cos(theta),wpt_origin(1,2)+HLI_vel*dt*sin(theta),theta];
    plot([p_i(1,1);p_f(1,1)],[p_i(1,2);p_f(1,2)],'b-');
elseif (det_meet_pt == 0)
%     theta = atan2(p_f(1,2)-wpt_origin(1,2),p_f(1,1)-wpt_origin(1,1));
    if abs(theta-p_i(1,3)) > HLI_max_dyaw*dt
        if (theta-p_i(1,3) < -HLI_max_dyaw*dt)
            theta = -HLI_max_dyaw*dt+p_i(1,3);
        elseif (theta-p_i(1,3) > HLI_max_dyaw*dt)
            theta = HLI_max_dyaw*dt+p_i(1,3);
        end
    end
    landmark_prev = zeros(2,3); % ������ ���� sink point ���ƺ��� �ʱ�ȭ.
    %%% ���߿� wpt �����ϴ� �� �ϳ��� ��ġ��.
    wpt = [wpt_origin(1,1)+HLI_vel*dt*cos(theta),wpt_origin(1,2)+HLI_vel*dt*sin(theta),theta];
    plot([p_i(1,1);p_f(1,1)],[p_i(1,2);p_f(1,2)],'r-');
end
