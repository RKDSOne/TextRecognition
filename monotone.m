function monotone_img = monotone(img,intensity)
    [m,n]=size(img);
    intensity_factor=intensity; 
    monotone_img=ones(m,n);
    for i=1:m
        for j=1:n
            if img(i,j)< 255*intensity_factor 
                monotone_img(i,j)=0;
            end
        end
    end
    

end