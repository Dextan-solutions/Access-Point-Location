function CeilFact = CeilingFac(AP)
[userCord]=userCordData();
initialNo_AP = size(AP,1);
% Z=[0,3,6,9];
% l=AP(:,3);
% l(l>4)=4;
% l(l<1)=1;
% for i = 1:length(l)
% AP(i,3)=Z(l(i));
% end

APcord=size(AP);
No_User = size(userCord,1);
CeilFact = zeros(No_User,initialNo_AP);

for i =1:No_User
    for j=1:initialNo_AP
       CeilFact(i,j) = abs(userCord(i,3)+3-AP(j,3))./3*6;
    end
end