function [character_images,nofchars] = parse_line(img,line_begin,line_end,MAXCHARS )
    character_images=zeros(20,20,MAXCHARS);
    horz=zeros(1,n);
    for i=1:n
        for j=line_begin:line_end
            if(img_monotone(j,i)==0)
                horz(1,i)=1;break;
                %alternate-> horz(1,i)=1+horz(1,i);
            end
        end
    end
    %extract derivative
    for i=1:n-1
        if horz(1,i)<horz(1,i+1)
           horz(1,i)=-1;
        end
        if horz(1,i)==horz(1,i+1)
            horz(1,i)=0;
        end
        if horz(1,i)>horz(1,i+1)
           horz(1,i)=1;
        end
    end
    
    %extract words- find avg duration of 0 in horz then divide accordingly

    %extracting column coords from horz (code working but improvement required)
    colms=0;
    colm_coords=zeros(1,MAXCHARS);
    for i=2:n
        colms=colms+1;
        if horz(1,i)==1 && horz(1,i-1)~=1
            colm_coords(1,colms)=i;
        else
            if horz(1,i)==-1 && horz(1,i-1)~=-1
                colm_coords(1,colms)=i;
            else
                colms=colms-1;
            end
        end
    end
    
    %clustering to extract words and spaces - ?
    
    
    %resize and return
    nofchars=0;
    for i=1:2:colms
        nofchars=noofchars+1;
        character_images(:,:,char)=resize2_20x20(img(line_begin:line_end,colm_coords(1,i):colm_coords(1,i+1)));
    
    end
    
end