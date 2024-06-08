<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" 
                xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:html="http://www.w3.org/1999/xhtml"

                xmlns:rng="http://relaxng.org/ns/structure/1.0"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:teix="http://www.tei-c.org/ns/Examples"
                
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="a fo rng tei teix"
                version="3.0">
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet" type="stylesheet">
      <desc>
         <p> TEI stylesheet dealing with elements from the namesdates module,
      making HTML output. </p>
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

  <xsl:template match="tei:listPerson">
      <ul>
         <xsl:apply-templates/>
      </ul>
  </xsl:template>

  <xsl:template match="tei:person">
      <li>
          <xsl:attribute name="id">
              <xsl:value-of select="@xml:id"/>
          </xsl:attribute>
          <xsl:value-of select="tei:persName/tei:forename/text()"/>
          <xsl:text> </xsl:text>
          <xsl:choose> 
              <xsl:when test="tei:persName/tei:surname/@type">
                  <xsl:value-of select="tei:persName/tei:surname[@type='married']/text()"/>
                  <!-- TODO add " née ..." -->
              </xsl:when>
              <xsl:otherwise>
                  <xsl:value-of select="tei:persName/tei:surname/text()"/>
              </xsl:otherwise>
          </xsl:choose>
          <xsl:if test="tei:persName/tei:addName">
              <xsl:text>, </xsl:text>
              <xsl:value-of select="tei:persName/tei:addName/text()"/>
          </xsl:if>
          <xsl:if test="tei:persName/tei:title">
              <xsl:text>, </xsl:text>
              <xsl:value-of select="tei:persName/tei:title/text()"/>
          </xsl:if>
          <xsl:if test="tei:birth|tei:death">
              <xsl:text> (</xsl:text>
              <xsl:choose>
                  <xsl:when test="tei:birth">
                      <xsl:value-of select="substring(tei:birth, 1, 4)"/>
                  </xsl:when>
                  <xsl:otherwise><xsl:text>?</xsl:text></xsl:otherwise>
              </xsl:choose>
              <xsl:text>-</xsl:text>
              <xsl:choose>
                  <xsl:when test="tei:death">
                      <xsl:value-of select="substring(tei:death, 1, 4)"/>
                  </xsl:when>
                  <xsl:otherwise><xsl:text>?</xsl:text></xsl:otherwise>
              </xsl:choose>
              <xsl:text>)</xsl:text>
          </xsl:if>
          <xsl:if test="tei:occupation">
              <xsl:text>, </xsl:text>
              <xsl:value-of select="tei:occupation"/>
          </xsl:if>
          <xsl:if test="tei:note">
              <xsl:text>. </xsl:text>
              <xsl:value-of select="tei:note"/>
          </xsl:if>
          <br/>
          <!--<xsl:if test="tei:bibl">-->
              <!--<div class="indexrefs">Referenzen:</div>-->
          <!--<ul>-->
          <xsl:for-each select="tei:bibl">
             <!-- <li>-->
              <div class="biblfree">
                  <xsl:apply-templates/>
              </div>
              <!--</li>-->
          </xsl:for-each>
          <!--</ul>-->
          <!--</xsl:if>-->
      </li>
  </xsl:template>

  <xsl:template match="tei:affiliation|tei:email">
      <br/>
      <xsl:apply-templates/>
  </xsl:template>

</xsl:stylesheet>
