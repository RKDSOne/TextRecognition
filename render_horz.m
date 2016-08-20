function []= render_horz(img,horz)
    [m,n,t]=size(img);
    [v,w]=size(vert);
    for i=1:v
        if vert(i,1)==0
            break;
        end
        for j=1:n
            img(vert(i,1),j)=100;
        end
    end
    imtool(img);
    
end