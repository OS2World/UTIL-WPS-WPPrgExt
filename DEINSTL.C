#define INCL_WINWORKPLACE

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <os2.h>

main(int argc, char *argv[], char *envp[])
{
   BOOL rc;

   rc = WinReplaceObjectClass("WPProgram", "WPPrgExt", FALSE);

   if (!rc) {
      printf("Unable to restore WPProgram class\n\n");
      return 1;
   }

   rc = WinDeregisterObjectClass("WPPrgExt");
 
   if (!rc) {
      printf("Unable to deregister the class\n\n");
      return 1;
   }

   printf("Deinstallation is completed...Please shut down and reboot");
   return 0;
}
