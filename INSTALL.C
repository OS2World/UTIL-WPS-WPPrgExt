#define INCL_WINWORKPLACE
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <os2.h>


main(int argc, char *argv[], char *envp[])
{
   CHAR myPath[256];
   BOOL rc;

   if (argc != 2 || strlen(argv[1]) != 1) {
      printf("Usage : \n\n");

      printf("install x\n");
      printf("     - where x is the os/2 system drive\n\n");
      return 1;
   }

   strcpy(myPath, argv[1]);
   strcat(myPath, ":\\OS2\\DLL\\wpprgext.dll");

   rc = WinRegisterObjectClass("WPPrgExt", (PSZ)myPath);

   if (!rc) {
      printf("Unable to register the class\n\n");
      return 1;
   }

   printf("Class WPPrgExt is registered\n\n...Trying to replace WPProgram class...Please wait\n\n");

   rc = WinReplaceObjectClass("WPProgram", "WPPrgExt", TRUE);

   if (!rc) {
      printf("Unable to replace WPPrgram class\n\n");
      return 1;
   }

   printf("Installation is completed...Please shut down and reboot\n\n");
   return 0;
}
