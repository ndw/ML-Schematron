xquery version "1.0-ml";

(: Copyright 2010 Mark Logic Corporation.  All Rights Reserved. :)

module namespace sch="http://marklogic.com/schematron";

declare namespace s="http://www.ascc.net/xml/schematron";
declare namespace xsl="http://www.w3.org/1999/XSL/Transform";
declare namespace svrl="http://purl.oclc.org/dsdl/svrl";

declare default function namespace "http://www.w3.org/2005/xpath-functions";

(: Edit these paths if you don't follow the "global" install instructions :)
declare variable $include := "/Schematron/iso_dsdl_include.xsl";
declare variable $expand  := "/Schematron/iso_abstract_expand.xsl";
declare variable $compile := "/Schematron/iso_svrl_for_xslt2.xsl";

declare variable $BADSCHEMA := xs:QName("sch:BADSCHEMA");
declare variable $BADDOC := xs:QName("sch:BADDOC");

declare function sch:compile-schema(
  $schema as node())
as document-node(element(xsl:stylesheet))
{
  let $sch
    := typeswitch ($schema)
       case document-node()
            return $schema
       case element()
            return document { $schema }
       default
            return error($BADSCHEMA,
                         "Schematron schema must be a document or element.")
  let $included := xdmp:xslt-invoke($include, $sch)
  let $expanded := xdmp:xslt-invoke($expand, $included)
  return
    xdmp:xslt-invoke($compile, $expanded)
};

declare function sch:validate-document($document, $schema) {
  sch:validate-document($document, $schema, ())
};

declare function sch:validate-document(
  $document as node(),
  $schema as node(),
  $params as map:map?)
as document-node(element(svrl:schematron-output))?
{
  let $compiled := sch:compile-schema($schema)
  let $doc
    := typeswitch ($document)
       case document-node()
            return $document
       case element()
            return document { $document }
       default
            return error($BADDOC,
                         "Schematron can only validate a document or element.")
  return
    xdmp:xslt-eval($compiled, $doc, $params)
};
