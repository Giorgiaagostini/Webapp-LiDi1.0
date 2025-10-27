(:~

    Transformation module generated from TEI ODD extensions for processing models.
    ODD: /db/apps/LiDi/resources/odd/liditest.odd
 :)
xquery version "3.1";

module namespace model="http://www.tei-c.org/pm/models/liditest/web";

declare default element namespace "http://www.tei-c.org/ns/1.0";

declare namespace xhtml='http://www.w3.org/1999/xhtml';

declare namespace mei='http://www.music-encoding.org/ns/mei';

declare namespace pb='http://teipublisher.com/1.0';

import module namespace css="http://www.tei-c.org/tei-simple/xquery/css";

import module namespace html="http://www.tei-c.org/tei-simple/xquery/functions";

import module namespace global="http://www.tei-c.org/tei-simple/config" at "../modules/config.xqm";

(: generated template function for element spec: ptr :)
declare %private function model:template-ptr2($config as map(*), $node as node()*, $params as map(*)) {
    <t xmlns=""><pb-mei url="{$config?apply-children($config, $node, $params?url)}" player="player">
                              <pb-option name="appXPath" on="./rdg[contains(@label, 'original')]" off="">Original Clefs</pb-option>
                              </pb-mei></t>/*
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
    <t xmlns=""><div><h4>Informazioni sul progetto</h4><div>{$config?apply-children($config, $node, $params?content)}</div></div></t>/*
};
(: generated template function for element spec: seg :)
declare %private function model:template-seg($config as map(*), $node as node()*, $params as map(*)) {
    <t xmlns=""><a href="{$config?apply-children($config, $node, $params?uri)}" target="_blank">{$config?apply-children($config, $node, $params?content)}</a></t>/*
};
(: generated template function for element spec: msDesc :)
declare %private function model:template-msDesc($config as map(*), $node as node()*, $params as map(*)) {
    <t xmlns=""><p>
  <span>{$config?apply-children($config, $node, $params?settlement)}</span>,
  <span>{$config?apply-children($config, $node, $params?repository)}</span>, 
  <span>{$config?apply-children($config, $node, $params?msid)}</span></p><p><span>{$config?apply-children($config, $node, $params?mscont)}</span>
</p><p><span>{$config?apply-children($config, $node, $params?desc)}</span>
</p></t>/*
};
(: generated template function for element spec: seriesStmt :)
declare %private function model:template-seriesStmt($config as map(*), $node as node()*, $params as map(*)) {
    <t xmlns=""><div><h4>Fonte</h4>
  <div>{$config?apply-children($config, $node, $params?title)}, {$config?apply-children($config, $node, $params?vol)}, {$config?apply-children($config, $node, $params?book)}</div>
</div></t>/*
};
(: generated template function for element spec: availability :)
declare %private function model:template-availability($config as map(*), $node as node()*, $params as map(*)) {
    <t xmlns=""><p>Licenza(documento XML):{$config?apply-children($config, $node, $params?content)}</p></t>/*
};
(: generated template function for element spec: term :)
declare %private function model:template-term($config as map(*), $node as node()*, $params as map(*)) {
    <t xmlns=""><li>{$config?apply-children($config, $node, $params?content)}</li></t>/*
};
(: generated template function for element spec: classDecl :)
declare %private function model:template-classDecl($config as map(*), $node as node()*, $params as map(*)) {
    <t xmlns=""><div><h4>Sistema di classificazione delle immagini</h4><div>{$config?apply-children($config, $node, $params?content)}</div></div></t>/*
};
(:~

    Main entry point for the transformation.
    
 :)
declare function model:transform($options as map(*), $input as node()*) {
        
    let $config :=
        map:merge(($options,
            map {
                "output": ["web"],
                "odd": "/db/apps/LiDi/resources/odd/liditest.odd",
                "apply": model:apply#2,
                "apply-children": model:apply-children#3
            }
        ))
    
    return (
        html:prepare($config, $input),
    
        let $output := model:apply($config, $input)
        return
            html:finish($config, $output)
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
                            html:link($config, ., ("tei-licence1", css:map-rend-to-class(.)), ., @target, (), map {})                            => model:map($node, $trackIds)
                        else
                            html:omit($config, ., ("tei-licence2", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                    case element(listBibl) return
                        if (bibl) then
                            html:list($config, ., ("tei-listBibl1", css:map-rend-to-class(.)), ., ())                            => model:map($node, $trackIds)
                        else
                            html:block($config, ., ("tei-listBibl2", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                    case element(castItem) return
                        (: Insert item, rendered as described in parent list rendition. :)
                        html:listItem($config, ., ("tei-castItem", css:map-rend-to-class(.)), ., ())                        => model:map($node, $trackIds)
                    case element(item) return
                        html:listItem($config, ., ("tei-item", css:map-rend-to-class(.)), ., ())                        => model:map($node, $trackIds)
                    case element(teiHeader) return
                        if ($parameters?header='short') then
                            html:block($config, ., ("tei-teiHeader3", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            if ($parameters?mode='commentary') then
                                html:inline($config, ., ("tei-teiHeader4", css:map-rend-to-class(.)), .)                                => model:map($node, $trackIds)
                            else
                                html:metadata($config, ., ("tei-teiHeader5", css:map-rend-to-class(.)), .)                                => model:map($node, $trackIds)
                    case element(figure) return
                        html:figure($config, ., ("tei-figure", css:map-rend-to-class(.)), ., @figDesc)                        => model:map($node, $trackIds)
                    case element(supplied) return
                        if (parent::choice) then
                            html:inline($config, ., ("tei-supplied1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            if (@reason='damage') then
                                html:inline($config, ., ("tei-supplied2", css:map-rend-to-class(.)), .)                                => model:map($node, $trackIds)
                            else
                                if (@reason='illegible' or not(@reason)) then
                                    html:inline($config, ., ("tei-supplied3", css:map-rend-to-class(.)), .)                                    => model:map($node, $trackIds)
                                else
                                    if (@reason='omitted') then
                                        html:inline($config, ., ("tei-supplied4", css:map-rend-to-class(.)), .)                                        => model:map($node, $trackIds)
                                    else
                                        html:inline($config, ., ("tei-supplied5", css:map-rend-to-class(.)), .)                                        => model:map($node, $trackIds)
                    case element(g) return
                        if (not(text())) then
                            html:glyph($config, ., ("tei-g1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            html:inline($config, ., ("tei-g2", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                    case element(author) return
                        if ($parameters?mode='commentary') then
                            html:block($config, ., ("tei-author1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            if (parent::bibl) then
                                html:inline($config, ., ("tei-author2", css:map-rend-to-class(.)), id (substring-after(@ref, '#'), doc("/db/apps/LiDi/data/bibl.xml")))                                => model:map($node, $trackIds)
                            else
                                if (ancestor::teiHeader) then
                                    html:block($config, ., ("tei-author3", css:map-rend-to-class(.)), .)                                    => model:map($node, $trackIds)
                                else
                                    $config?apply($config, ./node())
                    case element(castList) return
                        if (child::*) then
                            html:list($config, ., css:get-rendition(., ("tei-castList", css:map-rend-to-class(.))), castItem, ())                            => model:map($node, $trackIds)
                        else
                            $config?apply($config, ./node())
                    case element(l) return
                        html:block($config, ., css:get-rendition(., ("tei-l", css:map-rend-to-class(.))), .)                        => model:map($node, $trackIds)
                    case element(ptr) return
                        html:link($config, ., ("tei-ptr1", css:map-rend-to-class(.)), "🔗", @target, (), map {})                        => model:map($node, $trackIds)
                    case element(closer) return
                        html:block($config, ., ("tei-closer", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(signed) return
                        if (parent::closer) then
                            html:block($config, ., ("tei-signed1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            html:inline($config, ., ("tei-signed2", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                    case element(p) return
                        html:paragraph($config, ., css:get-rendition(., ("tei-p2", css:map-rend-to-class(.))), .)                        => model:map($node, $trackIds)
                    case element(list) return
                        html:list($config, ., css:get-rendition(., ("tei-list", css:map-rend-to-class(.))), item, ())                        => model:map($node, $trackIds)
                    case element(q) return
                        if (l) then
                            html:block($config, ., css:get-rendition(., ("tei-q1", css:map-rend-to-class(.))), .)                            => model:map($node, $trackIds)
                        else
                            if (ancestor::p or ancestor::cell) then
                                html:inline($config, ., css:get-rendition(., ("tei-q2", css:map-rend-to-class(.))), .)                                => model:map($node, $trackIds)
                            else
                                html:block($config, ., css:get-rendition(., ("tei-q3", css:map-rend-to-class(.))), .)                                => model:map($node, $trackIds)
                    case element(pb) return
                        (
                            (: @facs :)
                            html:webcomponent($config, ., ("tei-pb1", css:map-rend-to-class(.)), ., 'pb-facs-link', map {"emit": 'transcription', "facs": let $d := substring-after(@facs, '#'), $f := id($d, root($parameters?root))/graphic[1]/@url return ``[`{$f}`/full/950,/0/default.jpg]``})                            => model:map($node, $trackIds),
                            html:break($config, ., css:get-rendition(., ("tei-pb2", css:map-rend-to-class(.))), ., 'page', if(@n) then concat(@n,' ') else '')                            => model:map($node, $trackIds)
                        )

                    case element(epigraph) return
                        html:block($config, ., ("tei-epigraph", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(lb) return
                        html:break($config, ., css:get-rendition(., ("tei-lb1", css:map-rend-to-class(.))), ., 'line', @n)                        => model:map($node, $trackIds)
                    case element(docTitle) return
                        html:block($config, ., css:get-rendition(., ("tei-docTitle", css:map-rend-to-class(.))), .)                        => model:map($node, $trackIds)
                    case element(w) return
                        html:inline($config, ., ("tei-w", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(TEI) return
                        html:document($config, ., ("tei-TEI", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(anchor) return
                        html:anchor($config, ., ("tei-anchor", css:map-rend-to-class(.)), ., @xml:id)                        => model:map($node, $trackIds)
                    case element(titlePage) return
                        html:block($config, ., css:get-rendition(., ("tei-titlePage", css:map-rend-to-class(.))), .)                        => model:map($node, $trackIds)
                    case element(stage) return
                        html:block($config, ., ("tei-stage", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(lg) return
                        html:block($config, ., ("tei-lg", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(front) return
                        html:block($config, ., ("tei-front", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(formula) return
                        if (@rendition='simple:display') then
                            html:block($config, ., ("tei-formula1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            if (@rend='display') then
                                html:webcomponent($config, ., ("tei-formula4", css:map-rend-to-class(.)), ., 'pb-formula', map {"display": true()})                                => model:map($node, $trackIds)
                            else
                                html:webcomponent($config, ., ("tei-formula5", css:map-rend-to-class(.)), ., 'pb-formula', map {})                                => model:map($node, $trackIds)
                    case element(publicationStmt) return
                        if ($parameters?mode='commentary') then
                            html:block($config, ., ("tei-publicationStmt1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            (: More than one model without predicate found for ident publicationStmt. Choosing first one. :)
                            html:block($config, ., ("tei-publicationStmt2", css:map-rend-to-class(.)), availability/licence)                            => model:map($node, $trackIds)
                    case element(choice) return
                        if (sic and corr) then
                            html:alternate($config, ., ("tei-choice1", css:map-rend-to-class(.)), ., corr[1], sic[1], map {})                            => model:map($node, $trackIds)
                        else
                            if (abbr and expan) then
                                html:alternate($config, ., ("tei-choice2", css:map-rend-to-class(.)), ., expan[1], abbr[1], map {})                                => model:map($node, $trackIds)
                            else
                                if (orig and reg) then
                                    html:alternate($config, ., ("tei-choice3", css:map-rend-to-class(.)), ., reg[1], orig[1], map {})                                    => model:map($node, $trackIds)
                                else
                                    $config?apply($config, ./node())
                    case element(role) return
                        html:block($config, ., ("tei-role", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(hi) return
                        html:inline($config, ., css:get-rendition(., ("tei-hi", css:map-rend-to-class(.))), .)                        => model:map($node, $trackIds)
                    case element(note) return
                        if (@place="margin-right" or @place="margin-left") then
                            html:note($config, ., ("tei-note", css:map-rend-to-class(.)), ., "margin", ())                            => model:map($node, $trackIds)
                        else
                            $config?apply($config, ./node())
                    case element(code) return
                        html:inline($config, ., ("tei-code", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(postscript) return
                        html:block($config, ., ("tei-postscript", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(dateline) return
                        html:block($config, ., ("tei-dateline", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(back) return
                        html:block($config, ., ("tei-back", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(edition) return
                        if (ancestor::teiHeader) then
                            html:block($config, ., ("tei-edition", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            $config?apply($config, ./node())
                    case element(del) return
                        html:inline($config, ., ("tei-del", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(cell) return
                        (: Insert table cell. :)
                        html:cell($config, ., ("tei-cell", css:map-rend-to-class(.)), ., ())                        => model:map($node, $trackIds)
                    case element(trailer) return
                        html:block($config, ., ("tei-trailer", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(div) return
                        if (@type='title_page') then
                            html:block($config, ., ("tei-div1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            if (parent::body or parent::front or parent::back) then
                                html:section($config, ., ("tei-div2", css:map-rend-to-class(.)), .)                                => model:map($node, $trackIds)
                            else
                                html:block($config, ., ("tei-div3", css:map-rend-to-class(.)), .)                                => model:map($node, $trackIds)
                    case element(graphic) return
                        let $params := 
                            map {
                                "url": @url,
                                "content": .
                            }

                                                let $content := 
                            model:template-graphic($config, ., $params)
                        return
                                                html:inline(map:merge(($config, map:entry("template", true()))), ., ("tei-graphic1", css:map-rend-to-class(.)), $content)                        => model:map($node, $trackIds)
                    case element(ref) return
                        if ($parameters?mode='commentary') then
                            html:link($config, ., ("tei-ref1", css:map-rend-to-class(.)), @target, @target, (), map {})                            => model:map($node, $trackIds)
                        else
                            if (@target) then
                                html:link($config, ., ("tei-ref2", css:map-rend-to-class(.)), ., @target, (), map {})                                => model:map($node, $trackIds)
                            else
                                if (not(node())) then
                                    html:link($config, ., ("tei-ref3", css:map-rend-to-class(.)), @target, @target, (), map {})                                    => model:map($node, $trackIds)
                                else
                                    html:inline($config, ., ("tei-ref4", css:map-rend-to-class(.)), .)                                    => model:map($node, $trackIds)
                    case element(titlePart) return
                        html:block($config, ., css:get-rendition(., ("tei-titlePart", css:map-rend-to-class(.))), .)                        => model:map($node, $trackIds)
                    case element(ab) return
                        html:inline($config, ., ("tei-ab1", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(add) return
                        html:inline($config, ., ("tei-add", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(revisionDesc) return
                        html:omit($config, ., ("tei-revisionDesc", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(head) return
                        html:inline($config, ., ("tei-head", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(roleDesc) return
                        html:block($config, ., ("tei-roleDesc", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(opener) return
                        html:block($config, ., ("tei-opener", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(speaker) return
                        html:block($config, ., ("tei-speaker", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(time) return
                        html:inline($config, ., ("tei-time", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(castGroup) return
                        if (child::*) then
                            (: Insert list. :)
                            html:list($config, ., ("tei-castGroup", css:map-rend-to-class(.)), castItem|castGroup, ())                            => model:map($node, $trackIds)
                        else
                            $config?apply($config, ./node())
                    case element(imprimatur) return
                        html:block($config, ., ("tei-imprimatur", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(bibl) return
                        if (ancestor::body) then
                            html:alternate($config, ., ("tei-bibl", css:map-rend-to-class(.)), ., ., id (substring-after(@source, '#'), doc("/db/apps/LiDi/data/bibl.xml")), map {})                            => model:map($node, $trackIds)
                        else
                            $config?apply($config, ./node())
                    case element(unclear) return
                        html:inline($config, ., ("tei-unclear", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(salute) return
                        if (parent::closer) then
                            html:inline($config, ., ("tei-salute1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            html:block($config, ., ("tei-salute2", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                    case element(title) return
                        if (parent::bibl) then
                            html:inline($config, ., ("tei-title1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            if (parent::titleStmt/parent::fileDesc) then
                                (
                                    if (preceding-sibling::title) then
                                        html:text($config, ., ("tei-title2", css:map-rend-to-class(.)), ' — ')                                        => model:map($node, $trackIds)
                                    else
                                        (),
                                    html:inline($config, ., ("tei-title3", css:map-rend-to-class(.)), .)                                    => model:map($node, $trackIds)
                                )

                            else
                                if ($parameters?header='short') then
                                    html:heading($config, ., ("tei-title6", css:map-rend-to-class(.)), ., 5)                                    => model:map($node, $trackIds)
                                else
                                    if (not(@level) and parent::bibl) then
                                        html:inline($config, ., ("tei-title7", css:map-rend-to-class(.)), .)                                        => model:map($node, $trackIds)
                                    else
                                        if (@level='m' or not(@level)) then
                                            (
                                                html:inline($config, ., ("tei-title8", css:map-rend-to-class(.)), .)                                                => model:map($node, $trackIds),
                                                if (ancestor::biblFull) then
                                                    html:text($config, ., ("tei-title9", css:map-rend-to-class(.)), ', ')                                                    => model:map($node, $trackIds)
                                                else
                                                    ()
                                            )

                                        else
                                            if (@level='s' or @level='j') then
                                                (
                                                    html:inline($config, ., ("tei-title10", css:map-rend-to-class(.)), .)                                                    => model:map($node, $trackIds),
                                                    if (following-sibling::* and     (  ancestor::biblFull)) then
                                                        html:text($config, ., ("tei-title11", css:map-rend-to-class(.)), ', ')                                                        => model:map($node, $trackIds)
                                                    else
                                                        ()
                                                )

                                            else
                                                if (@level='u' or @level='a') then
                                                    (
                                                        html:inline($config, ., ("tei-title12", css:map-rend-to-class(.)), .)                                                        => model:map($node, $trackIds),
                                                        if (following-sibling::* and     (    ancestor::biblFull)) then
                                                            html:text($config, ., ("tei-title13", css:map-rend-to-class(.)), '. ')                                                            => model:map($node, $trackIds)
                                                        else
                                                            ()
                                                    )

                                                else
                                                    (: More than one model without predicate found for ident title. Choosing first one. :)
                                                    (
                                                        html:inline($config, ., ("tei-title4", css:map-rend-to-class(.)), id (substring-after(@ref, '#'), doc("/db/apps/LiDi/data/bibl.xml")))                                                        => model:map($node, $trackIds),
                                                        html:link($config, ., ("tei-title5", css:map-rend-to-class(.)), ., @sameAs, (), map {})                                                        => model:map($node, $trackIds)
                                                    )

                    case element(date) return
                        if ($parameters?mode='commentary') then
                            html:block($config, ., ("tei-date1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            if (@when) then
                                html:alternate($config, ., ("tei-date2", css:map-rend-to-class(.)), ., ., @when, map {})                                => model:map($node, $trackIds)
                            else
                                html:inline($config, ., ("tei-date3", css:map-rend-to-class(.)), .)                                => model:map($node, $trackIds)
                    case element(argument) return
                        html:block($config, ., ("tei-argument", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(corr) return
                        if (parent::choice and count(parent::*/*) gt 1) then
                            (: simple inline, if in parent choice. :)
                            html:inline($config, ., ("tei-corr1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            html:inline($config, ., ("tei-corr2", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                    case element(foreign) return
                        html:inline($config, ., ("tei-foreign", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
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
                                                html:pass-through(map:merge(($config, map:entry("template", true()))), ., ("tei-mei_mdiv", css:map-rend-to-class(.)), $content)                        => model:map($node, $trackIds)
                    case element(cit) return
                        if (child::quote and child::bibl) then
                            (: Insert citation :)
                            html:cit($config, ., ("tei-cit", css:map-rend-to-class(.)), ., ())                            => model:map($node, $trackIds)
                        else
                            $config?apply($config, ./node())
                    case element(titleStmt) return
                        if ($parameters?mode='commentary') then
                            html:block($config, ., ("tei-titleStmt1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            if ($parameters?mode='title') then
                                html:heading($config, ., ("tei-titleStmt4", css:map-rend-to-class(.)), title[not(@type)], 5)                                => model:map($node, $trackIds)
                            else
                                if ($parameters?header='short') then
                                    (
                                        html:link($config, ., ("tei-titleStmt5", css:map-rend-to-class(.)), title[1], $parameters?doc, (), map {})                                        => model:map($node, $trackIds),
                                        html:block($config, ., ("tei-titleStmt6", css:map-rend-to-class(.)), subsequence(title, 2))                                        => model:map($node, $trackIds),
                                        html:block($config, ., ("tei-titleStmt7", css:map-rend-to-class(.)), author)                                        => model:map($node, $trackIds)
                                    )

                                else
                                    html:block($config, ., ("tei-titleStmt8", css:map-rend-to-class(.)), .)                                    => model:map($node, $trackIds)
                    case element(fileDesc) return
                        if ($parameters?mode='commentary') then
                            html:block($config, ., ("tei-fileDesc1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            if ($parameters?header='short') then
                                (
                                    (: Dati documento nella homepage :)
                                    html:block($config, ., ("tei-fileDesc2", "header-short", css:map-rend-to-class(.)), titleStmt)                                    => model:map($node, $trackIds),
                                    html:block($config, ., ("tei-fileDesc3", "header-short", css:map-rend-to-class(.)), /seriesStmt/title | (/seriesStmt/biblScope[position()=1]/@unit | /seriesStmt/biblScope[position()=1]/@n))                                    => model:map($node, $trackIds),
                                    html:block($config, ., ("tei-fileDesc4", "header-short", css:map-rend-to-class(.)), //msIdentifier/repository)                                    => model:map($node, $trackIds),
                                    (: Output abstract :)
                                    html:block($config, ., ("tei-fileDesc5", "sample-description", css:map-rend-to-class(.)), //note/ab)                                    => model:map($node, $trackIds)
                                )

                            else
                                html:title($config, ., ("tei-fileDesc6", css:map-rend-to-class(.)), titleStmt)                                => model:map($node, $trackIds)
                    case element(sic) return
                        if (parent::choice and count(parent::*/*) gt 1) then
                            html:inline($config, ., ("tei-sic1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            html:inline($config, ., ("tei-sic2", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                    case element(spGrp) return
                        html:block($config, ., ("tei-spGrp", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(body) return
                        (
                            html:index($config, ., ("tei-body1", css:map-rend-to-class(.)), 'toc', .)                            => model:map($node, $trackIds),
                            html:block($config, ., ("tei-body2", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        )

                    case element(fw) return
                        if (@type="running-head") then
                            html:block($config, ., ("tei-fw1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            if (@type="page-number") then
                                html:block($config, ., ("tei-fw2", css:map-rend-to-class(.)), .)                                => model:map($node, $trackIds)
                            else
                                if (ancestor::p or ancestor::ab) then
                                    html:inline($config, ., ("tei-fw3", css:map-rend-to-class(.)), .)                                    => model:map($node, $trackIds)
                                else
                                    html:block($config, ., ("tei-fw4", css:map-rend-to-class(.)), .)                                    => model:map($node, $trackIds)
                    case element(encodingDesc) return
                        if ($parameters?header='short') then
                            html:omit($config, ., ("tei-encodingDesc1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            if ($parameters?mode='commentary') then
                                let $params := 
                                    map {
                                        "content": .
                                    }

                                                                let $content := 
                                    model:template-encodingDesc2($config, ., $params)
                                return
                                                                html:block(map:merge(($config, map:entry("template", true()))), ., ("tei-encodingDesc2", css:map-rend-to-class(.)), $content)                                => model:map($node, $trackIds)
                            else
                                html:inline($config, ., ("tei-encodingDesc3", css:map-rend-to-class(.)), .)                                => model:map($node, $trackIds)
                    case element(quote) return
                        html:alternate($config, ., ("tei-quote", css:map-rend-to-class(.)), ., ., id (substring-after(@source, '#'), doc("/db/apps/LiDi/data/bibl.xml")), map {})                        => model:map($node, $trackIds)
                    case element(gap) return
                        if (desc) then
                            html:inline($config, ., ("tei-gap1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            if (@extent) then
                                html:inline($config, ., ("tei-gap2", css:map-rend-to-class(.)), @extent)                                => model:map($node, $trackIds)
                            else
                                html:inline($config, ., ("tei-gap3", css:map-rend-to-class(.)), .)                                => model:map($node, $trackIds)
                    case element(seg) return
                        if (@xml:lang and @source) then
                            let $params := 
                                map {
                                    "uri": @source,
                                    "content": .
                                }

                                                        let $content := 
                                model:template-seg($config, ., $params)
                            return
                                                        html:figure(map:merge(($config, map:entry("template", true()))), ., ("tei-seg1", css:map-rend-to-class(.)), $content, ())                            => model:map($node, $trackIds)
                        else
                            if (@xml:lang) then
                                html:figure($config, ., ("tei-seg2", css:map-rend-to-class(.)), ., ())                                => model:map($node, $trackIds)
                            else
                                if (@source) then
                                    html:link($config, ., ("tei-seg3", css:map-rend-to-class(.)), ., @source, "_blank", map {})                                    => model:map($node, $trackIds)
                                else
                                    html:inline($config, ., ("tei-seg4", css:map-rend-to-class(.)), .)                                    => model:map($node, $trackIds)
                    case element(notatedMusic) return
                        html:figure($config, ., ("tei-notatedMusic", css:map-rend-to-class(.)), (ptr, mei:mdiv), label)                        => model:map($node, $trackIds)
                    case element(profileDesc) return
                        html:omit($config, ., ("tei-profileDesc", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(row) return
                        if (@role='label') then
                            html:row($config, ., ("tei-row1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            (: Insert table row. :)
                            html:row($config, ., ("tei-row2", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                    case element(text) return
                        html:body($config, ., ("tei-text", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(floatingText) return
                        html:block($config, ., ("tei-floatingText", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(sp) return
                        html:block($config, ., ("tei-sp", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(byline) return
                        html:block($config, ., ("tei-byline", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(table) return
                        html:table($config, ., ("tei-table", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(group) return
                        html:block($config, ., ("tei-group", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(cb) return
                        html:omit($config, ., ("tei-cb", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(persName) return
                        if (ancestor::listPerson) then
                            html:block($config, ., ("tei-persName1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            if (ancestor::body) then
                                html:alternate($config, ., ("tei-persName2", css:map-rend-to-class(.)), ., ., id (substring-after(@ref, '#'), doc("/db/apps/LiDi/data/people.xml")), map {})                                => model:map($node, $trackIds)
                            else
                                $config?apply($config, ./node())
                    case element(placeName) return
                        if (ancestor::body) then
                            html:alternate($config, ., ("tei-placeName", css:map-rend-to-class(.)), ., ., id (substring-after(@ref, '#'), doc("/db/apps/LiDi/data/place.xml")), map {})                            => model:map($node, $trackIds)
                        else
                            $config?apply($config, ./node())
                    case element(rs) return
                        if (@type="all_god") then
                            html:inline($config, ., ("tei-rs", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            $config?apply($config, ./node())
                    case element(person) return
                        if (@sameAs) then
                            html:link($config, ., ("tei-person1", css:map-rend-to-class(.)), persName, @sameAs, "_blank", map {})                            => model:map($node, $trackIds)
                        else
                            html:inline($config, ., ("tei-person2", css:map-rend-to-class(.)), persName)                            => model:map($node, $trackIds)
                    case element(place) return
                        if (@sameAs) then
                            html:link($config, ., ("tei-place1", css:map-rend-to-class(.)), ., @sameAs, "_blank", map {})                            => model:map($node, $trackIds)
                        else
                            html:inline($config, ., ("tei-place2", css:map-rend-to-class(.)), placeName)                            => model:map($node, $trackIds)
                    case element(biblScope) return
                        if (parent::bibl) then
                            html:inline($config, ., ("tei-biblScope", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            $config?apply($config, ./node())
                    case element(citedRange) return
                        html:inline($config, ., ("tei-citedRange", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(sponsor) return
                        html:omit($config, ., ("tei-sponsor", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(editionStmt) return
                        if ($parameters?mode='commentary') then
                            html:block($config, ., ("tei-editionStmt", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            $config?apply($config, ./node())
                    case element(respStmt) return
                        html:omit($config, ., ("tei-respStmt", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(principal) return
                        if ($parameters?mode='commentary') then
                            html:block($config, ., ("tei-principal", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            $config?apply($config, ./node())
                    case element(funder) return
                        html:omit($config, ., ("tei-funder", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(sourceDesc) return
                        if ($parameters?mode='commentary') then
                            html:block($config, ., ("tei-sourceDesc", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
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
                                    "desc": physDesc,
                                    "content": .
                                }

                                                        let $content := 
                                model:template-msDesc($config, ., $params)
                            return
                                                        html:block(map:merge(($config, map:entry("template", true()))), ., ("tei-msDesc1", css:map-rend-to-class(.)), $content)                            => model:map($node, $trackIds)
                        else
                            html:inline($config, ., ("tei-msDesc2", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                    case element(physDesc) return
                        if ($parameters?mode='commentary') then
                            html:block($config, ., ("tei-physDesc", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            $config?apply($config, ./node())
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
                                                        html:block(map:merge(($config, map:entry("template", true()))), ., ("tei-seriesStmt", css:map-rend-to-class(.)), $content)                            => model:map($node, $trackIds)
                        else
                            $config?apply($config, ./node())
                    case element(editorialDecl) return
                        if ($parameters?mode='commentary') then
                            html:block($config, ., ("tei-editorialDecl1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            if ($parameters?header='short') then
                                html:omit($config, ., ("tei-editorialDecl2", css:map-rend-to-class(.)), .)                                => model:map($node, $trackIds)
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
                                                        html:block(map:merge(($config, map:entry("template", true()))), ., ("tei-availability", css:map-rend-to-class(.)), $content)                            => model:map($node, $trackIds)
                        else
                            $config?apply($config, ./node())
                    case element(figDesc) return
                        html:alternate($config, ., ("tei-figDesc", css:map-rend-to-class(.)), ., "🖼️", ., map {})                        => model:map($node, $trackIds)
                    case element(term) return
                        let $params := 
                            map {
                                "content": .
                            }

                                                let $content := 
                            model:template-term($config, ., $params)
                        return
                                                html:inline(map:merge(($config, map:entry("template", true()))), ., ("tei-term", css:map-rend-to-class(.)), $content)                        => model:map($node, $trackIds)
                    case element(classDecl) return
                        if ($parameters?mode='commentary') then
                            let $params := 
                                map {
                                    "content": .
                                }

                                                        let $content := 
                                model:template-classDecl($config, ., $params)
                            return
                                                        html:block(map:merge(($config, map:entry("template", true()))), ., ("tei-classDecl", css:map-rend-to-class(.)), $content)                            => model:map($node, $trackIds)
                        else
                            $config?apply($config, ./node())
                    case element(exist:match) return
                        html:match($config, ., .)
                    case element() return
                        if (namespace-uri(.) = 'http://www.tei-c.org/ns/1.0') then
                            $config?apply($config, ./node())
                        else
                            .
                    case text() | xs:anyAtomicType return
                        html:escapeChars(.)
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
                    html:escapeChars(.)
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

