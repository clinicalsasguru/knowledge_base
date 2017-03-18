***The purpose of this macro is to create a new folder if it does not exist;


***SYSUSERID is an automatic macro variable created in SAS session based on the 
user-s credentials used to login to the system(Operation system);

%let _x_x_user=&sysuserid;

***%put statment is used to print the value assosciated with a macro variable;

%put &_x_x_user;

***%macro and %mend statments are used to define a macro;
***newfld is called a macro parameter - a postional parameter, to be specific;
*** %local statment is used to restrict the scope of the macro variables within a macro - so that,
no accidental overwriting the macro variables occur if a similar named global macro variable exist;
***filename function is used to assign/deassign a fileref to an external file of directory;
***fexist function is used to verify the existence of an external file by its fileref-
   returns 1 if the external file that is associated with fileref exists, and 0 if the file does not exist;
***%sysexec is used to pass commands to operating system command line;
***md - is the windows command for creating(make) a directory(folder);
*first filename function is used to assign the fileref and the last filename function is used to deassign the fileref;


%macro newfolder(newfld);
%local rc fileref;
%let rc=%sysfunc(filename(fileref,&newfld));
%if %sysfunc(fexist(&fileref)) %then %put NOTE:The directory "&newfld" already EXISTED.;
%else %do;
         %sysexec md "&newfld";
         %put NOTE:The directory "&newfld" has been CREATED.;
      %end;
%let rc=%sysfunc(filename(fileref));
%mend newfolder;

***sample macro call that creates a folder named dump on the desktop of the user running the sas session;

%newfolder(C:\Users\&_x_x_user.\Desktop\dump);
