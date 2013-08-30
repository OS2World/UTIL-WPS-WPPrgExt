WPPrgExt Workplace Shell Object Class Ver 1.84

Copyright (C) 1993, 1994 by Yong D. Lee (ydlee@cs.ukans.edu)

-------------------- Disclaimer ---------------------------
USE AT YOUR OWN RISK. WPPrgExt and its author will not be
responsible for any damages caused by using this program. 
The code is provided "AS IS" without warranty of any kind. 
The author shall not be liable for any damages arising out 
of your use of this program, even if he or she has been 
advised of the possibility of such damages.

--------------------- Bugs Fixed --------------------------
In the previous version, the desktop is closed if it is
the parent folder. This is fixed so that if the parent 
folder is the desktop, it will not be closed.

--------------------- Description -------------------------
WPDskExt is a replacement class for WPS WPProgram object
class with following features:

1. You can set disk (drive) objects to close the folder 
   to which it belongs when opening settings notebook, 
   or program.

   You can set the behavior by opening the settings 
   notebook, and set the check box in the first page
   under "Folder" tab.

2. You can also close the folder by pressing a key
   while opening a disk (drive) object. You can 
   configure which key to use in the second page under 
   "Folder" tab in setting notebook. 

   - The key selection has a global effect. Therefore 
     if you select a key in one folder, it will work 
     for all the folders.

   - If you have installed other replacement class
     (WPDskExt, WPFldExt), the key selection will not
     change the keys for the other classes. You have to
     change those keys seperately.

   - Currently the key selection allows shift keys or
     function keys, but it does not mean you can use
     any of those keys. Some of the keys might 
     conflict with existing programs or desktop.
     For example, F1 will invoke the help window. You
     may want to experiment with the settings. (I
     still like the shift keys despite of the extra
     click since it does not conflict with other
     applications)

   - If this key is pressed while opening a folder,
     it will ignore the settings in the notebook, and
     always close the folder it belongs to.

This program is tested only on OS/2 2.1. I am not sure
if it will work on OS/2 2.0.

-------------------- Installation -------------------------

If you have not installed previous version of WPPrgExt
class

1. Copy wpprgext.dll to the directory x:\OS2\DLL where
   x is your os/2 system drive letter.
2. Type install x where x is your os/2 system drive letter.
3. Shutdown and reboot.


If you have installed previous version of WPPrgExt class

1. Type deinstl.
2. Shutdown and reboot.
3. Copy wpprgext.dll to the directory x:\OS2\DLL where
   x is your os/2 system drive letter.
4. Type install x where x is your os/2 system drive letter.
5. Shutdown and reboot.

or

Just replace wpdskext.dll in your /os2/dll directory. You
should boot from the installation diskette or use a utility 
like shiftrun to be able to copy the file over.

--------------------- Deinstallation ----------------------
1. Type deinstl.
2. Shutdown and reboot.

This will restore original WPProgram class.

---------------------- Distribution -----------------------
This program can be freely distributed as long as all the 
original files remain unaltered. This program cannot be 
used for any commercial purpose without first obtaining 
author's permission.


-----------------------------------------------------------
If you have any comments or suggestions, send mail to

Yong D. Lee
180 Pinecone Dr.
Lawrence, KS 66046

or send e-mail to

ydlee@cs.ukans.edu
