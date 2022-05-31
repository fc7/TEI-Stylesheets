<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"  xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:dbk="http://docbook.org/ns/docbook"
                xmlns:rng="http://relaxng.org/ns/structure/1.0"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:html="http://www.w3.org/1999/xhtml"

                
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="a fo dbk xlink xhtml rng tei teix"
                version="2.0">
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet" type="stylesheet">
      <desc>
         <p> TEI stylesheet dealing with elements from the textcrit
      module, making HTML output. </p>
         <p>This software is dual-licensed:

1. Distributed under a Creative Commons Attribution-ShareAlike 3.0
Unported License http://creativecommons.org/licenses/by-sa/3.0/ 

2. http://www.opensource.org/licenses/BSD-2-Clause
		


Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

* Redistributions of source code must retain the above copyright
notice, this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright
notice, this list of conditions and the following disclaimer in the
documentation and/or other materials provided with the distribution.

This software is provided by the copyright holders and contributors
"as is" and any express or implied warranties, including, but not
limited to, the implied warranties of merchantability and fitness for
a particular purpose are disclaimed. In no event shall the copyright
holder or contributors be liable for any direct, indirect, incidental,
special, exemplary, or consequential damages (including, but not
limited to, procurement of substitute goods or services; loss of use,
data, or profits; or business interruption) however caused and on any
theory of liability, whether in contract, strict liability, or tort
(including negligence or otherwise) arising in any way out of the use
of this software, even if advised of the possibility of such damage.
</p>
         <p>Author: See AUTHORS</p>
         
         <p>Copyright: 2013, TEI Consortium</p>
      </desc>
   </doc>

   <xsl:template name="makeAppEntry">
     <xsl:param name="lemma"/>
     <!--<xsl:message>App: <xsl:value-of select="($lemma,$lemmawitness,$readings)" separator="|"/></xsl:message>-->
      <span class="txtlemma"><xsl:if test="tei:lem/@xml:id">
         <xsl:attribute name="id">
            <xsl:value-of select="tei:lem/@xml:id"/>
         </xsl:attribute>
      </xsl:if><xsl:apply-templates select="tei:lem"/></span>
      <xsl:variable name="noteNumber">
         <xsl:number count="tei:app" level="single"/>
      </xsl:variable>
      <xsl:variable name="identifier">
         <xsl:text>App</xsl:text>
         <xsl:choose>
	   <xsl:when test="@xml:id">
	     <xsl:value-of select="@xml:id"/>
	   </xsl:when>
	   <xsl:otherwise>
	     <xsl:value-of select="$noteNumber"/>
	   </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>

      <xsl:choose>
       <xsl:when test="$footnoteFile='true'">
	 <a class="notelink" href="{$masterFile}-notes.html#{$identifier}">
	   <sup>
	     <xsl:call-template name="appN"/>
	   </sup>
	 </a>
       </xsl:when>
       <xsl:otherwise>
	 <!--<a class="notelink" href="#{$identifier}">
	   <sup>
	     <xsl:call-template name="appN"/>
	   </sup>
	 </a>-->
       <span class="app">
          <a class="app">
             <xsl:attribute name="aria-label"><xsl:value-of select="$noteNumber"/></xsl:attribute>
             <xsl:attribute name="href"><xsl:text>#app</xsl:text><xsl:value-of select="$noteNumber"/></xsl:attribute>
          </a>
         <span class="appnote">
            <xsl:attribute name="data-sign"><xsl:value-of select="$noteNumber"/></xsl:attribute>
            <xsl:attribute name="id"><xsl:text>app</xsl:text><xsl:value-of select="$noteNumber"/></xsl:attribute>
            <span class="applemma">
               <xsl:choose>
                  <xsl:when test="tei:lem/@rend != ''">
                     <xsl:value-of select="tei:lem/@rend"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:apply-templates select="tei:lem"/>
                  </xsl:otherwise>
               </xsl:choose>
               <xsl:text>] </xsl:text>
            <xsl:call-template name="appLemmaWitness"/>
            <xsl:call-template name="appReadings"/>
            </span>
         </span>
      </span>
       </xsl:otherwise>
      </xsl:choose>

  </xsl:template>


   <xsl:template match="tei:app" mode="printnotes">
      <xsl:variable name="identifier">
         <xsl:text>App</xsl:text>
         <xsl:choose>
            <xsl:when test="@xml:id">
	      <xsl:value-of select="@xml:id"/>
            </xsl:when>
            <xsl:otherwise>
	      <xsl:number count="tei:app" level="any"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <div class="app">
         <xsl:call-template name="makeAnchor">
            <xsl:with-param name="name" select="$identifier"/>
         </xsl:call-template>
	 <span class="lemma">
	   <xsl:call-template name="appLemma"/>
	 </span>
	 <xsl:text>] </xsl:text>
	 <span class="lemmawitness">
	   <xsl:call-template name="appLemmaWitness"/>
	 </span>
	<xsl:call-template name="appReadings"/>
     </div>
     
   </xsl:template>
   
   <!-- OVERLOADING FUNCTIONS in common_textcrit.xsl -->
   
   <xsl:template name="appLemmaWitness">
      <xsl:choose>
         <xsl:when test="tei:lem/@wit">
            <span class="appwitness"><xsl:value-of select="tei:getWitness(tei:lem/@wit)"/>
               <xsl:text>; </xsl:text>
            </span>
         </xsl:when>
         <!--FC7 <xsl:otherwise>
        <xsl:value-of select="tei:getWitness(tei:rdg[1]/@wit)"/>
      </xsl:otherwise>-->
      </xsl:choose>
   </xsl:template>
   
   <xsl:template name="appLemma">
      <xsl:choose>
         <xsl:when test="tei:lem">
            <xsl:choose>
               <xsl:when test="tei:lem/@rend != ''">
                  <span class="applemma"><xsl:value-of select="tei:lem/@rend"/></span>
               </xsl:when>
               <xsl:otherwise>
                  <span class="applemma"><xsl:apply-templates select="tei:lem/*" mode="clean"/></span>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>
         <!--FC7 <xsl:otherwise>
        <xsl:value-of select="tei:rdg[1]"/>
      </xsl:otherwise>-->
      </xsl:choose>
   </xsl:template>
   
   <xsl:template name="appReadings">
      <xsl:variable name="start" select="if (not(tei:lem)) then 1 else 0"/>
      <xsl:for-each select="tei:rdg">
         <xsl:apply-templates/>
         <xsl:text> </xsl:text>
         <xsl:if test="@cause = 'omission'"><span class="appomission">omit.</span> </xsl:if>
         <span class="rdgwitness">
         <xsl:value-of select="tei:getWitness(@wit)"/>
         </span>
         <xsl:if test="following-sibling::tei:rdg">; </xsl:if>
      </xsl:for-each>
   </xsl:template>

</xsl:stylesheet>
