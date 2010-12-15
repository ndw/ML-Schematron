Hello,

This repository includes a schematron.xqy module that will allow you to
perform Schematron validation with MarkLogic Server version 4.2.

To enable Schematron globally:

1. Copy Modules/schematron.xqy into your server's Modules directory
2. Create Modules/Schematron
3. Copy the ISO Schematron distribution into Modules/Schematron

To enable Schematron for only a selected application:

1. Copy Modules/schematron.xqy into your application's modules directory
   or database.
2. Copy the ISO Schematron distribution into your application's modules
   directory or database.
3. Edit schematron.xqy. Change the variable declarations:

   declare variable $include := "/Schematron/iso_dsdl_include.xsl";
   declare variable $expand  := "/Schematron/iso_abstract_expand.xsl";
   declare variable $compile := "/Schematron/iso_svrl_for_xslt2.xsl";

   so that they point to the Schematron that you installed under your
   application.

Docs, etc. to follow. (In the fullness of time, like the next ice age,
probably. If you have questions, feel free to ask.)

You can test your install by running test/default.xqy. If it returns
"PASS", then you win. Otherwise, well, you don't. Let me know if it's
not obvious what's gone wrong.

Please note: if your schemas have the .sch file extension, then by
default MarkLogic will view them as binary files and the stylesheets
won't work. To fix this problem, either explicitly set the type to XML
when you load the files, or add a MIME type specification in the
Mimetypes admin UI asserting that .sch files are application/xml
before you begin loading them.

