function DiffAPnUser = Diff_Btwn_APnUser(AP)
% Z=[0,3,6,9];
% l=AP(:,3);
% l(l>4)=4;
% l(l<1)=1;
[userCord]=userCordData();
% for i = 1:length(l)
% AP(i,3)=Z(l(i));
% end
initialNo_AP = size(AP,1);
APcord=size(AP);
No_User = size(userCord,1);
DiffAPnUser = zeros(No_User,initialNo_AP);

for i =1:No_User
    for j=1:initialNo_AP
       DiffAPnUser(i,j) = sqrt(sum([(userCord(i,1)-AP(j,1)).^2,...
           (userCord(i,2)-AP(j,2)).^2,...
           (userCord(i,3)-AP(j,3)).^2]));
    end
end

