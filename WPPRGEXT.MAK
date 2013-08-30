#*********************************************************
.SUFFIXES:
.SUFFIXES: .c .obj .dll .csc .sc .h .ih .ph .psc .rc .res

#*********************************************************
# set environment 
#*********************************************************
SOMTEMP = .\somtemp
HPATH   = e:\toolkt21\c\os2h
LIBPATH = e:\toolkt21\os2lib

#*********************************************************
# set environment for sc
#*********************************************************
!if [set SMINCLUDE=.;e:\toolkt21\sc;] || \
    [set SMTMP=$(SOMTEMP)] || \
    [set SMEMIT=def;ih;h;ph;psc;sc;c]
!endif

#*********************************************************
# create temporary directory for sc
#*********************************************************
!if [cd $(SOMTEMP)]
!  if [md $(SOMTEMP)]
!    error error creating $(SOMTEMP) directory
!  endif
!else
!  if [cd ..]
!    error - Couldn't cd .. from $(SOMTEMP) directory
!  endif
!endif

#*********************************************************
CC      = icc /c /Gd- /Se /Re /ss /Ms /Gm+ /Ge-
LINK    = LINK386
LDFLAGS = /noi /map /nol /nod /exepack /packcode /packdata /align:16
DLLLIBS = DDE4NBS + os2386 som.lib

OBJS = wpprgext.obj

.csc.ih:
        sc -v -r $*.csc

.c.obj:
        $(CC) -I$(HPATH) -c $<

all: wpprgext.dll

wpprgext.ih:   $$(@B).csc $(HPATH)\wpdataf.h

wpprgext.obj: $$(@B).c $$(@B).ih $$(@B).h  $$(@B).sc $(HPATH)\wpdataf.h

wpprgext.dll: $$(@B).def $(OBJS) wpprgext.res
         $(LINK) $(LDFLAGS) $(OBJS),$@,,$(DLLLIBS),$*;
         rc $*.res $*.dll

wpprgext.res: $$(@B).rc $$(@B).ih
         rc -r $*.rc $*.res
