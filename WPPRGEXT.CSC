/******************************************************************************
*
*  Module Name : WPPRGEXT
*
*  Description : OS/2 Workplace Shell WPProgram Object Extension.
*                This extension adds the option to close the folder
*                to which the launching program belongs.
*
*  Programmer  : Yong D. Lee
*  Date        : Nov 21, 1993
*
*  Disclaimer of warranties:
*      The code is provided "AS IS", without warranty of any kind.  I shall 
*      not be liable for any damages arising out of your use of this code.
*
******************************************************************************/

#******************************************************************************
#   Include the class definition file for the parent class
#******************************************************************************

include <wppgm.sc>

#******************************************************************************
#   Define the new class
#******************************************************************************

class: WPPrgExt,
       external stem   = wpprgext,
       local,
       external prefix = wpprgext_,
       classprefix     = wpprgextM_,
       major version   = 1,
       minor version   = 8;

--
-- CLASS: WPPrgExt
--
-- DESCRIPTION:
--
--    This is a descendent object class for WPProgram object class. It can be
--    replaced for WPProgram object class.
--

#******************************************************************************
#   Specify the parent class
#******************************************************************************

parent: WPProgram;

#******************************************************************************
#   Specify the release order of new methods.  
#******************************************************************************

release order:
              QueryFolderClose,
              SetFolderClose,
              AddFolderOptionPage,
              AddFolderKeyPage,
              FindKeyFromScancode,
              FindScancodeFromKey,
              clsQueryModuleHandle;

#******************************************************************************
#   Passthru PRIVATE definitions to the .ph file
#******************************************************************************

passthru: C.ph;

   /*
    * Window data for the folder option dialog (settings page)
    */
   typedef struct _FOLDEROPTION
   {
      USHORT cb;                /* size of this structure                   */
      WPPrgExt *somSelf;        /* pointer to this instance                 */
      ULONG closeFolder;        /* indicates whether to close folder or not */
      BOOL save;
   } FOLDEROPTION;

   typedef FOLDEROPTION *PFOLDEROPTION;

   /*
    * Window data for the folder close key dialog (settings page)
    */
   typedef struct _FOLDERKEY
   {
      USHORT   cb;              /* size of this structure                   */
      WPPrgExt *somSelf;        /* pointer to this instance                 */
   } FOLDERKEY;

   typedef FOLDERKEY *PFOLDERKEY;

endpassthru;   /* C.ph */

#******************************************************************************
#   Passthru IMPLEMENTATION definitions to the .ih file
#******************************************************************************

passthru: C.ih;

   #define INCL_WIN
   #define INCL_DOS
   #define INCL_GPIBITMAPS
   #include <os2.h>

   #define INCL_WPFOLDER
   #define INCL_WINWORKPLACE
   #define WPCLASS

   #include <pmwp.h>

/*
 * IDs for string table
 */
   #define MAXKEY               13
   #define ID_TITLE             100
   #define IDSC_SHIFT           101
   #define IDSC_F1              102
   #define IDSC_F2              103
   #define IDSC_F3              104
   #define IDSC_F4              105
   #define IDSC_F5              106
   #define IDSC_F6              107
   #define IDSC_F7              108
   #define IDSC_F8              109
   #define IDSC_F9              110
   #define IDSC_F10             111
   #define IDSC_F11             112
   #define IDSC_F12             113

/*
 * IDs of dialog items in WPPRGEXT.RC
 */
   #define IDD_FOLDER                  200
   #define IDGROUP_FOLDERCLOSE         201
   #define IDCHECK_CLOSENOTEBOOK       202
   #define IDCHECK_CLOSEPROGRAM        203

   #define IDD_FOLDERKEY                300

   #define IDGROUP_KEYSELECTION         301
   #define IDTEXT_LINE1                 302
   #define IDTEXT_LINE2                 303
   #define IDTEXT_LINE3                 304
   #define IDTEXT_KEYSELECTION          305
   #define IDCOMBO_KEYSELECTION         306


/*
 * IDs for folderClose
 */
   #define DONOTCLOSE           0x00
   #define CLOSENOTEBOOK        0x01
   #define CLOSEPROGRAM         0x02

/*
 * Key for save-restore method
 */
    #define IDKEY_FOLDER 1

endpassthru;   /* .ih */

#******************************************************************************
#   Passthru PUBLIC definitions to the .h file
#******************************************************************************

passthru: C.h, after;


endpassthru;   /* C.h */

#******************************************************************************
#   Define instance data
#******************************************************************************

data:

   ULONG folderClose;                     /* indicates if to close folder */

#******************************************************************************
#   Define methods
#******************************************************************************

methods:

ULONG QueryFolderClose();
--
-- METHOD: QueryFolderClose                               ( ) PRIVATE
--                                                        (X) PUBLIC
-- DESCRIPTION:
--
--   Query state of folder close flag
--
-- RETURN:
--
--   ULONG - folder closing option
--

VOID SetFolderClose(ULONG flag);
--
-- METHOD: SetFolderClose                                 ( ) PRIVATE
--                                                        (X) PUBLIC
-- DESCRIPTION:
--
--   Set state of folder close flag
--
--

ULONG AddFolderOptionPage(HWND hwndNotebook);
--
-- METHOD: AddFolderOptionPage                            ( ) PRIVATE
--                                                        (X) PUBLIC
-- DESCRIPTION:
--
--   Add the folder page to the settings notebook
--
-- RETURN:
--
--   0              Unsuccessful
--   ulPageId       Identifier for the inserted page
--

ULONG AddFolderKeyPage(HWND hwndNotebook);
--
-- METHOD: AddFolderKeyPage                               ( ) PRIVATE
--                                                        (X) PUBLIC
-- DESCRIPTION:
--
--   Add the folder key selection page to the settings notebook
--
-- RETURN:
--
--   0              Unsuccessful
--   ulPageId       Identifier for the inserted page
--

VOID FindKeyFromScancode(LONG scanCode, CHAR *str);
--
-- METHOD: FindKeyFromScancode                            ( ) PRIVATE
--                                                        (X) PUBLIC
-- DESCRIPTION:
--
--   Find key name from scancode
--

ULONG FindScancodeFromKey(CHAR *str);
--
-- METHOD: FindScancodeFromKey                            ( ) PRIVATE
--                                                        (X) PUBLIC
-- DESCRIPTION:
--
--   Find scancode from key name
--
-- RETURN:
--
--   key scancode
--

#******************************************************************************
#   Specify methods being overridden
#******************************************************************************

-----------------------------------------------------------------------------
--   Methods from the WPObject class
-----------------------------------------------------------------------------

override wpInitData;
--
-- OVERRIDE: wpInitData                                   ( ) PRIVATE
--                                                        (X) PUBLIC
-- DESCRIPTION:
--
--   Initialize the state variables and allocate any extra memory
--   that might be needed
--

override wpSaveState;
--
-- OVERRIDE: wpSaveState                                  ( ) PRIVATE
--                                                        (X) PUBLIC
-- DESCRIPTION:
--
--   Save state variable (folder close flag)
--

override wpRestoreState;
--
-- OVERRIDE: wpRestoreState                               ( ) PRIVATE
--                                                        (X) PUBLIC
-- DESCRIPTION:
--
--   Restore saved state variable
--

override wpAddSettingsPages;
--
-- OVERRIDE: wpAddSettingsPages                           ( ) PRIVATE
--                                                        (X) PUBLIC
-- DESCRIPTION:
--
--   Add folder settings page to let the user alter the flag
--

override wpOpen;
--
--  METHOD: wpOpen                                        ( ) PRIVATE
--                                                        (X) PUBLIC
--  DESCRIPTION:
--
--    Opens the program object window. Close folder upon openning 
--    according to folderClose flag
--

#******************************************************************************
#   Define class methods
#******************************************************************************

HMODULE clsQueryModuleHandle (), class;
--
-- METHOD: clsQueryModuleHandle                           ( ) PRIVATE
--                                                        (X) PUBLIC
-- DESCRIPTION:
--
--   This method returns the module handle of this class.
--
-- RETURN:
--
--   0          Unsuccessful
--   non-zero   Module handle
--

#******************************************************************************
#   Specify class methods being overridden
#******************************************************************************

override wpclsInitData, class;
--
-- METHOD: wpclsInitData                                  ( ) PRIVATE
--                                                        (X) PUBLIC
-- DESCRIPTION:
--
--   Initialize the class data
--

override wpclsQueryTitle, class;
--
-- METHOD: wpclsQueryTitle                                ( ) PRIVATE
--                                                        (X) PUBLIC
-- DESCRIPTION:
--
--   Return the string "Extended Program".
--

