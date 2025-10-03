import module namespace m='http://www.tei-c.org/pm/models/liditest/print' at 'liditest-print.xql';

declare variable $xml external;

declare variable $parameters external;

let $options := map {
    "styles": ["transform/liditest.css"],
    "collection": "/db/apps/LiDi/transform",
    "parameters": if (exists($parameters)) then $parameters else map {}
}
return m:transform($options, $xml)