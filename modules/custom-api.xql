xquery version "3.1";

(:~
 : This is the place to import your own XQuery modules for either:
 :
 : 1. custom API request handling functions
 : 2. custom templating functions to be called from one of the HTML templates
 :)
module namespace api="http://teipublisher.com/api/custom";

declare namespace tei="http://www.tei-c.org/ns/1.0";

import module namespace config="http://www.tei-c.org/tei-simple/config" at "config.xqm";

(: Add your own module imports here :)
import module namespace rutil="http://e-editiones.org/roaster/util";
import module namespace app="teipublisher.com/app" at "app.xql";
import module namespace sapi="http://teipublisher.com/api/search" at "lib/api/search.xql";

(:~
 : Keep this. This function does the actual lookup in the imported modules.
 :)
declare function api:lookup($name as xs:string, $arity as xs:integer) {
    try {
        function-lookup(xs:QName($name), $arity)
    } catch * {
        ()
    }
};

declare function api:get-place($request as map(*)) {
    let $q := normalize-space($request?parameters?query)
    let $hits := doc($config:data-root || "/LD015r_1-48.xml")//tei:placeName[@ref='#'||$q]
    return sapi:show-hits($request, $hits, $request?parameters?doc)
    (:  return map {
        'q' : '#' || $q,
        'realq' : $q,
        'res': $hits,
        'req': $request?parameters
    } :)
};

declare function api:places($request as map(*)) {
    let $search := normalize-space($request?parameters?search)
    let $letterParam := $request?parameters?category
    let $limit := $request?parameters?limit
    let $places :=
        if ($search and $search != '') then
            filter(
                doc($config:data-root || "/place.xml")//tei:listPlace/tei:place,
                function ($entry) {matches($entry, $search, 'i')}
            )
        else
            doc($config:data-root || "/place.xml")//tei:listPlace/tei:place
    
    
    let $sorted := sort($places,default-collation(), function($place) { lower-case(normalize-space($place/tei:placeName)) })
    
    let $letter := 
        if (count($places) < $limit) then 
            "Tutte"
        else if (not($letterParam) or $letterParam = '') then
            (:   substring($sorted[1], 1, 1) => upper-case() :)
            "Tutte"
        else
            $letterParam
    let $byLetter :=
        if ($letter = 'Tutte') then
            $sorted
        else
           filter($sorted, function($entry) {
                starts-with(lower-case(normalize-space($entry/tei:placeName)), lower-case($letter))
            })
    return
        map {
            "items": api:output-place($byLetter, $letter, $search),
            "categories":
                if (count($places) < $limit) then
                    []
                else array {
                    for $index in 1 to string-length('ABCDEFGHIJKLMNOPQRSTUVWXYZ')
                    let $alpha := substring('ABCDEFGHIJKLMNOPQRSTUVWXYZ', $index, 1)
                    let $hits := count(filter($sorted, function($entry) { starts-with(lower-case($entry/tei:placeName), lower-case($alpha))}))
                    where $hits > 0
                    return
                        map {
                            "category": $alpha,
                            "count": $hits
                        },
                    map {
                        "category": "Tutte",
                        "count": count($sorted)
                    }
                },
                "places": $places,
                "sorted": $sorted,
                "ids": $byLetter[1]
                
        }
};

declare function api:output-place($list, $category as xs:string, $search as xs:string?) {
    array {
        for $place in $list
        let $categoryParam := if ($category = "all") then substring($place, 1, 1) else $category
        let $params := "category=" || $categoryParam || "&amp;search=" || $search
(:        let $label := $place/@n/string() :)
        let $label := normalize-space($place/tei:placeName)
        let $sameAs := substring($place/@sameAs, 9)
        return
            <span class="place">
                <a href="get-place.html?p={$place/@xml:id}&amp;ext={fn:encode-for-uri($sameAs)}">{$label}</a>
            </span>
    }
};

(: 
 :  +{$extId}
            https://www.wikidata.org/wiki/Q5690
            https://pleiades.stoa.org/places/1332
        :)
        
declare function api:people($request as map(*)) {
    let $search := normalize-space($request?parameters?search)
    let $letterParam := $request?parameters?category
    let $limit := $request?parameters?limit
    let $places :=
        if ($search and $search != '') then
            filter(
                doc($config:data-root || "/people.xml")//tei:listPerson/tei:Person,
                function ($entry) {matches($entry, $search, 'i')}
            )
        else
            doc($config:data-root || "/place.xml")//tei:listPlace/tei:place
    
    
    let $sorted := sort($places,default-collation(), function($place) { lower-case(normalize-space($place/tei:placeName)) })
    
    let $letter := 
        if (count($places) < $limit) then 
            "Tutte"
        else if (not($letterParam) or $letterParam = '') then
            (:   substring($sorted[1], 1, 1) => upper-case() :)
            "Tutte"
        else
            $letterParam
    let $byLetter :=
        if ($letter = 'Tutte') then
            $sorted
        else
           filter($sorted, function($entry) {
                starts-with(lower-case(normalize-space($entry/tei:placeName)), lower-case($letter))
            })
    return
        map {
            "items": api:output-place($byLetter, $letter, $search),
            "categories":
                if (count($places) < $limit) then
                    []
                else array {
                    for $index in 1 to string-length('ABCDEFGHIJKLMNOPQRSTUVWXYZ')
                    let $alpha := substring('ABCDEFGHIJKLMNOPQRSTUVWXYZ', $index, 1)
                    let $hits := count(filter($sorted, function($entry) { starts-with(lower-case($entry/tei:placeName), lower-case($alpha))}))
                    where $hits > 0
                    return
                        map {
                            "category": $alpha,
                            "count": $hits
                        },
                    map {
                        "category": "Tutte",
                        "count": count($sorted)
                    }
                },
                "places": $places,
                "sorted": $sorted,
                "ids": $byLetter[1]
                
        }
};

declare function api:output-person($list, $category as xs:string, $search as xs:string?) {
    array {
        for $place in $list
        let $categoryParam := if ($category = "all") then substring($place, 1, 1) else $category
        let $params := "category=" || $categoryParam || "&amp;search=" || $search
(:        let $label := $place/@n/string() :)
        let $label := normalize-space($place/tei:placeName)
        return
            <span class="place">
                <a href="search.html?query={$place/@id}">{$label}</a>
            </span>
    }
};