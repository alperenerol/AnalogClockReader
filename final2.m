clc
clear

%read Images
imagepath = 'clock001.jpg';
% imagepath = 'clock002.jpg';
% imagepath = 'clock003.jpg';
% imagepath = 'clock004.jpg';
% imagepath = 'clock005.jpg';
I = imread(imagepath);

debugShow = true; % When debug is true you can observe lines edges on clok image that are detected.
              % When debug is false code only shows readed time in below as output.
[edges,center,maxxy,minxy] = edgescenters(I,debugShow); %My function to detect center of clock image.

[arrowslines,longest,center] = findarrows(I,edges,center,maxxy,minxy,debugShow); %My function to detect lines and edges on clock image.
                                                                              %and longest lines
if isempty(arrowslines)    %If it can not detect line determines new center.
    info = imfinfo(imagepath);
    center(1) = info.Width/2; %I used information of photo to calculate center point
    center(2) = info.Height/2;
    maxxy = [info.Width info.Height];
    minxy = [0 0];
    [arrowslines,longest,center] = findarrows(I,edges,center,maxxy,minxy,debugShow);
end
finallines = struct('point1',{},'point2',{});  %Saves lines in struct
if length(arrowslines) == 1
    newlongest = arrowslines(1);
    finallines(1) = arrowslines(1);
    finallines(2) = arrowslines(1);
end
max_leng = 0;
j=1;
if length(arrowslines) == 3
    for i = 1 : length(arrowslines)
        if ~isequal(arrowslines(i),longest)
            finallines(j) = arrowslines(i);
            leng = norm(finallines(j).point1 - finallines(j).point2);
            if ( leng > max_leng)
              max_leng = leng;
              newlongest = arrowslines(i);
            end
            j = j+1;
        end
    end
elseif length(arrowslines) == 2
    finallines = arrowslines;
    newlongest = longest;
end
if isequal(finallines(1),newlongest)
    vminute = finallines(1).point2 - finallines(1).point1; %finding hour hand minute hand 
    vhour = finallines(2).point2 - finallines(2).point1;
else
    vhour = finallines(1).point2 - finallines(1).point1;
    vminute = finallines(2).point2 - finallines(2).point1;
end
vminute = [vminute 0];
vhour = [vhour 0];
v2 = [0 1 0];
angle1 =  atan2d(norm(cross(vminute,v2)),dot(vminute,v2)) + 360*(norm(cross(vminute,v2))<0); %Finding angles using tangent values.
angle2 =  atan2d(norm(cross(vhour,v2)),dot(vhour,v2)) + 360*(norm(cross(vhour,v2))<0);

if vminute(1) > 0
    angle1 = 360 - angle1; %Since clock is a circular thing it has 360 degree.Finding final angles in degree unit
end

if vhour(1) > 0
    angle2 = 360 -angle2;
end

minute = (angle1/6) + 60*(angle1/6 < 0);
hour = floor(angle2/30) + 12*(floor(angle2/30) <= 0);  %round lower values.
if minute >=59 && minute <= 59.54
    hour = hour-1;
end

disp(['The Clock is probably ',num2str(hour),':',num2str(minute)])