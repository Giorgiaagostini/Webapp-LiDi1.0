(:~

    Transformation module generated from TEI ODD extensions for processing models.
    ODD: /db/apps/LiDi/resources/odd/liditest.odd
 :)
xquery version "3.1";

module namespace model="http://www.tei-c.org/pm/models/liditest/latex";

declare default element namespace "http://www.tei-c.org/ns/1.0";

declare namespace xhtml='http://www.w3.org/1999/xhtml';

declare namespace mei='http://www.music-encoding.org/ns/mei';

declare namespace pb='http://teipublisher.com/1.0';

import module namespace css="http://www.tei-c.org/tei-simple/xquery/css";

import module namespace latex="http://www.tei-c.org/tei-simple/xquery/functions/latex";

import module namespace global="http://www.tei-c.org/tei-simple/config" at "../modules/config.xqm";

(: generated template function for element spec: ptr :)
declare %private function model:template-ptr2($config as map(*), $node as node()*, $params as map(*)) {
    <t xmlns=""><pb-mei url="{$config?apply-children($config, $node, $params?url)}" player="player">
                              <pb-option name="appXPath" on="./rdg[contains(@label, 'original')]" off="">Original Clefs</pb-option>
                              </pb-mei></t>/*
};
(: generated template function for element spec: formula :)
declare %private function model:template-formula2($config as map(*), $node as node()*, $params as map(*)) {
    ``[\begin{equation}`{string-join($config?apply-children($config, $node, $params?content))}`\end{equation}]``
};
(: generated template function for element spec: formula :)
declare %private function model:template-formula3($config as map(*), $node as node()*, $params as map(*)) {
    ``[\begin{math}`{string-join($config?apply-children($config, $node, $params?content))}`\end{math}]``
};
(: generated template function for element spec: graphic :)
declare %private function model:template-graphic($config as map(*), $node as node()*, $params as map(*)) {
    <t xmlns=""><pb-facs-link facs="{$config?apply-children($config, $node, $params?url)}" emit="transcription"/></t>/*
};
(: generated template function for element spec: mei:mdiv :)
declare %private function model:template-mei_mdiv($config as map(*), $node as node()*, $params as map(*)) {
    <t xmlns=""><pb-mei player="player" data="{$config?apply-children($config, $node, $params?data)}"/></t>/*
};
(: generated template function for element spec: encodingDesc :)
declare %private function model:template-encodingDesc2($config as map(*), $node as node()*, $params as map(*)) {
    <t xmlns=""><div><h4>About the project</h4><div>{$config?apply-children($config, $node, $params?content)}</div></div></t>/*
};
(: generated template function for element spec: sourceDesc :)
declare %private function model:template-sourceDesc($config as map(*), $node as node()*, $params as map(*)) {
    <t xmlns=""><div><h4>Repository</h4><div>{$config?apply-children($config, $node, $params?content)}</div></div></t>/*
};
(: generated template function for element spec: msDesc :)
declare %private function model:template-msDesc($config as map(*), $node as node()*, $params as map(*)) {
    <t xmlns=""><p>
  <span>{$config?apply-children($config, $node, $params?settlement)}</span>,
  <span>{$config?apply-children($config, $node, $params?repository)}</span>, 
  <span>{$config?apply-children($config, $node, $params?msid)}</span></p><p><span>{$config?apply-children($config, $node, $params?mscont)}</span>
</p><p><span><h4>Physical description:</h4>{$config?apply-children($config, $node, $params?desc)}</span>
</p></t>/*
};
(: generated template function for element spec: seriesStmt :)
declare %private function model:template-seriesStmt($config as map(*), $node as node()*, $params as map(*)) {
    <t xmlns=""><div><h4>Source</h4>
  <div>{$config?apply-children($config, $node, $params?title)}, {$config?apply-children($config, $node, $params?vol)}, {$config?apply-children($config, $node, $params?book)}</div>
</div></t>/*
};
(: generated template function for element spec: availability :)
declare %private function model:template-availability($config as map(*), $node as node()*, $params as map(*)) {
    <t xmlns=""><p>Licence <small>(document XML)</small>:{$config?apply-children($config, $node, $params?content)}</p></t>/*
};
(:~

    Main entry point for the transformation.
    
 :)
declare function model:transform($options as map(*), $input as node()*) {
        
    let $config :=
        map:merge(($options,
            map {
                "output": ["latex"],
                "odd": "/db/apps/LiDi/resources/odd/liditest.odd",
                "apply": model:apply#2,
                "apply-children": model:apply-children#3
            }
        ))
    let $config := latex:init($config, $input)
    
    return (
        
        let $output := model:apply($config, $input)
        return
            latex:finish($config, $output)
    )
};

declare function model:apply($config as map(*), $input as node()*) {
        let $parameters := 
        if (exists($config?parameters)) then $config?parameters else map {}
        let $mode := 
        if (exists($config?mode)) then $config?mode else ()
        let $trackIds := 
        $parameters?track-ids
        let $get := 
        model:source($parameters, ?)
    return
    $input !         (
            let $node := 
                .
            return
                            typeswitch(.)
                    case element(licence) return
                        if ($parameters?mode='commentary') then
                            latex:link($config, ., ("tei-licence1", css:map-rend-to-class(.)), ., @target, map {})
                        else
                            latex:omit($config, ., ("tei-licence2", css:map-rend-to-class(.)), .)
                    case element(listBibl) return
                        if (bibl) then
                            latex:list($config, ., ("tei-listBibl1", css:map-rend-to-class(.)), ., ())
                        else
                            latex:block($config, ., ("tei-listBibl2", css:map-rend-to-class(.)), .)
                    case element(castItem) return
                        (: Insert item, rendered as described in parent list rendition. :)
                        latex:listItem($config, ., ("tei-castItem", css:map-rend-to-class(.)), ., ())
                    case element(item) return
                        latex:listItem($config, ., ("tei-item", css:map-rend-to-class(.)), ., ())
                    case element(teiHeader) return
                        latex:metadata($config, ., ("tei-teiHeader1", css:map-rend-to-class(.)), .)
                    case element(figure) return
                        latex:block($config, ., ("tei-figure", css:map-rend-to-class(.)), .)
                    case element(supplied) return
                        if (parent::choice) then
                            latex:inline($config, ., ("tei-supplied1", css:map-rend-to-class(.)), .)
                        else
                            if (@reason='damage') then
                                latex:inline($config, ., ("tei-supplied2", css:map-rend-to-class(.)), .)
                            else
                                if (@reason='illegible' or not(@reason)) then
                                    latex:inline($config, ., ("tei-supplied3", css:map-rend-to-class(.)), .)
                                else
                                    if (@reason='omitted') then
                                        latex:inline($config, ., ("tei-supplied4", css:map-rend-to-class(.)), .)
                                    else
                                        latex:inline($config, ., ("tei-supplied5", css:map-rend-to-class(.)), .)
                    case element(g) return
                        if (not(text())) then
                            latex:glyph($config, ., ("tei-g1", css:map-rend-to-class(.)), .)
                        else
                            latex:inline($config, ., ("tei-g2", css:map-rend-to-class(.)), .)
                    case element(author) return
                        if ($parameters?mode='commentary') then
                            latex:block($config, ., ("tei-author1", css:map-rend-to-class(.)), .)
                        else
                            if (ancestor::teiHeader) then
                                latex:block($config, ., ("tei-author3", css:map-rend-to-class(.)), .)
                            else
                                (: More than one model without predicate found for ident author. Choosing first one. :)
                                latex:block($config, ., ("tei-author2", css:map-rend-to-class(.)), id (substring-after(@ref, '#'), doc("/db/apps/LiDi/data/bibl.xml")))
                    case element(castList) return
                        if (child::*) then
                            latex:list($config, ., css:get-rendition(., ("tei-castList", css:map-rend-to-class(.))), castItem, ())
                        else
                            $config?apply($config, ./node())
                    case element(l) return
                        latex:block($config, ., css:get-rendition(., ("tei-l", css:map-rend-to-class(.))), .)
                    case element(ptr) return
                        if (@target) then
                            latex:inline($config, ., ("tei-ptr1", css:map-rend-to-class(.)), .)
                        else
                            if (parent::notatedMusic) then
                                (: Load and display external MEI :)
                                let $params := 
                                    map {
                                        "url": @target,
                                        "content": .
                                    }

                                                                let $content := 
                                    model:template-ptr2($config, ., $params)
                                return
                                                                latex:pass-through(map:merge(($config, map:entry("template", true()))), ., ("tei-ptr2", css:map-rend-to-class(.)), $content)
                            else
                                $config?apply($config, ./node())
                    case element(closer) return
                        latex:block($config, ., ("tei-closer", css:map-rend-to-class(.)), .)
                    case element(signed) return
                        if (parent::closer) then
                            latex:block($config, ., ("tei-signed1", css:map-rend-to-class(.)), .)
                        else
                            latex:inline($config, ., ("tei-signed2", css:map-rend-to-class(.)), .)
                    case element(p) return
                        latex:paragraph($config, ., css:get-rendition(., ("tei-p2", css:map-rend-to-class(.))), .)
                    case element(list) return
                        latex:list($config, ., css:get-rendition(., ("tei-list", css:map-rend-to-class(.))), item, ())
                    case element(q) return
                        if (l) then
                            latex:block($config, ., css:get-rendition(., ("tei-q1", css:map-rend-to-class(.))), .)
                        else
                            if (ancestor::p or ancestor::cell) then
                                latex:inline($config, ., css:get-rendition(., ("tei-q2", css:map-rend-to-class(.))), .)
                            else
                                latex:block($config, ., css:get-rendition(., ("tei-q3", css:map-rend-to-class(.))), .)
                    case element(pb) return
                        (: No function found for behavior: webcomponent :)
                        $config?apply($config, ./node())
                    case element(epigraph) return
                        latex:block($config, ., ("tei-epigraph", css:map-rend-to-class(.)), .)
                    case element(lb) return
                        latex:break($config, ., css:get-rendition(., ("tei-lb1", css:map-rend-to-class(.))), ., 'line', @n)
                    case element(docTitle) return
                        latex:block($config, ., css:get-rendition(., ("tei-docTitle", css:map-rend-to-class(.))), .)
                    case element(w) return
                        latex:inline($config, ., ("tei-w", css:map-rend-to-class(.)), .)
                    case element(TEI) return
                        latex:document($config, ., ("tei-TEI", css:map-rend-to-class(.)), .)
                    case element(anchor) return
                        latex:anchor($config, ., ("tei-anchor", css:map-rend-to-class(.)), ., @xml:id)
                    case element(titlePage) return
                        latex:block($config, ., css:get-rendition(., ("tei-titlePage", css:map-rend-to-class(.))), .)
                    case element(stage) return
                        latex:block($config, ., ("tei-stage", css:map-rend-to-class(.)), .)
                    case element(lg) return
                        latex:block($config, ., ("tei-lg", css:map-rend-to-class(.)), .)
                    case element(front) return
                        latex:block($config, ., ("tei-front", css:map-rend-to-class(.)), .)
                    case element(formula) return
                        if (@rendition='simple:display') then
                            latex:block($config, ., ("tei-formula1", css:map-rend-to-class(.)), .)
                        else
                            if (@rend="display") then
                                let $params := 
                                    map {
                                        "content": string()
                                    }

                                                                let $content := 
                                    model:template-formula2($config, ., $params)
                                return
                                                                latex:inline(map:merge(($config, map:entry("template", true()))), ., ("tei-formula2", css:map-rend-to-class(.)), $content)
                            else
                                if (@rend='display') then
                                    (: No function found for behavior: webcomponent :)
                                    $config?apply($config, ./node())
                                else
                                    (: More than one model without predicate found for ident formula. Choosing first one. :)
                                    let $params := 
                                        map {
                                            "content": string()
                                        }

                                                                        let $content := 
                                        model:template-formula3($config, ., $params)
                                    return
                                                                        latex:inline(map:merge(($config, map:entry("template", true()))), ., ("tei-formula3", css:map-rend-to-class(.)), $content)
                    case element(publicationStmt) return
                        if ($parameters?mode='commentary') then
                            latex:block($config, ., ("tei-publicationStmt1", css:map-rend-to-class(.)), .)
                        else
                            latex:omit($config, ., ("tei-publicationStmt3", css:map-rend-to-class(.)), .)
                    case element(choice) return
                        if (sic and corr) then
                            latex:alternate($config, ., ("tei-choice1", css:map-rend-to-class(.)), ., corr[1], sic[1])
                        else
                            if (abbr and expan) then
                                latex:alternate($config, ., ("tei-choice2", css:map-rend-to-class(.)), ., expan[1], abbr[1])
                            else
                                if (orig and reg) then
                                    latex:alternate($config, ., ("tei-choice3", css:map-rend-to-class(.)), ., reg[1], orig[1])
                                else
                                    $config?apply($config, ./node())
                    case element(role) return
                        latex:block($config, ., ("tei-role", css:map-rend-to-class(.)), .)
                    case element(hi) return
                        latex:inline($config, ., css:get-rendition(., ("tei-hi", css:map-rend-to-class(.))), .)
                    case element(note) return
                        if (@place="margin-right") then
                            latex:note($config, ., ("tei-note", css:map-rend-to-class(.)), ., "margin", ())
                        else
                            $config?apply($config, ./node())
                    case element(code) return
                        latex:inline($config, ., ("tei-code", css:map-rend-to-class(.)), .)
                    case element(postscript) return
                        latex:block($config, ., ("tei-postscript", css:map-rend-to-class(.)), .)
                    case element(dateline) return
                        latex:block($config, ., ("tei-dateline", css:map-rend-to-class(.)), .)
                    case element(back) return
                        latex:block($config, ., ("tei-back", css:map-rend-to-class(.)), .)
                    case element(edition) return
                        if (ancestor::teiHeader) then
                            latex:block($config, ., ("tei-edition", css:map-rend-to-class(.)), .)
                        else
                            $config?apply($config, ./node())
                    case element(del) return
                        latex:inline($config, ., ("tei-del", css:map-rend-to-class(.)), .)
                    case element(cell) return
                        (: Insert table cell. :)
                        latex:cell($config, ., ("tei-cell", css:map-rend-to-class(.)), ., ())
                    case element(trailer) return
                        latex:block($config, ., ("tei-trailer", css:map-rend-to-class(.)), .)
                    case element(div) return
                        if (@type='title_page') then
                            latex:block($config, ., ("tei-div1", css:map-rend-to-class(.)), .)
                        else
                            if (parent::body or parent::front or parent::back) then
                                latex:section($config, ., ("tei-div2", css:map-rend-to-class(.)), .)
                            else
                                latex:block($config, ., ("tei-div3", css:map-rend-to-class(.)), .)
                    case element(graphic) return
                        let $params := 
                            map {
                                "url": @url,
                                "content": .
                            }

                                                let $content := 
                            model:template-graphic($config, ., $params)
                        return
                                                latex:inline(map:merge(($config, map:entry("template", true()))), ., ("tei-graphic1", css:map-rend-to-class(.)), $content)
                    case element(ref) return
                        if ($parameters?mode='commentary') then
                            latex:link($config, ., ("tei-ref1", css:map-rend-to-class(.)), @target, @target, map {})
                        else
                            if (@target) then
                                latex:link($config, ., ("tei-ref2", css:map-rend-to-class(.)), ., @target, map {})
                            else
                                if (not(node())) then
                                    latex:link($config, ., ("tei-ref3", css:map-rend-to-class(.)), @target, @target, map {})
                                else
                                    latex:inline($config, ., ("tei-ref4", css:map-rend-to-class(.)), .)
                    case element(titlePart) return
                        latex:block($config, ., css:get-rendition(., ("tei-titlePart", css:map-rend-to-class(.))), .)
                    case element(ab) return
                        latex:inline($config, ., ("tei-ab1", css:map-rend-to-class(.)), .)
                    case element(add) return
                        latex:inline($config, ., ("tei-add", css:map-rend-to-class(.)), .)
                    case element(revisionDesc) return
                        latex:omit($config, ., ("tei-revisionDesc", css:map-rend-to-class(.)), .)
                    case element(head) return
                        latex:inline($config, ., ("tei-head", css:map-rend-to-class(.)), .)
                    case element(roleDesc) return
                        latex:block($config, ., ("tei-roleDesc", css:map-rend-to-class(.)), .)
                    case element(opener) return
                        latex:block($config, ., ("tei-opener", css:map-rend-to-class(.)), .)
                    case element(speaker) return
                        latex:block($config, ., ("tei-speaker", css:map-rend-to-class(.)), .)
                    case element(time) return
                        latex:inline($config, ., ("tei-time", css:map-rend-to-class(.)), .)
                    case element(castGroup) return
                        if (child::*) then
                            (: Insert list. :)
                            latex:list($config, ., ("tei-castGroup", css:map-rend-to-class(.)), castItem|castGroup, ())
                        else
                            $config?apply($config, ./node())
                    case element(imprimatur) return
                        latex:block($config, ., ("tei-imprimatur", css:map-rend-to-class(.)), .)
                    case element(bibl) return
                        if (ancestor::body) then
                            latex:alternate($config, ., ("tei-bibl", css:map-rend-to-class(.)), ., ., id (substring-after(@ref, '#'), doc("/db/apps/LiDi/data/bibl.xml")))
                        else
                            $config?apply($config, ./node())
                    case element(unclear) return
                        latex:inline($config, ., ("tei-unclear", css:map-rend-to-class(.)), .)
                    case element(salute) return
                        if (parent::closer) then
                            latex:inline($config, ., ("tei-salute1", css:map-rend-to-class(.)), .)
                        else
                            latex:block($config, ., ("tei-salute2", css:map-rend-to-class(.)), .)
                    case element(title) return
                        if (parent::titleStmt/parent::fileDesc) then
                            (
                                if (preceding-sibling::title) then
                                    latex:text($config, ., ("tei-title1", css:map-rend-to-class(.)), ' — ')
                                else
                                    (),
                                latex:inline($config, ., ("tei-title2", css:map-rend-to-class(.)), .)
                            )

                        else
                            if ($parameters?header='short') then
                                latex:heading($config, ., ("tei-title5", css:map-rend-to-class(.)), ., 5)
                            else
                                if (not(@level) and parent::bibl) then
                                    latex:inline($config, ., ("tei-title6", css:map-rend-to-class(.)), .)
                                else
                                    if (@level='m' or not(@level)) then
                                        (
                                            latex:inline($config, ., ("tei-title7", css:map-rend-to-class(.)), .),
                                            if (ancestor::biblFull) then
                                                latex:text($config, ., ("tei-title8", css:map-rend-to-class(.)), ', ')
                                            else
                                                ()
                                        )

                                    else
                                        if (@level='s' or @level='j') then
                                            (
                                                latex:inline($config, ., ("tei-title9", css:map-rend-to-class(.)), .),
                                                if (following-sibling::* and     (  ancestor::biblFull)) then
                                                    latex:text($config, ., ("tei-title10", css:map-rend-to-class(.)), ', ')
                                                else
                                                    ()
                                            )

                                        else
                                            if (@level='u' or @level='a') then
                                                (
                                                    latex:inline($config, ., ("tei-title11", css:map-rend-to-class(.)), .),
                                                    if (following-sibling::* and     (    ancestor::biblFull)) then
                                                        latex:text($config, ., ("tei-title12", css:map-rend-to-class(.)), '. ')
                                                    else
                                                        ()
                                                )

                                            else
                                                (: More than one model without predicate found for ident title. Choosing first one. :)
                                                (
                                                    latex:inline($config, ., ("tei-title3", css:map-rend-to-class(.)), id (substring-after(@ref, '#'), doc("/db/apps/LiDi/data/bibl.xml"))),
                                                    latex:link($config, ., ("tei-title4", css:map-rend-to-class(.)), ., @sameAs, map {})
                                                )

                    case element(date) return
                        latex:inline($config, ., ("tei-date2", css:map-rend-to-class(.)), .)
                    case element(argument) return
                        latex:block($config, ., ("tei-argument", css:map-rend-to-class(.)), .)
                    case element(corr) return
                        if (parent::choice and count(parent::*/*) gt 1) then
                            (: simple inline, if in parent choice. :)
                            latex:inline($config, ., ("tei-corr1", css:map-rend-to-class(.)), .)
                        else
                            latex:inline($config, ., ("tei-corr2", css:map-rend-to-class(.)), .)
                    case element(foreign) return
                        latex:inline($config, ., ("tei-foreign", css:map-rend-to-class(.)), .)
                    case element(mei:mdiv) return
                        (: Single MEI mdiv needs to be wrapped to create complete MEI document :)
                        let $params := 
                            map {
                                "data": let $title := root($parameters?root)//titleStmt/title let $data :=   <mei xmlns="http://www.music-encoding.org/ns/mei" meiversion="4.0.0">     <meiHead>         <fileDesc>             <titleStmt>                 <title></title>             </titleStmt>             <pubStmt></pubStmt>         </fileDesc>     </meiHead>     <music>         <body>{.}</body>     </music>   </mei> return   serialize($data),
                                "content": .
                            }

                                                let $content := 
                            model:template-mei_mdiv($config, ., $params)
                        return
                                                latex:pass-through(map:merge(($config, map:entry("template", true()))), ., ("tei-mei_mdiv", css:map-rend-to-class(.)), $content)
                    case element(cit) return
                        if (child::quote and child::bibl) then
                            (: Insert citation :)
                            latex:cit($config, ., ("tei-cit", css:map-rend-to-class(.)), ., ())
                        else
                            $config?apply($config, ./node())
                    case element(titleStmt) return
                        if ($parameters?mode='commentary') then
                            latex:block($config, ., ("tei-titleStmt1", css:map-rend-to-class(.)), .)
                        else
                            if ($parameters?mode='title') then
                                latex:heading($config, ., ("tei-titleStmt4", css:map-rend-to-class(.)), title[not(@type)], 5)
                            else
                                (: No function found for behavior: meta :)
                                $config?apply($config, ./node())
                    case element(fileDesc) return
                        if ($parameters?mode='commentary') then
                            latex:block($config, ., ("tei-fileDesc1", css:map-rend-to-class(.)), .)
                        else
                            if ($parameters?header='short') then
                                (
                                    (: Dati documento nella homepage :)
                                    latex:block($config, ., ("tei-fileDesc2", "header-short", css:map-rend-to-class(.)), titleStmt),
                                    latex:block($config, ., ("tei-fileDesc3", "header-short", css:map-rend-to-class(.)), /seriesStmt/title | (/seriesStmt/biblScope[position()=1]/@unit | /seriesStmt/biblScope[position()=1]/@n)),
                                    latex:block($config, ., ("tei-fileDesc4", "header-short", css:map-rend-to-class(.)), //msIdentifier/repository),
                                    (: Output abstract :)
                                    latex:block($config, ., ("tei-fileDesc5", "sample-description", css:map-rend-to-class(.)), //msContents/ab)
                                )

                            else
                                latex:title($config, ., ("tei-fileDesc6", css:map-rend-to-class(.)), titleStmt)
                    case element(sic) return
                        if (parent::choice and count(parent::*/*) gt 1) then
                            latex:inline($config, ., ("tei-sic1", css:map-rend-to-class(.)), .)
                        else
                            latex:inline($config, ., ("tei-sic2", css:map-rend-to-class(.)), .)
                    case element(spGrp) return
                        latex:block($config, ., ("tei-spGrp", css:map-rend-to-class(.)), .)
                    case element(body) return
                        (
                            latex:index($config, ., ("tei-body1", css:map-rend-to-class(.)), ., 'toc'),
                            latex:block($config, ., ("tei-body2", css:map-rend-to-class(.)), .)
                        )

                    case element(fw) return
                        if (@type="running-head") then
                            latex:block($config, ., ("tei-fw1", css:map-rend-to-class(.)), .)
                        else
                            if (@type="page-number") then
                                latex:block($config, ., ("tei-fw2", css:map-rend-to-class(.)), .)
                            else
                                if (ancestor::p or ancestor::ab) then
                                    latex:inline($config, ., ("tei-fw3", css:map-rend-to-class(.)), .)
                                else
                                    latex:block($config, ., ("tei-fw4", css:map-rend-to-class(.)), .)
                    case element(encodingDesc) return
                        if ($parameters?header='short') then
                            latex:omit($config, ., ("tei-encodingDesc1", css:map-rend-to-class(.)), .)
                        else
                            if ($parameters?mode='commentary') then
                                let $params := 
                                    map {
                                        "content": .
                                    }

                                                                let $content := 
                                    model:template-encodingDesc2($config, ., $params)
                                return
                                                                latex:block(map:merge(($config, map:entry("template", true()))), ., ("tei-encodingDesc2", css:map-rend-to-class(.)), $content)
                            else
                                latex:inline($config, ., ("tei-encodingDesc3", css:map-rend-to-class(.)), .)
                    case element(quote) return
                        latex:alternate($config, ., ("tei-quote1", css:map-rend-to-class(.)), ., ., id (substring-after(@ref, '#'), doc("/db/apps/LiDi/data/bibl.xml")))
                    case element(gap) return
                        if (desc) then
                            latex:inline($config, ., ("tei-gap1", css:map-rend-to-class(.)), .)
                        else
                            if (@extent) then
                                latex:inline($config, ., ("tei-gap2", css:map-rend-to-class(.)), @extent)
                            else
                                latex:inline($config, ., ("tei-gap3", css:map-rend-to-class(.)), .)
                    case element(seg) return
                        (
                            if (@source) then
                                latex:link($config, ., ("tei-seg", css:map-rend-to-class(.)), ., @source, map {})
                            else
                                ()
                        )

                    case element(notatedMusic) return
                        latex:figure($config, ., ("tei-notatedMusic", css:map-rend-to-class(.)), (ptr, mei:mdiv), label)
                    case element(profileDesc) return
                        latex:omit($config, ., ("tei-profileDesc", css:map-rend-to-class(.)), .)
                    case element(row) return
                        if (@role='label') then
                            latex:row($config, ., ("tei-row1", css:map-rend-to-class(.)), .)
                        else
                            (: Insert table row. :)
                            latex:row($config, ., ("tei-row2", css:map-rend-to-class(.)), .)
                    case element(text) return
                        latex:body($config, ., ("tei-text", css:map-rend-to-class(.)), .)
                    case element(floatingText) return
                        latex:block($config, ., ("tei-floatingText", css:map-rend-to-class(.)), .)
                    case element(sp) return
                        latex:block($config, ., ("tei-sp", css:map-rend-to-class(.)), .)
                    case element(byline) return
                        latex:block($config, ., ("tei-byline", css:map-rend-to-class(.)), .)
                    case element(table) return
                        latex:table($config, ., ("tei-table", css:map-rend-to-class(.)), ., map {})
                    case element(group) return
                        latex:block($config, ., ("tei-group", css:map-rend-to-class(.)), .)
                    case element(cb) return
                        latex:break($config, ., ("tei-cb", css:map-rend-to-class(.)), ., 'column', @n)
                    case element(persName) return
                        if (ancestor::listPerson) then
                            latex:block($config, ., ("tei-persName1", css:map-rend-to-class(.)), .)
                        else
                            $config?apply($config, ./node())
                    case element(placeName) return
                        latex:alternate($config, ., ("tei-placeName", css:map-rend-to-class(.)), ., ., id (substring-after(@ref, '#'), doc("/db/apps/LiDi/data/place.xml")))
                    case element(person) return
                        (
                            latex:link($config, ., ("tei-person", css:map-rend-to-class(.)), persName, @sameAs, map {})
                        )

                    case element(place) return
                        (
                            latex:block($config, ., ("tei-place1", css:map-rend-to-class(.)), placeName),
                            latex:link($config, ., ("tei-place2", css:map-rend-to-class(.)), @sameAs, @sameAs, map {})
                        )

                    case element(biblScope) return
                        if (parent::bibl) then
                            latex:inline($config, ., ("tei-biblScope", css:map-rend-to-class(.)), .)
                        else
                            $config?apply($config, ./node())
                    case element(citedRange) return
                        latex:inline($config, ., ("tei-citedRange", css:map-rend-to-class(.)), .)
                    case element(sponsor) return
                        latex:omit($config, ., ("tei-sponsor", css:map-rend-to-class(.)), .)
                    case element(editionStmt) return
                        if ($parameters?mode='commentary') then
                            latex:block($config, ., ("tei-editionStmt", css:map-rend-to-class(.)), .)
                        else
                            $config?apply($config, ./node())
                    case element(respStmt) return
                        latex:omit($config, ., ("tei-respStmt", css:map-rend-to-class(.)), .)
                    case element(principal) return
                        if ($parameters?mode='commentary') then
                            latex:block($config, ., ("tei-principal", css:map-rend-to-class(.)), .)
                        else
                            $config?apply($config, ./node())
                    case element(funder) return
                        latex:omit($config, ., ("tei-funder", css:map-rend-to-class(.)), .)
                    case element(sourceDesc) return
                        if ($parameters?mode='commentary') then
                            let $params := 
                                map {
                                    "content": .
                                }

                                                        let $content := 
                                model:template-sourceDesc($config, ., $params)
                            return
                                                        latex:block(map:merge(($config, map:entry("template", true()))), ., ("tei-sourceDesc", css:map-rend-to-class(.)), $content)
                        else
                            $config?apply($config, ./node())
                    case element(msDesc) return
                        if ($parameters?mode='commentary') then
                            let $params := 
                                map {
                                    "settlement": msIdentifier/settlement,
                                    "repository": msIdentifier/repository,
                                    "msid": msIdentifier/idno,
                                    "mscont": msContents/ab,
                                    "desc": physDesc/ab,
                                    "content": .
                                }

                                                        let $content := 
                                model:template-msDesc($config, ., $params)
                            return
                                                        latex:block(map:merge(($config, map:entry("template", true()))), ., ("tei-msDesc1", css:map-rend-to-class(.)), $content)
                        else
                            latex:inline($config, ., ("tei-msDesc2", css:map-rend-to-class(.)), .)
                    case element(seriesStmt) return
                        if ($parameters?mode='commentary') then
                            let $params := 
                                map {
                                    "title": title,
                                    "vol": //biblScope[@unit='volume']/@n,
                                    "book": //biblScope[@unit='book']/@n,
                                    "content": .
                                }

                                                        let $content := 
                                model:template-seriesStmt($config, ., $params)
                            return
                                                        latex:block(map:merge(($config, map:entry("template", true()))), ., ("tei-seriesStmt", css:map-rend-to-class(.)), $content)
                        else
                            $config?apply($config, ./node())
                    case element(editorialDecl) return
                        if ($parameters?mode='commentary') then
                            latex:block($config, ., ("tei-editorialDecl1", css:map-rend-to-class(.)), .)
                        else
                            if ($parameters?header='short') then
                                latex:omit($config, ., ("tei-editorialDecl2", css:map-rend-to-class(.)), .)
                            else
                                $config?apply($config, ./node())
                    case element(availability) return
                        if ($parameters?mode='commentary') then
                            let $params := 
                                map {
                                    "content": .
                                }

                                                        let $content := 
                                model:template-availability($config, ., $params)
                            return
                                                        latex:block(map:merge(($config, map:entry("template", true()))), ., ("tei-availability", css:map-rend-to-class(.)), $content)
                        else
                            $config?apply($config, ./node())
                    case element(figDesc) return
                        (
                            latex:inline($config, ., ("tei-figDesc", "<span", "class="icon">✏️</span>", css:map-rend-to-class(.)), .)
                        )

                    case element() return
                        if (namespace-uri(.) = 'http://www.tei-c.org/ns/1.0') then
                            $config?apply($config, ./node())
                        else
                            .
                    case text() | xs:anyAtomicType return
                        latex:escapeChars(.)
                    default return 
                        $config?apply($config, ./node())

        )

};

declare function model:apply-children($config as map(*), $node as element(), $content as item()*) {
        
    if ($config?template) then
        $content
    else
        $content ! (
            typeswitch(.)
                case element() return
                    if (. is $node) then
                        $config?apply($config, ./node())
                    else
                        $config?apply($config, .)
                default return
                    latex:escapeChars(.)
        )
};

declare function model:source($parameters as map(*), $elem as element()) {
        
    let $id := $elem/@exist:id
    return
        if ($id and $parameters?root) then
            util:node-by-id($parameters?root, $id)
        else
            $elem
};

declare function model:process-annotation($html, $context as node()) {
        
    let $classRegex := analyze-string($html/@class, '\s?annotation-([^\s]+)\s?')
    return
        if ($classRegex//fn:match) then (
            if ($html/@data-type) then
                ()
            else
                attribute data-type { ($classRegex//fn:group)[1]/string() },
            if ($html/@data-annotation) then
                ()
            else
                attribute data-annotation {
                    map:merge($context/@* ! map:entry(node-name(.), ./string()))
                    => serialize(map { "method": "json" })
                }
        ) else
            ()
                    
};

declare function model:map($html, $context as node(), $trackIds as item()?) {
        
    if ($trackIds) then
        for $node in $html
        return
            typeswitch ($node)
                case document-node() | comment() | processing-instruction() return 
                    $node
                case element() return
                    if ($node/@class = ("footnote")) then
                        if (local-name($node) = 'pb-popover') then
                            ()
                        else
                            element { node-name($node) }{
                                $node/@*,
                                $node/*[@class="fn-number"],
                                model:map($node/*[@class="fn-content"], $context, $trackIds)
                            }
                    else
                        element { node-name($node) }{
                            attribute data-tei { util:node-id($context) },
                            $node/@*,
                            model:process-annotation($node, $context),
                            $node/node()
                        }
                default return
                    <pb-anchor data-tei="{ util:node-id($context) }">{$node}</pb-anchor>
    else
        $html
                    
};

