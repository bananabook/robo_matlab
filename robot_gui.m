function robot_gui
% ROBOT_GUI 
% Change the three angles of the kinematic via the sliders on the 
% right. Show and hide the links between the shown frames with the 
% radio button on the lower right.
% To rotate the view: 'View' -> 'Figure Toolbar' -> Rotate 3D'
 
    %  Create and then hide the GUI as it is being constructed.
    f = figure('Visible','off','Position',[0,1, 650, 440]);
    f.ToolBar='none';
    f.Name = 'Robot Plot';
    
    % Create the three panels for viewplot, control and display options
    hc=uipanel('Title', 'angle control', 'Position',[.7 0.2 .3 .8]);
    hp=uipanel('Title', 'plot', 'Position', [0 0 .7 1]);
    hs=uipanel('Title', 'display options', 'Position', [0.7 0 .3 .2]);

    % Create the variables for the plot
    phi=[0 0 0];
    show_link=1;
    
    %  Construct the components.
        % radio button, to show/hide the links
        radio = uicontrol('Style', 'radiobutton')
        radio.Parent=hs;
        radio.Units='normalized';
        radio.Position=[0 0 1 1];
        radio.String='show links';
        radio.Callback=@radio_Callback;
        radio.Value=1;
        
        % Create the slider for one angle
        hoslide1 = uicontrol('Parent', hc, 'Style', 'slider')
        hoslide1.Units='normalized'
        hoslide1.Position=[0 2/3 1 .2]%[700, .5, 100, 25];
        %hoslide1.Callback=@slider1_Callback;
        addlistener(hoslide1, 'Value', 'PostSet', @slider1_Callback);
        hoslide1.Max=360;
        hoslide1.Min=0;
        
        % Create the text to display the chosen angle
        text1 = uicontrol('Parent', hc, 'Style', 'Text')
        text1.Units='normalized';
        text1.Position=[0 2/3+.2 1 .1];
        
        % Repeat the above for two more sliders
        hoslide2.Units='normalized'
        hoslide2 = uicontrol('Parent', hc, 'Style', 'slider')
        hoslide2.Units='normalized'
        hoslide2.Position=[0 1/3 1 .2];
        %hoslide2.Callback=@slider2_Callback;
        addlistener(hoslide2, 'Value', 'PostSet', @slider2_Callback);
        hoslide2.Max=360;
        hoslide2.Min=0;

        text2 = uicontrol('Parent', hc, 'Style', 'Text')
        text2.Units='normalized';
        text2.Position=[0 1/3+.2 1 .1];

        hoslide3.Units='normalized'
        hoslide3 = uicontrol('Parent', hc, 'Style', 'slider')
        hoslide3.Units='normalized'
        hoslide3.Position=[0 0/3 1 .2];
        %hoslide3.Callback=@slider3_Callback;
        addlistener(hoslide3, 'Value', 'PostSet', @slider3_Callback);
        hoslide3.Max=360;
        hoslide3.Min=0;

        text3 = uicontrol('Parent', hc, 'Style', 'Text')
        text3.Units='normalized';
        text3.Position=[0 0/3+.2 1 .1];
    
    % Move the ui to the center of the screen
    movegui(f,'center')
    
    
    % Create the plot
    ha = axes('Units','Pixels','Position',[50,60,200,185]); 
    ha.Units='normalized';
    
    
    fs=subplot(1,1,1,'Parent', hp);
    axis equal
    update();
    
    view(45, 45)
    
    
    % Define the Callback functions
    function slider1_Callback(source, eventdata)
        num=get(eventdata.AffectedObject, 'Value');
        %phi(1)=source.Value;
        phi(1)=num;
        update();
    end
    function slider2_Callback(source, eventdata)
        num=get(eventdata.AffectedObject, 'Value');
        %phi(2)=source.Value;
        phi(2)=num;
        update();
    end
    function slider3_Callback(source, eventdata)
        num=get(eventdata.AffectedObject, 'Value');
        %phi(3)=source.Value;
        phi(3)=num;
        update(); 
    end
    function radio_Callback(source, eventdata)
        show_link=source.Value;
        update();
    end
    function update()
        cla
        roboplot(phi, show_link)
        l=6.5;
        axis([-l l -l l 0 5]);
        text1.String=strcat("Phi 1: ", string(num2str(phi(1), 3)));
        text2.String=strcat("Phi 2: ", string(num2str(phi(2), 3)));
        text3.String=strcat("Phi 3: ", string(num2str(phi(3), 3)));
    end

    % show the figure
   f.Visible = 'on';
 
end 
