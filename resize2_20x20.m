function resized_img = resize2_20x20(img)
    [m,n]=size(img);
    resized_img=zeros(20,20);
    width_source=n
    height_source=m
    width_dst=20;
    height_dst=20;
    
    %BILINEAR rescaling operation here 
    tx=(width_source)/width_dst;
    ty=(height_source)/height_dst;
    
    for i=1:height_dst-1
        for j=1:width_dst-1
            x=floor(tx*j);
            y=floor(ty*i);
            x_diff=(tx*j)-x;
            y_diff=(ty*j)-y;
            resized_img(i,j)=img(y,x)*(1-x_diff)*(1-y_diff)+img(y,x+1)*(1-y_diff)*(x_diff)+img(y+1,x)*(y_diff)*(1-x_diff)+img(y+1,x+1)*(y_diff)*(x_diff);
               
        end
    end
    
    
    
    
    
end