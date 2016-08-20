clc;
clear;
workspace;
%open image
img = imread('abcd_Times_new_roman_10.png');
[m,n,t]=size(img);
image(img);

%insert code here for removing noise
%img= imnoise(img,'salt & pepper',0.02);


%turn to gray scale
intensity_factor=0.5;%level for im2bw
img_monotone=im2bw(rgb2gray(img),intensity_factor);
imtool(img_monotone);

%have[nx1] matrix to store horizontal dot frequency 
vert=zeros(m,1);
for i=1:m
    for j=1:n
        if(img_monotone(i,j)==0)
            vert(i,1)=1;
            break;
        end
    end
end
% %alternate
% for i=1:m
%     for j=1:n
%         if(img_monotone(i,j)==0)
%             vert(i,1)=vert(i,1)+1;
%             break ;
%         end
%     end
% end

% plot(vert);
% %find avg and assign seperation factor 
% sum=0;
% for i=1:m
%     sum=sum+vert(i,1);
% end
% average=sum/m;
% for i=1:m
%     if(vert(i,1)<average)
%         vert(i,1)=0;
%     else
%         vert(i,1)=1;
%     end
% end

for i=1:m-1
    if vert(i,1)<vert(i+1,1)
        vert(i,1)=-1;
    end
    if vert(i,1)==vert(i+1)
        vert(i,1)=0;
    end
    if vert(i,1)>vert(i+1)
        vert(i,1)=1;
    end
end
vert(m,1)=vert(m-1,1); % for continuity

%extract end and begin of lines
lines=1;
MAXLINES=10;
line_coords=zeros(MAXLINES,1);
for i=2:m
    if vert(i,1)==1 && vert(i-1,1)~=1
        line_coords(lines,1)=i+1; % i-1 for a little leeway
        lines=lines+1;
    else
        if vert(i,1)==-1 && vert(i-1,1)~=-1
            line_coords(lines,1)=i ; %i+1 for a little leeway
            lines=lines+1;
        end
    end
end
lines=lines-1;
%try plotting horizontal seperation lines on the photo itself
render_line(img,line_coords);

% HORIZONTAL EXTRACTION
%for each horizontal strip do vertical scanning to extract letters and words
MAXCHARS=50;
document=zeros(20,20,MAXCHARS,MAXLINES);
char_count=zeros(MAXLINES,1);
lines_read=0;
for ln=1:2:lines
    lines_read=lines_read+1;
    [document(:,:,:,lines_read),char_count(lines_read,1)]=parse_line(img_monotone,line_coords(ln,1),line_coords(ln+1,1),MAXCHARS);
end
printf('\nNumber of Lines Read : %d',lines_read);

% %Predict and write to file
% fd=fopen('output.txt','w');
% for i=1:lines_read 
%     for j=1:char_count(i,1)
%         char=predict(document(:,:,j,i));
%         fprintf(fd,'%c',char);
%     end
%     fprintf(fd,'\n');
% end
% fclose(fd);
