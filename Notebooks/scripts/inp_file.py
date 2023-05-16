class CreateInputFile:

    """This class creates the input file for the NMSSMTools package. (Z3 Symmetry)"""
    def __init__(self):

        """Default values for the input file."""
        self.alpha_em = 127.92E0
        self.GF = 1.1663787E-5
        self.alpha_s = 0.1181E0
        self.MZ = 91.187E0
        self.MB = 4.18E0
        self.MTOP = 173.4E0
        self.MTAU = 1.777E0
        self.TAN_Beta = 5
        self.MSUSY = 1000E0
        self.M1 = 560
        self.M2 = 1200
        self.M3 = 1980
        self.AU3 = 1800
        self.AD3 = 1000
        self.AE3 = -1600
        self.AE2 = 0E0
        self.ML3 = 300E0
        self.ML2 = 300E0
        self.ME3 = 300E0
        self.ME2 = 300E0
        self.MQ3 = 1000E0
        self.MQ2 = 1000E0
        self.MU3 = 1000E0
        self.MU2 = 1000E0
        self.MD3 = 1000E0
        self.MD2 = 1000E0
        self.LAMBDA = 0.285
        self.KAPPA = 0.1165
        self.ALAMBDA = 670
        self.AKAPPA = 14
        self.MUEFF = 123.5
        self.MA = 0E0
        self.MP = 0E0

    # create a method set_parameters
    def set_parameters(self, **kwargs):
        for key, value in kwargs.items():
            setattr(self, key, value)


    def create_inp(self,
        alpha_em = None, GF= None, alpha_s= None, MZ= None, MB= None, MTOP= None, MTAU= None,
        TAN_Beta= None, MSUSY= None,
        M1= None, M2= None, M3= None,
        AU3= None, AD3= None, AE3= None, AE2= None, ML3= None, ML2= None, ME3= None, ME2= None,
        MQ3= None, MQ2= None, MU3= None, MU2= None, MD3= None, MD2= None,
        LAMBDA= None, KAPPA= None, ALAMBDA= None, AKAPPA= None, MUEFF= None,
        MA= None, MP=None):

        if alpha_em is None:
            alpha_em = self.alpha_em
        if GF is None:
            GF = self.GF
        if alpha_s is None:
            alpha_s = self.alpha_s
        if MZ is None:
            MZ = self.MZ
        if MB is None:
            MB = self.MB
        if MTOP is None:
            MTOP = self.MTOP
        if MTAU is None:
            MTAU = self.MTAU
        if TAN_Beta is None:
            TAN_Beta = self.TAN_Beta
        if MSUSY is None:
            MSUSY = self.MSUSY
        if M1 is None:
            M1 = self.M1
        if M2 is None:
            M2 = self.M2
        if M3 is None:
            M3 = self.M3
        if AU3 is None:
            AU3 = self.AU3
        if AD3 is None:
            AD3 = self.AD3
        if AE3 is None:
            AE3 = self.AE3
        if AE2 is None:
            AE2 = self.AE2
        if ML3 is None:
            ML3 = self.ML3
        if ML2 is None:
            ML2 = self.ML2
        if ME3 is None:
            ME3 = self.ME3
        if ME2 is None:
            ME2 = self.ME2
        if MQ3 is None:
            MQ3 = self.MQ3
        if MQ2 is None:
            MQ2 = self.MQ2
        if MU3 is None:
            MU3 = self.MU3
        if MU2 is None:
            MU2 = self.MU2
        if MD3 is None:
            MD3 = self.MD3
        if MD2 is None:
            MD2 = self.MD2
        if LAMBDA is None:
            LAMBDA = self.LAMBDA
        if KAPPA is None:
            KAPPA = self.KAPPA
        if ALAMBDA is None:
            ALAMBDA = self.ALAMBDA
        if AKAPPA is None:
            AKAPPA = self.AKAPPA
        if MUEFF is None:
            MUEFF = self.MUEFF
        if MA is None:
            MA = self.MA
        if MP is None:
            MP = self.MP


        """Create an input file for NMSSMTools"""
        return f"""# Input file for NMSSMTools
# Based on SUSY LES HOUCHES ACCORD II
#
BLOCK MODSEL
	3	1		# NMSSM particle content
	1	3		# IMOD (0=general NMSSM, 1=SUGRA, 2=GMSB
#					3=Z3 inv NMSSM, 4=Z3 inv SUGRA, 5=Z3 inv GMSB)
	10	0		# ISCAN (0=no scan, 1=grid scan, 2=random scan, 3=MCMC)
	9	2		# |OMGFLAG|=0: no (default), =1: relic density only,
#					=2: dir. det. rate, =3: indir. det. rate, =4: both,
#					OMGFLAG>0: 0.107<OMG<0.131, <0: OMG<0.131
	15	7		# Precision for micromegas (default=0):
#					+0/1: fast computation on/off
#					+0/2: Beps=1d-3, 1d-6
#					+0/4: virtual Ws off/on
	8	8		 # Precision for Higgs masses (default 0:
#					0: full 1 loop top/bot + LL 2 loop top/bot + LL 1 loop EW
#					1: full 1 loop + full 2 loop top/bot
#					2: as 1 + pole masses - 1&2 by courtesy of P. Slavich)
#					+3: computation of Higgs mass uncertainty by varying the RG scale by *2 and /2
#					+6: check that uncertainty is < 3 GeV
	14	1		# 0: H-> VV,VV* (default); 1: H->VV,VV*,V*V*
	13	1		# 1: Sparticle decays via NMSDECAY (default 0)
	16	0		# 0: Output contains privately defined BLOCK's (default)
#					1: Restricts the output to BLOCK's defined by SLHA1/2
#					(useful as param_card.dat for MadGraph)
	22	0		# CMS charg(neutral)ino constraints (1=yes, 0=no, default=0)
    23	0		# Delta_MW (=-1 computed, 1=computed and contraints checked,
#					0=not computed, default=0)
	24	0		# LHC SUSY constraints via SmodelS (1=yes, 0=no, default=0)
#
BLOCK SMINPUTS
	1	{alpha_em}		# ALPHA_EM^-1(MZ)
	2	{GF}		# GF
	3	{alpha_s}		# ALPHA_S(MZ)
	4	{MZ}		# MZ
	5	{MB}		# MB(MB) (running mass)
	6	{MTOP}		# MTOP (pole mass)
	7	{MTAU}		# MTAU
#
BLOCK MINPAR
        3	{TAN_Beta}		# TANB at MZ
#
BLOCK EXTPAR
#	0	{MSUSY}		# MSUSY (If =/= SQRT(2*MQ1+MU1+MD1)/2)
	1	{M1}		# M1 (If =/= M2/2)
	2	{M2}		# M2
	3	{M3}		# M3 (If =/= 3*M2)
	11	{AU3}		# AU3
	12	{AD3}		# AD3
	13	{AE3}		# AE3
#	16	{AE2}		# AE2 = AE1 (If =/= AE3)
	33	{ML3}		# ML3
#	32	{ML2}		# ML2 = ML1 (If =/= ML3)
	36	{ME3}		# ME3
#	35	{ME2}		# ME2 = ME1 (If =/= ME3)
	43	{MQ3}		# MQ3
#	42	{MQ2}		# MQ2 = MQ1 (If =/= MQ3)
	46	{MU3}		# MU3
#	45	{MU2}		# MU2 = MU1 (If =/= MU3)
	49	{MD3}		# MD3
#	48	{MD2}		# MD2 = MD1 (If =/= MD3)
	61	{LAMBDA}		# LAMBDA
	62	{KAPPA}		# KAPPA (If =/= 0)
	63	{ALAMBDA}		# ALAMBDA (If XIF+MA are not inputs)
	64	{AKAPPA}		# AKAPPA (If KAPPA =/=0 and XIS+MP are not inputs)
#						If KAPPA = 0: AKAPPA must be 0
	65	{MUEFF}		# MUEFF
#	124	{MA}		# MA (If ALAMBDA is not an input)
#						If ALAMBDA+MA are not inputs: ALAMBDA=0, MA is computed
#	125	{MP}		# MP (If AKAPPA is not an input)
#						If AKAPPA+MP are not inputs: AKAPPA=0, MP is computed
"""

    # save the input file by formatting the the default values if it is not given

    def save_input_file(self, file_name, **kwargs):
        """
        
        Save the input file
        
        Parameters
        ----------
        file_name : str
        
        **kwargs : dict
            The values to be used in the input file
            
        Returns
        -------
            None
        
        """

        with open(file_name, "w") as f:
            f.write(self.create_inp(**kwargs))
            