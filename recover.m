function res = recover(I, tran, A, tx)
    if (~exist('tx','var'))
        tx=0.1;
    end  
    if (isempty(tx))
        tx=0.1;
    end
    
    [h,w,c] = size(I);
    res = zeros(h, w, c);
    
    tran = max(tran,tx);
    
    res(:,:,1) = (I(:,:,1) - A(1))./tran + A(1);
    res(:,:,2) = (I(:,:,2) - A(2))./tran + A(2);
    res(:,:,3) = (I(:,:,3) - A(3))./tran + A(3);

return;