clc,clear all

nAP=3;          % Put the number of desired Access Point here

display('Please wait while the system process your data......')
region = cell(nAP,1);
for i = 1:nAP
    region{i,1}=[1 1 3;
                99 99 9];
end

% Objective function
fnc = 'objfunc';

% number of variables
N = size(region{1,1},2);

% optimization parameters
tol = 1e-15;   % relative tolerance
M = 10^N; % number of vectors to randomize.
step = 0.5;  % in the range [0-1]. size of new region in comparison to old one.

%%% limit the number of points
Max_Array_size = 5e6;
if (M > Max_Array_size)
    M = Max_Array_size;
    'Warning - reducing number of samples due to memory limit'
    beep;
end

% evaluate tolerance
MT = 1e4;

for i = 1:MT
    for j=1:nAP
    xAP{i,1}=rand(nAP,N);
    xAP{i,1}=diag(region{j}(2,:) - region{j}(1,:))*xAP{i,1}'; % strech
    xAP{i,1} = (round(xAP{i,1} + ((region{j}(1,:)) * ones(1,N)')))' ;  % offset
    end
end

% Zz=[3,6,9];
for i = 1:MT
    for j=1:nAP
       l(i,j)= xAP{i,1}(j,3);
       if l(i,j)>= 5 && l(i,j)<=7
           l(i,j)=6;
       elseif l(i,j)< 5 || l(i,j)<= 3
           l(i,j)=3;
       elseif l(i,j)>= 8
           l(i,j)=9;
       end
       xAP{i,1}(j,3)=l(i,j);
    end
end

Z=zeros(size(xAP,1),1);  % preallocating Z

for i =1:size(xAP,1)
    Z(i) = abs(feval(fnc,xAP{i}));
end

med = median(Z);
abs_tol = abs(med * tol);  % absolute tolerance to stop the search

% start the iterative search
ObjVal = inf;
lastObjVal = -inf;
iter = 0;

while (abs(ObjVal - lastObjVal) > abs_tol)
        region;
for i = 1:M
    for j=1:nAP
    xAP{i,1}=rand(nAP,N);
    xAP{i,1}=diag(region{j}(2,:) - region{j}(1,:))*xAP{i,1}'; % strech
    xAP{i,1} = (round(xAP{i,1} + ((region{j}(1,:)) * ones(1,N)')))' ;  % offset
    end
end

% Zz=[3,6,9];
for i = 1:M
    for j=1:nAP
       l(i,j)= xAP{i,1}(j,3);
       if l(i,j)>= 5 && l(i,j)<=7
           l(i,j)=6;
       elseif l(i,j)< 5 || l(i,j)<= 3
           l(i,j)=3;
       elseif l(i,j)>= 8
           l(i,j)=9;
       end
       xAP{i,1}(j,3)=l(i,j);
    end
end

Z=zeros(size(xAP,1),1);  % preallocating Z

for i =1:size(xAP,1)
    Z(i) = abs(feval(fnc,xAP{i}));
end

%%% find the optimal solution within the current resolution
    ii = find(Z == min(Z));  ii = ii(1);
    fAP =xAP{ii};
    lastObjVal = ObjVal;
    ObjVal = feval(fnc, fAP);
    
%     display(['Best Objective function Value at iteration ', num2str(iter), 'is ', num2str(ObjVal)]) 
    
    for i = 1:nAP
        for n=1:N
            width(i)=(region{i}(2,n)- region{i}(1,n))*step;
            low(i)=fAP(i,n)-width(i)/2;
            high(i)=fAP(i,n)+width(i)/2;
            if low(i)<region{i}(1,n)
                low(i)=region{i}(1,n);
                high(i)=region{i}(1,n)+width(i);
            elseif (high(i)>region{i}(2,n))
                high(i) = region{i}(2,n);
                low(i) = high(i) - width(i);
            end
            region{i}(:,n)=[low(i) ; high(i)];
        end
    end
    iter = iter+1;
end
display('The optimal Access Point is......')

for i=1:nAP
    fprintf('%4g', fAP(i,1)); 
    fprintf('%4g', fAP(i,2)); 
    fprintf('  %8.3f', fAP(i,3));
    fprintf('\n');
end

display(['The objective function value at the Optimal point is ', num2str(ObjVal)])