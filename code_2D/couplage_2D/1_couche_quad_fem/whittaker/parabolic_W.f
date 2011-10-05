C
C       ============================================================
C       Purpose: This program computes the parabolic cylinder 
C                functions W(a,�x) and their derivatives using
C                subroutine PBWA
C       Input  : a --- Parameter  ( 0 � |a| � 5 )
C                x --- Argument of W(a,�x)  ( 0 � |x| � 5 )
C       Output : W1F --- W(a,x)
C                W1D --- W'(a,x)
C                W2F --- W(a,-x)
C                W2D --- W'(a,-x)


        SUBROUTINE PARABOLIC_W(A,X,W1F,W1D,W2F,W2D)

        implicit none

        Real *8 A,X,W1F,W1D,W2F,W2D

        CALL PBWA(A,X,W1F,W1D,W2F,W2D)
	
        RETURN
        END


        SUBROUTINE PBWA(A,X,W1F,W1D,W2F,W2D)
C
C       ======================================================
C       Purpose: Compute parabolic cylinder functions W(a,�x)
C                and their derivatives
C       Input  : a --- Parameter  ( 0 � |a| � 5 )
C                x --- Argument of W(a,�x)  ( 0 � |x| � 5 )
C       Output : W1F --- W(a,x)
C                W1D --- W'(a,x)
C                W2F --- W(a,-x)
C                W2D --- W'(a,-x)
C       Routine called:
C               CGAMA for computing complex gamma function
C       ======================================================
C

        implicit none

        Integer *4 KF_ajout_DV,L1,M,K,L2
        Real *8 A,X,W1F,W1D,W2F,W2D,EPS,P0,G1,G2,X1,Y1,UGR,UGI
        Real *8 X2,VGR,VGI,F1,F2,H0,H1,H(100),HL,Y1F,R,R1,Y1D
        Real *8 D1,D2,D(100),DL,Y2F,Y2D

        EPS=1.0D-15
        P0=0.59460355750136D0
        IF (A.EQ.0.0D0) THEN
           G1=3.625609908222D0
           G2=1.225416702465D0
        ELSE
           X1=0.25D0
           Y1=0.5D0*A
           KF_ajout_DV=1
           CALL CGAMA(X1,Y1,KF_ajout_DV,UGR,UGI)
           G1=DSQRT(UGR*UGR+UGI*UGI)
           X2=0.75D0
           CALL CGAMA(X2,Y1,KF_ajout_DV,VGR,VGI)
           G2=DSQRT(VGR*VGR+VGI*VGI)
        ENDIF
        F1=DSQRT(G1/G2)
        F2=DSQRT(2.0D0*G2/G1)
        H0=1.0D0
        H1=A
        H(1)=A
        DO 10 L1=4,200,2
           M=L1/2
           HL=A*H1-0.25D0*(L1-2.0D0)*(L1-3.0D0)*H0
           H(M)=HL
           H0=H1
10         H1=HL
        Y1F=1.0D0
        R=1.0D0
        DO 15 K=1,100
           R=0.5D0*R*X*X/(K*(2.0D0*K-1.0D0))
           R1=H(K)*R
           Y1F=Y1F+R1
           IF ((DABS(R1/Y1F).LE.EPS).AND.(K.GT.30)) GO TO 20
15      CONTINUE
20      Y1D=A
        R=1.0D0
        DO 25 K=1,100
           R=0.5D0*R*X*X/(K*(2.0D0*K+1.0D0))
           R1=H(K+1)*R
           Y1D=Y1D+R1
           IF ((DABS(R1/Y1D).LE.EPS).AND.(K.GT.30)) GO TO 30
25      CONTINUE
30      Y1D=X*Y1D
        D1=1.0D0
        D2=A
        D(1)=1.0D0
        D(2)=A
        DO 40 L2=5,160,2
           M=(L2+1)/2
           DL=A*D2-0.25D0*(L2-2.0D0)*(L2-3.0D0)*D1
           D(M)=DL
           D1=D2
40         D2=DL
        Y2F=1.0D0
        R=1.0D0
        DO 45 K=1,100
           R=0.5D0*R*X*X/(K*(2.0D0*K+1.0D0))
           R1=D(K+1)*R
           Y2F=Y2F+R1
           IF ((DABS(R1/Y2F).LE.EPS).AND.(K.GT.30)) GO TO 50
45      CONTINUE
50      Y2F=X*Y2F
        Y2D=1.0D0
        R=1.0D0
        DO 55 K=1,100
           R=0.5D0*R*X*X/(K*(2.0D0*K-1.0D0))
           R1=D(K+1)*R
           Y2D=Y2D+R1
           IF ((DABS(R1/Y2D).LE.EPS).AND.(K.GT.30)) GO TO 60
55      CONTINUE     
60      W1F=P0*(F1*Y1F-F2*Y2F)
        W2F=P0*(F1*Y1F+F2*Y2F)
        W1D=P0*(F1*Y1D-F2*Y2D)
        W2D=P0*(F1*Y1D+F2*Y2D)
        RETURN
        END


        SUBROUTINE CGAMA(X,Y,KF,GR,GI)
C
C       =========================================================
C       Purpose: Compute complex gamma function �(z) or Ln[�(z)]
C       Input :  x  --- Real part of z
C                y  --- Imaginary part of z
C                KF --- Function code
C                       KF=0 for Ln[�(z)]
C                       KF=1 for �(z)
C       Output:  GR --- Real part of Ln[�(z)] or �(z)
C                GI --- Imaginary part of Ln[�(z)] or �(z)
C       ========================================================
C

        implicit none

        Integer *4 KF,NA,K,J
        Real *8 X,Y,GR,GI,A(10),X1,Y1,X0,Z1,TH,PI,T,GR1,GI1,TH1,SR,SI
        Real *8 Z2,TH2,G0,DEUX,X_tamp,Y_tamp

c ajout DV
        X_tamp=X
        Y_tamp=Y
c

        DEUX=2.
        PI=3.141592653589793D0
        DATA A/8.333333333333333D-02,-2.777777777777778D-03,
     &         7.936507936507937D-04,-5.952380952380952D-04,
     &         8.417508417508418D-04,-1.917526917526918D-03,
     &         6.410256410256410D-03,-2.955065359477124D-02,
     &         1.796443723688307D-01,-1.39243221690590D+00/
        IF ((Y.EQ.0.0D0).AND.(X.EQ.INT(X)).AND.(X.LE.0.0D0)) THEN
           GR=1.0D+300
           GI=0.0D0
           RETURN
        ELSE IF (X.LT.0.0D0) THEN
c           X1=X
c           Y1=Y
           X=-X
           Y=-Y
        ENDIF
        X0=X
        IF (X.LE.7.0) THEN
           NA=INT(7-X)
           X0=X+NA
        ENDIF
        Z1=DSQRT(X0*X0+Y*Y)
        TH=DATAN(Y/X0)
        GR=(X0-.5D0)*DLOG(Z1)-TH*Y-X0+0.5D0*DLOG(2.0D0*PI)
        GI=TH*(X0-0.5D0)+Y*DLOG(Z1)-Y
        DO 10 K=1,10
           T=Z1**(1-2*K)
           GR=GR+A(K)*T*DCOS((2.0D0*K-1.0D0)*TH)
10         GI=GI-A(K)*T*DSIN((2.0D0*K-1.0D0)*TH)
        IF (X.LE.7.0) THEN
           GR1=0.0D0
           GI1=0.0D0
           DO 15 J=0,NA-1
              GR1=GR1+.5D0*DLOG((X+J)**2+Y*Y)
15            GI1=GI1+DATAN(Y/(X+J))
           GR=GR-GR1
           GI=GI-GI1
        ENDIF

c        IF (X1.LT.0.0D0) THEN
        IF (X_tamp.LT.0.0D0) THEN
           Z1=DSQRT(X*X+Y*Y)
           TH1=DATAN(Y/X)
c ajout DV
           IF (DABS(Y).LT.10.) THEN
              SR=-DSIN(PI*X)*DCOSH(PI*Y)
              SI=-DCOS(PI*X)*DSINH(PI*Y)
              Z2=DSQRT(SR*SR+SI*SI)
              TH2=DATAN(SI/SR)
              IF (SR.LT.0.0D0) TH2=PI+TH2
              GR=DLOG(PI/(Z1*Z2))-GR
              GI=-TH1-TH2-GI
           ELSE IF (Y.GT.10) THEN
              TH2=DATAN(1./DTAN(PI*X))
              IF ((-DSIN(PI*X)).LT.0.0D0) TH2=PI+TH2
              GR=DLOG(PI/Z1)-PI*Y+DLOG(DEUX)-GR
              GI=-TH1-TH2-GI
           ELSE
              TH2=DATAN(-1./DTAN(PI*X))
              IF ((-DSIN(PI*X)).LT.0.0D0) TH2=PI+TH2
              GR=DLOG(PI/Z1)+PI*Y+DLOG(DEUX)-GR
              GI=-TH1-TH2-GI
           ENDIF
c
c           X=X1
c           Y=Y1
        ENDIF

        IF (KF.EQ.1) THEN
           G0=DEXP(GR)
           GR=G0*DCOS(GI)
           GI=G0*DSIN(GI)
        ENDIF

c ajout DV
        X=X_tamp
        Y=Y_tamp
c

        RETURN
        END



