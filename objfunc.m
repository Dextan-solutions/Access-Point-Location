function f = objfunc(AP)

MinLoss = LossOverUsnAP(AP);

for i = 1:length(MinLoss)
    if MinLoss(i) < 70
        MinLoss(i)=0;
    else
        MinLoss(i) = MinLoss(i)-70;
    end
end
    
    f = sum(MinLoss);