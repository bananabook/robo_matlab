function roboplot(phi, show_link)
    % Create the frames
    frame0=eye(4);
    frame1=eye(4);
    frame2=eye(4);
    frame3=eye(4);
    
    % Place the frames
    frame1=R(phi(1), 3)*T([0 0 3]) * frame1;
    frame2=R(phi(1), 3)*T([0 0 3]) * T([0 2 0])*R(phi(2), 3) * frame2;
    frame3=R(phi(1), 3)*T([0 0 3]) * T([0 2 0])*R(phi(2), 3) * T([0 3 0])*R(phi(3), 2) * frame3;
    
    % Plot the frames
    hold on
    plot_frame(frame0)
    plot_frame(frame1)
    plot_frame(frame2)
    plot_frame(frame3)
    
    % Plot the links if wanted
    if show_link
        p=zeros(3,4);
        p(:,1)=frame0(1:3,end);
        p(:,2)=frame1(1:3,end);
        p(:,3)=frame2(1:3,end);
        p(:,4)=frame3(1:3,end);

        for i=1:3
            plot3(p(1, i:i+1)', p(2, i:i+1)', p(3, i:i+1)', 'LineWidth', 2, 'Color', 'yellow')
        end
    end
    hold off
    
end

function plot_frame(frame)
    % Plot the given frame
    
    % retrieve the position of the frame
    p=frame(1:3,4);
    
    % choose how much the frame vectors are elongated
    elongate=1.5;
    
    % Plot the vectors with respective colors x:red, y:green, z:blue
    for i=(1:3)
        q=frame(1:3, i)*elongate;
        switch i
            case 1
                col='red';
            case 2
                col='green';
            case 3
                col='blue';
        end
        quiver3(p(1), p(2), p(3), ...
            q(1), q(2), q(3), ...
            'Color', col, ...
            'LineWidth', 3);
    end
end

function [m]=T(q) % Create translational matrix
m= [eye(3), reshape(q, 3,1);[0 0 0 1]];
end

function [m]=R(angle, axis) % Create rotational matrix
switch axis
    case 1
        r=[1,          0,           0;
           0, cosd(angle), -sind(angle);
           0, sind(angle),  cosd(angle)];
    case 2
        r=[cosd(angle), 0, -sind(angle);
           0         , 1,           0;
           sind(angle), 0,  cosd(angle)];
    case 3
        r=[cosd(angle), -sind(angle), 0;
           sind(angle),  cosd(angle), 0;
           0         ,           0, 1];
end
m = [r,[0;0;0];[0 0 0 1]];
end
