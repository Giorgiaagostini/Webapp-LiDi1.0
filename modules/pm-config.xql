
xquery version "3.1";

module namespace pm-config="http://www.tei-c.org/tei-simple/pm-config";

import module namespace pm-liditest-web="http://www.tei-c.org/pm/models/liditest/web/module" at "../transform/liditest-web-module.xql";
import module namespace pm-liditest-print="http://www.tei-c.org/pm/models/liditest/print/module" at "../transform/liditest-print-module.xql";
import module namespace pm-liditest-latex="http://www.tei-c.org/pm/models/liditest/latex/module" at "../transform/liditest-latex-module.xql";
import module namespace pm-liditest-epub="http://www.tei-c.org/pm/models/liditest/epub/module" at "../transform/liditest-epub-module.xql";
import module namespace pm-liditest-fo="http://www.tei-c.org/pm/models/liditest/fo/module" at "../transform/liditest-fo-module.xql";
import module namespace pm-docx-tei="http://www.tei-c.org/pm/models/docx/tei/module" at "../transform/docx-tei-module.xql";

declare variable $pm-config:web-transform := function($xml as node()*, $parameters as map(*)?, $odd as xs:string?) {
    switch ($odd)
    case "liditest.odd" return pm-liditest-web:transform($xml, $parameters)
    default return pm-liditest-web:transform($xml, $parameters)
            
    
};
            


declare variable $pm-config:print-transform := function($xml as node()*, $parameters as map(*)?, $odd as xs:string?) {
    switch ($odd)
    case "liditest.odd" return pm-liditest-print:transform($xml, $parameters)
    default return pm-liditest-print:transform($xml, $parameters)
            
    
};
            


declare variable $pm-config:latex-transform := function($xml as node()*, $parameters as map(*)?, $odd as xs:string?) {
    switch ($odd)
    case "liditest.odd" return pm-liditest-latex:transform($xml, $parameters)
    default return pm-liditest-latex:transform($xml, $parameters)
            
    
};
            


declare variable $pm-config:epub-transform := function($xml as node()*, $parameters as map(*)?, $odd as xs:string?) {
    switch ($odd)
    case "liditest.odd" return pm-liditest-epub:transform($xml, $parameters)
    default return pm-liditest-epub:transform($xml, $parameters)
            
    
};
            


declare variable $pm-config:fo-transform := function($xml as node()*, $parameters as map(*)?, $odd as xs:string?) {
    switch ($odd)
    case "liditest.odd" return pm-liditest-fo:transform($xml, $parameters)
    default return pm-liditest-fo:transform($xml, $parameters)
            
    
};
            


declare variable $pm-config:tei-transform := function($xml as node()*, $parameters as map(*)?, $odd as xs:string?) {
    switch ($odd)
    case "docx.odd" return pm-docx-tei:transform($xml, $parameters)
    default return error(QName("http://www.tei-c.org/tei-simple/pm-config", "error"), "No default ODD found for output mode tei")
            
    
};
            
    