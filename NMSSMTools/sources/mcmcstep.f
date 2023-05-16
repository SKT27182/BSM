      SUBROUTINE MCMCSTEP(PAR,PROB,NPROB,IFAIL) 

      IMPLICIT NONE 
 
      CHARACTER CHAN*20

      INTEGER IFAIL,I,NTOT,IDUM,TOTMIN,TOTMAX,NMAX,NPROB
      INTEGER M1FLAG,M2FLAG,M3FLAG,MHDFLAG,MHUFLAG
      INTEGER MSFLAG,AKFLAG,ALFLAG,OMGFLAG,MAFLAG,MOFLAG
      INTEGER MCFLAG,NSUSY,NGUT,NMES
      PARAMETER (NSUSY=14,NGUT=21,NMES=21)

      DOUBLE PRECISION PAR(*),PROB(*),P,RAN2,XDUM,PP,R
      DOUBLE PRECISION FTSUSY(NSUSY+2),FTGUT(NGUT+2),FTMES(NMES+2)
      DOUBLE PRECISION SMASS(3),PMASS(2),CMASS,SCOMP(3,3),PCOMP(2,2)
      DOUBLE PRECISION MGL,MCHA(2),U(2,2),V(2,2),MNEU(5),NEU(5,5)
      DOUBLE PRECISION MUR,MUL,MDR,MDL,MLR,MLL,MNL
      DOUBLE PRECISION MST1,MST2,MSB1,MSB2,MSL1,MSL2,MSNT
      DOUBLE PRECISION CST,CSB,CSL,MSMU1,MSMU2,MSNM,CSMU
      DOUBLE PRECISION RMST1,RMST2,S2T,RMSB1,RMSB2,S2B,XT,XB
      DOUBLE PRECISION XIF,XIS,MUP,MSP,M3H
      DOUBLE PRECISION LCEN,KCEN,TBCEN,MUCEN,ALCEN,AKCEN,XIFCEN,XISCEN
      DOUBLE PRECISION MUPCEN,MSPCEN,M3HCEN,MACEN,MPCEN,M1CEN,M2CEN
      DOUBLE PRECISION M3CEN,AU3CEN,AD3CEN,AE3CEN,AE2CEN,ML3CEN,ML2CEN
      DOUBLE PRECISION ME3CEN,ME2CEN,MQ3CEN,MQ2CEN,MU3CEN,MU2CEN,MD3CEN
      DOUBLE PRECISION MD2CEN,LDEV,KDEV,TBDEV,MUDEV,ALDEV,AKDEV,XIFDEV
      DOUBLE PRECISION XISDEV,MUPDEV,MSPDEV,M3HDEV,MADEV,MPDEV,M1DEV
      DOUBLE PRECISION M2DEV,M3DEV,AU3DEV,AD3DEV,AE3DEV,AE2DEV,ML3DEV
      DOUBLE PRECISION ML2DEV,ME3DEV,ME2DEV,MQ3DEV,MQ2DEV,MU3DEV,MU2DEV
      DOUBLE PRECISION MD3DEV,MD2DEV,LMIN,KMIN,TBMIN,MUMIN,ALMIN,AKMIN
      DOUBLE PRECISION XIFMIN,XISMIN,MUPMIN,MSPMIN,M3HMIN,MAMIN,MPMIN
      DOUBLE PRECISION M1MIN,M2MIN,M3MIN,AU3MIN,AD3MIN,AE3MIN,AE2MIN
      DOUBLE PRECISION ML3MIN,ML2MIN,ME3MIN,ME2MIN,MQ3MIN,MQ2MIN
      DOUBLE PRECISION MU3MIN,MU2MIN,MD3MIN,MD2MIN,XCEN,XDEV,X
      DOUBLE PRECISION BRJJ(5),BREE(5),BRMM(5),BRLL(5)
      DOUBLE PRECISION BRCC(5),BRBB(5),BRTT(5),BRWW(3),BRZZ(3)
      DOUBLE PRECISION BRGG(5),BRZG(5),BRHHH(4),BRHAA(3,3)
      DOUBLE PRECISION BRHCHC(3),BRHAZ(3,2),BRAHA(3),BRAHZ(2,3)
      DOUBLE PRECISION BRHCW(5),BRHIGGS(5),BRNEU(5,5,5),BRCHA(5,3)
      DOUBLE PRECISION BRHSQ(3,10),BRHSL(3,7),BRASQ(2,2),BRASL(2)
      DOUBLE PRECISION BRSUSY(5),WIDTH(5),BR(5)
      DOUBLE PRECISION CU(5),CD(5),CV(3),CJ(5),CG(5),CB(5),CL(5)

      DOUBLE PRECISION brcharsel(2),brcharser(2),brcharsmu1(2),
     .         brcharsmu2(2),brcharstau1(2),brcharstau2(2),
     .         brcharsne1(2),brcharsne2(2),brcharsnm1(2),brcharsnm2(2),
     .         brcharsnt1(2),brcharsnt2(2),brcharsupl(2),brcharsupr(2),
     .         brcharsdownl(2),brcharsdownr(2),brcharst1(2),
     .         brcharst2(2),brcharsb1(2),brcharsb2(2),brcharwneut(2,5),
     .         brcharhcneut(2,5),brcharzchic,brcharHchic(3),
     .         brcharAchic(2),brntaunut(2,5),brnelnue(2,5),
     .         brnmunumu(2,5),brnupdb(2,5),brnchsb(2,5),brntopbb(2,5),
     .         brglupdb(2),brglchsb(2),brgltopbb(2),brchee,brchmumu,
     .         brchtautau,brchnene,brchnmunmu,brchntauntau,brchupup,
     .         brchdodo,brchchch,brchstst,brchtoptop,brchbotbot
*
      COMMON/CHARGINO_BR_2BD/brcharsel,brcharser,brcharsmu1,
     .         brcharsmu2,brcharstau1,brcharstau2,
     .         brcharsne1,brcharsne2,brcharsnm1,brcharsnm2,
     .         brcharsnt1,brcharsnt2,brcharsupl,brcharsupr,
     .         brcharsdownl,brcharsdownr,brcharst1,
     .         brcharst2,brcharsb1,brcharsb2,brcharwneut,
     .         brcharhcneut,brcharzchic,brcharHchic,
     .         brcharAchic
      COMMON/CHARGINO_BR_3BD/brntaunut,brnelnue,brnmunumu,
     .         brnupdb,brnchsb,brntopbb,
     .         brglupdb,brglchsb,brgltopbb,
     .         brchee,brchmumu,brchtautau,brchnene,
     .         brchnmunmu,brchntauntau,brchupup,brchdodo,
     .         brchchch,brchstst,brchtoptop,brchbotbot

      COMMON/BRN/BRJJ,BREE,BRMM,BRLL,BRCC,BRBB,BRTT,BRWW,
     . BRZZ,BRGG,BRZG,BRHHH,BRHAA,BRHCHC,BRHAZ,BRAHA,BRAHZ,
     . BRHCW,BRHIGGS,BRNEU,BRCHA,BRHSQ,BRHSL,BRASQ,BRASL,
     . BRSUSY,WIDTH
      COMMON/REDCOUP/CU,CD,CV,CJ,CG
      COMMON/CB/CB,CL
      COMMON/SUSYEXT/XIF,XIS,MUP,MSP,M3H
      COMMON/HIGGSPEC/SMASS,SCOMP,PMASS,PCOMP,CMASS
      COMMON/SUSYSPEC/MGL,MCHA,U,V,MNEU,NEU
      COMMON/SFSPEC/MUR,MUL,MDR,MDL,MLR,MLL,MNL,
     . MST1,MST2,MSB1,MSB2,MSL1,MSL2,MSNT,
     . CST,CSB,CSL,MSMU1,MSMU2,MSNM,CSMU
      COMMON/RADCOR/RMST1,RMST2,S2T,RMSB1,RMSB2,S2B,XT,XB
      COMMON/MCMCPAR/LCEN,KCEN,TBCEN,MUCEN,ALCEN,AKCEN,XIFCEN,XISCEN,
     . MUPCEN,MSPCEN,M3HCEN,MACEN,MPCEN,M1CEN,M2CEN,
     . M3CEN,AU3CEN,AD3CEN,AE3CEN,AE2CEN,ML3CEN,ML2CEN,
     . ME3CEN,ME2CEN,MQ3CEN,MQ2CEN,MU3CEN,MU2CEN,MD3CEN,
     . MD2CEN,LDEV,KDEV,TBDEV,MUDEV,ALDEV,AKDEV,XIFDEV,
     . XISDEV,MUPDEV,MSPDEV,M3HDEV,MADEV,MPDEV,M1DEV,
     . M2DEV,M3DEV,AU3DEV,AD3DEV,AE3DEV,AE2DEV,ML3DEV,
     . ML2DEV,ME3DEV,ME2DEV,MQ3DEV,MQ2DEV,MU3DEV,MU2DEV,
     . MD3DEV,MD2DEV,LMIN,KMIN,TBMIN,MUMIN,ALMIN,AKMIN,
     . XIFMIN,XISMIN,MUPMIN,MSPMIN,M3HMIN,MAMIN,MPMIN,
     . M1MIN,M2MIN,M3MIN,AU3MIN,AD3MIN,AE3MIN,AE2MIN,
     . ML3MIN,ML2MIN,ME3MIN,ME2MIN,MQ3MIN,MQ2MIN,
     . MU3MIN,MU2MIN,MD3MIN,MD2MIN,XCEN,XDEV,X
      COMMON/FINETUN/FTSUSY,FTGUT,FTMES
      COMMON/SCANFLAGS/M1FLAG,M2FLAG,M3FLAG,MHDFLAG,MHUFLAG,
     . MSFLAG,AKFLAG,ALFLAG
      COMMON/FLAGS/OMGFLAG,MAFLAG,MOFLAG
      COMMON/STEPS/NTOT,IDUM,TOTMIN,TOTMAX,NMAX
      COMMON/MCFLAG/MCFLAG
      COMMON/SMODELS/R,CHAN

      X=0d0

      IF(IFAIL.EQ.1.OR.IFAIL.EQ.3.OR.IFAIL.EQ.5.OR.IFAIL.EQ.7)THEN
       X=X+(2d0-SMASS(1))*1d20
      ENDIF
      IF(IFAIL.EQ.2.OR.IFAIL.EQ.3.OR.IFAIL.EQ.6.OR.IFAIL.EQ.7)THEN
       X=X+(2d0-PMASS(1))*1d20
      ENDIF
      IF(IFAIL.EQ.4.OR.IFAIL.EQ.5.OR.IFAIL.EQ.6.OR.IFAIL.EQ.7)THEN
       X=X+(2d0-CMASS)*1d20
      ENDIF

      IF(IFAIL.EQ.8)THEN
       X=MIN(X,RMST1)
       X=MIN(X,RMSB1)
       X=MIN(X,MST1)
       X=MIN(X,MST2)
       X=MIN(X,MSB1)
       X=MIN(X,MSB2)
       X=MIN(X,MUL)
       X=MIN(X,MUR)
       X=MIN(X,MDL)
       X=MIN(X,MDR)
       X=MIN(X,MSL1)
       X=MIN(X,MSNT)
       X=MIN(X,MSMU1)
       X=MIN(X,MSNM)
       X=MIN(X,MLR)
       X=MIN(X,MLL)
       X=MIN(X,MNL)
       X=(1d0-X)*1d20
      ENDIF

      IF(IFAIL.EQ.9.OR.IFAIL.GE.11)THEN
       X=1d40
      ENDIF

      IF(IFAIL.EQ.10)THEN
       DO I=1,NPROB
        X=X+DABS(PROB(I))
       ENDDO
       X=(1d0+X)*1d10
      ENDIF

      IF(IFAIL.EQ.0)THEN
       IF(MCFLAG.NE.0)THEN
        BR(1)=brcharsnt1(1)
        BR(2)=2d0*brcharsne1(1)
        BR(3)=brcharwneut(1,1)+2d0*brnupdb(1,1)+brntopbb(1,1)
     .       +brnelnue(1,1)+brnmunumu(1,1)+brntaunut(1,1)
        BR(4)=brcharstau1(1)
        BR(5)=2d0*brcharsel(1)
        X=X+MAX(BR(1),BR(2),BR(3),BR(4),BR(5))-BR(MCFLAG)
        IF(X.NE.0d0)THEN
         X=(1d0+X)*1d10
        ELSE
         X=R
        ENDIF
       ELSE
        X=R
       ENDIF
      ENDIF

      IF(X.EQ.0d0)X=1d0

      PP=(X-XCEN)/(.28d0*XDEV*MIN(X,XCEN))
      PP=MAX(PP,-8d0*DLOG(10d0))
      PP=MIN(PP,8d0*DLOG(10d0))
      P=1d0/(1d0+DEXP(PP))
      XDUM=RAN2(IDUM)
!      WRITE(0,*)"X",XCEN,X
!      WRITE(0,*)"P",P,XDUM
      IF(P.GE.XDUM)THEN
!       WRITE(0,*)"OK",IFAIL
       XCEN=X
       TBCEN=PAR(3)
       IF(M1FLAG.EQ.1)THEN
        M1CEN=PAR(20)
       ENDIF
       M2CEN=PAR(21)
       IF(M3FLAG.EQ.1)THEN
        M3CEN=PAR(22)
       ENDIF
       LCEN=PAR(1)
       KCEN=PAR(2)
       MUCEN=PAR(4)
       IF(MOD(MAFLAG,3).EQ.0)THEN
        ALCEN=PAR(5)
        XIFCEN=XIF
       ELSEIF(MOD(MAFLAG,3).EQ.1)THEN
        MACEN=PAR(23)
        XIFCEN=XIF
       ELSE
        ALCEN=PAR(5)
        MACEN=PAR(23)
       ENDIF
       IF(MAFLAG/3.EQ.0)THEN
        AKCEN=PAR(6)
        XISCEN=XIS
       ELSEIF(MAFLAG/3.EQ.1)THEN
        MPCEN=PAR(24)
        XISCEN=XIS
       ELSE
        AKCEN=PAR(6)
        MPCEN=PAR(24)
       ENDIF
       MUPCEN=MUP
       MSPCEN=MSP
       M3HCEN=M3H
       AU3CEN=PAR(12)
       AD3CEN=PAR(13)
       AE3CEN=PAR(14)
       AE2CEN=PAR(25)
       ML3CEN=DSQRT(PAR(10))
       ML2CEN=DSQRT(PAR(18))
       ME3CEN=DSQRT(PAR(11))
       ME2CEN=DSQRT(PAR(19))
       MQ3CEN=DSQRT(PAR(7))
       MQ2CEN=DSQRT(PAR(15))
       MU3CEN=DSQRT(PAR(8))
       MU2CEN=DSQRT(PAR(16))
       MD3CEN=DSQRT(PAR(9))
       MD2CEN=DSQRT(PAR(17))
      ELSE
!       WRITE(0,*)"NO",IFAIL
      ENDIF 
!      WRITE(0,*)""
!      WRITE(0,*)""

      END