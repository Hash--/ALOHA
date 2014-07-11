% Matlab m-File exported from HFSS15.0.0 
% Note: In three-dimensional arrays, like S(i,j,k), the first index corresponds to the frequency.
%       So, S(N,j,k) is an S(j,k) matrix for frequency N.

f = zeros(1,1);
S = zeros(1,5,5);

f = [3700000000 ];
S(1,:,:) = [   -2.504855E-002 +    1.875163E-003i,    1.871349E-002 +    4.964564E-001i,    5.014251E-001 -    2.601981E-002i,   -1.707871E-002 -    5.005648E-001i,   -4.993811E-001 +    1.440559E-002i;   1.871349E-002 +    4.964564E-001i,   -2.094500E-002 -    4.484591E-001i,    4.502297E-001 +    4.809582E-001i,   -2.427316E-001 -    1.093752E-003i,   -2.294075E-003 +    2.422272E-001i;   5.014251E-001 -    2.601981E-002i,    4.502297E-001 +    4.809582E-001i,    4.346049E-002 +    4.381560E-001i,    2.295780E-003 +    2.451874E-001i,    2.446947E-001 -    1.076345E-003i;  -1.707871E-002 -    5.005648E-001i,   -2.427316E-001 -    1.093752E-003i,    2.295780E-003 +    2.451874E-001i,   -3.096032E-002 -    4.469833E-001i,    4.413950E-001 +    4.842718E-001i;  -4.993811E-001 +    1.440559E-002i,   -2.294075E-003 +    2.422272E-001i,    2.446947E-001 -    1.076345E-003i,    4.413950E-001 +    4.842718E-001i,    2.402512E-002 +    4.493653E-001i];
