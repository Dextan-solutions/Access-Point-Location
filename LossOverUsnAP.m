function MinLoss = LossOverUsnAP(AP)
% Z=[0,3,6,9];
% l=AP(:,3);
% l(l>4)=4;
% l(l<1)=1;
% for i = 1:length(l)
% AP(i,3)=Z(l(i));
% end
CeilFact = CeilingFac(AP);
DiffAPnUser = Diff_Btwn_APnUser(AP);
initialNo_AP = size(AP,1);
% APcord=size(AP);
No_User = size(DiffAPnUser,1);
Loss = zeros(No_User,initialNo_AP);

MinLoss = zeros(No_User,1);

for i =1:No_User
    for j=1:initialNo_AP
       Loss(i,j) = 40.04+10*log10(DiffAPnUser(i,j))^2+CeilFact(i,j);
    end
end

for i = 1:No_User
    MinLoss(i) = min(Loss(i,:));
end