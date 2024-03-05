<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="2.0">
    
    <!-- 1. INSTRUCTION POUR L'OUTPUT.
    Il est indiqué en HTML-->
    <xsl:output method="html" indent="yes"/>
    
    
    <!-- 2. DÉBUT DES DÉCLARATIONS DES VARIABLES -->
    <!-- CHEMINS DES FICHIERS DE SORTIE -->
    
    <xsl:variable name="home">
        <xsl:value-of select="concat('Exemplum_moniale_chaste_mais_bavarde_home','.html')"/> <!-- La fonction concat concatène les deux chaînes de caractères entre parenthèses, créant ainsi la chaîne “Exemplum_moniale_chaste_mais_bavarde_home.html”. Cette valeur est ensuite stockée dans la variable $home. Elle est utilisée pour faire des liens vers cette page HTML-->
        <!-- variable pour le contenu du home  -->
    </xsl:variable>
    
    <xsl:variable name="originel"> 
        <xsl:value-of select="concat('Exemplum_moniale_chaste_mais_bavarde_latin','.html')"/>  <!-- Ibid-->
        <!-- variable pour le texte originel  -->
    </xsl:variable>
    
    <xsl:variable name="traduction">
        <xsl:value-of select="concat('Exemplum_moniale_chaste_mais_bavarde_traduction','.html')"/> <!-- Ibid-->
        <!-- variable pour la traduction -->
    </xsl:variable>
    
    <xsl:variable name="index_">
        <xsl:value-of select="concat('Exemplum_moniale_chaste_mais_bavarde_index','.html')"/> <!-- Ibid-->
        <!-- variable pour l'index  -->
    </xsl:variable>
    
    <xsl:variable name="biblio">
        <xsl:value-of select="concat('Exemplum_moniale_chaste_mais_bavarde_biblio','.html')"/> <!-- Ibid-->
        <!-- variable pour la bibliographie  -->
    </xsl:variable>
    
    <!-- VARIABLE AVEC LE <HEAD> -->
    <xsl:variable name="header">
        <head> <!-- Cela ouvre la section HTML <head> qui contient généralement des métadonnées sur le document HTML. -->
            <meta name="viewport" content="width=device-width, initial-scale=1"/> <!-- Information de mise en page-->
            <title><xsl:value-of select="//titleStmt/title[@level='a']"/><xsl:value-of select="//titleStmt/title[@level='u']"/></title> <!-- Cela ouvre l'élément HTML <title>, qui définit le titre du document HTML. Cette expression XPath récupère la valeur de l'élément title avec @level='a''u' dans titleStmt.-->
            <meta name="description"> <!--Cela ouvre une balise meta pour la description du document HTML. -->
                <xsl:attribute name="content"> <!--Cela ouvre un attribut pour le "content" de la balise meta. -->
                    <xsl:value-of select="//titleStmt/title[@level='a']"/> <xsl:value-of select="//titleStmt/title[@level='u']"/> <!--Ces expressions XPath récupèrent les valeurs des éléments title avec @level='a' et @level='u' dans titleStmt. -->
                </xsl:attribute>
            </meta>
            <meta name="author"> <!--Cela ouvre une balise meta pour l'auteur du document HTML. -->
                <xsl:attribute name="content"> <!--Cela ouvre un attribut pour le "content" de la balise meta. -->
                    <xsl:value-of select="//titleStmt/respStmt/persName"/> <!-- Cette expression XPath récupère la valeur de l'élément persName dans respStmt de titleStmt.-->
                </xsl:attribute>
            </meta>
        </head>
    </xsl:variable>
    
    <!-- VARIABLE AVEC LE <FOOTER> -->
    <xsl:variable name="footer"> <!--Cela marque le début de la définition d'une variable XSLT nommée "footer" qui contiendra les éléments HTML du pied de page. -->
        <footer> <!-- Element pied de page -->
            <p><i><xsl:value-of select="//publicationStmt/p[@n='1']"/>.</i></p> <!-- Récupération des informations sur le cadre de cette production qui se trouvent dans <publicationStmt> -->
        </footer>
    </xsl:variable>
    
    <!-- VARIABLE AVEC LE CSS DU <BODY> -->
    <xsl:variable name="body_css"> <!-- Cela marque le début de la définition d'une variable XSLT nommée "body_css" qui contiendra la chaîne de texte CSS pour le fond .-->
        <xsl:text>margin-right: 20%; margin-left: 20%; margin-top: 6%; background-color: orange;</xsl:text>
    </xsl:variable>
    
    <xsl:variable name="cube"> <!--  Cela marque le début de la définition d'une variable XSLT qui contiendra la chaîne de texte CSS pour le texte-->
        <xsl:text>color: purple;</xsl:text>
    </xsl:variable>
    
    <!-- VARIABLES AVEC LES LIENS DE RETOUR -->
    <xsl:variable name="return_home"> <!-- Déclare une variable XSLT appelée "return_home".-->
        <i><a href="{concat('./', $home)}">Revenir à l'accueil</a></i> <!-- Ouvre une balise HTML <i> (italique).  Crée un lien <a> avec l'attribut "href" qui pointe vers l'accueil en utilisant la fonction concat pour concaténer le chemin actuel avec la valeur de la variable $home.-->
    </xsl:variable>
    
    <xsl:variable name="return_index"> <!-- Ibid mais pour l'index -->
        <i><a href="{concat('./', $index_)}">Index</a></i>
    </xsl:variable>
    
    <!-- VARIABLE AVEC L'EN-TÊTE DU <BODY> DES PAGES -->
    <xsl:variable name="body_header">
        <div style="text-align: center; margin-bottom: 8%;"> <!-- Ibid mais pour le header -->
            <h1>Édition en ligne de "L'<i><xsl:value-of select="//titleStmt/title[@level='a']"/></i><xsl:value-of select="//titleStmt/title[@level='u']"/>"</h1> <!-- Récupère des éléments pour la tête du documet-->
            <p><xsl:value-of select="//titleStmt/author"/></p> <!--Cela ouvre une balise HTML <p> contenant le nom de l'auteur extrait de l'élément <author> dans //titleStmt. -->
        </div>
    </xsl:variable>
    
    <!-- FIN DES DÉCLARATIONS DES VARIABLES -->
    
    
    
    <!-- TEMPLATE MATCH SUR LA RACINE AVEC LES CALL TEMPLATES DES PAGES-->
    <xsl:template match="/"> <!--Ces lignes appellent d'autres templates avec les noms respectifs "home", "originel", "traduction", "index", et "biblio". -->
        <xsl:call-template name="home"/> <!--L'utilisation de templates permet de diviser le traitement XSLT en différentes parties modulaires, ce qui peut rendre le code plus lisible et réutilisable. Chaque appel à une template déclenchera l'exécution du code contenu dans la template correspondante. -->
        <xsl:call-template name="_originel_"/>
        <xsl:call-template name="_traduction_"/>
        <xsl:call-template name="_index_"/>
        <xsl:call-template name="_biblio_"/>
    </xsl:template>
    
    <!-- TEMPLATE DE LA PAGE HOME -->
    <xsl:template name="home"> <!-- Jusqu'à la div il s'agit dela présentation classique de la page -->
        <xsl:result-document href="{$home}" method="html">
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <body>
                    <xsl:attribute name="style">
                        <xsl:value-of select="$body_css"/>
                    </xsl:attribute>
                    <xsl:copy-of select="$body_header"/>
                    <div style="text-align: justify;">  
                        <p><b>Présentation du projet : </b><xsl:value-of select="//publicationStmt/p[@n='2']"/></p> <!-- Récupération des informations qui expliquent le projet de l'édition. Il a fallut différencier les différents éléments du publicationSTmt -->
                    </div>
                    <div style="text-align: justify;">
                        <xsl:text>Liste des oeuvres dont sont tirées les récits exemplaires :</xsl:text>
                        <xsl:for-each select="//sourceDesc//witness"> <!-- Récupération des éléments pour faire la liste des sources utilisées -->
                            <li> <!-- Li pour faire une liste-->
                                <xsl:value-of select="bibl/author"/>, 
                                <i><xsl:value-of select="bibl/title"/></i>, 
                                <xsl:value-of select="concat('(', bibl/date, ')')"/> <!-- ajout de parenthèses. Il y avait des manières plus simple mais c'était pour répondre aux consignes -->
                            </li>
                        </xsl:for-each>
                    </div>
                    <div style="{$cube}"> <!-- Couleur du texte-->
                        <p><a href="./{$originel}">Textes originels</a> – <a href="./{$traduction}">Traductions</a> – <a href="./{$index_}">Index</a> – <a href="./{$biblio}">Bibliographie</a></p> <!-- Liens vers les autres parties du document HTML -->
                    </div>
                    <xsl:copy-of select="$footer"/> <!-- Récupération du pieds de page -->
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <!-- TEMPLATES DU TEXTE OROGINEL -->
    <xsl:template name="_originel_">
        <xsl:result-document href="{$originel}" method="html"> <!-- Récupération du début du document -->
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <body>
                    <xsl:attribute name="style">
                        <xsl:value-of select="$body_css"/>
                    </xsl:attribute>
                    <xsl:copy-of select="$body_header"/>
                    <div style="{$cube}">
                        <h3 style="text-align: center; padding-bottom: 2%;">Textes en latin</h3> <!-- Mise en place du titre de la page-->
                        <xsl:apply-templates select="./TEI/text"/> <!-- Appeler le template text ci-dessous pour ramener le texte -->
                    </div>
                    <xsl:copy-of select="$footer"/> <!-- Pieds de page -->
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="//text"> <!-- template pour récupérer le texte latin et le formater -->
        <div style="text-align: justify;"> <!-- mise en page -->
            <xsl:for-each select="//div[@n='1']//div"> <!--boucle pour appeler toutes les parties du texte  -->
                <xsl:variable name="title" select="head"/> <!-- Récupération de l'oeuvre dans laquelel s'incère le texte-->
                <h3><i><xsl:value-of select="$title"/></i></h3>
                <p><xsl:apply-templates select="p"/></p> <!-- Récupération du texte en temps que tel-->
            </xsl:for-each>
            <p>>> <a href="./{$traduction}">Traductions</a></p> <!-- Liens vers les autres pages/ ilq auraient aussi pu être placés dans le template texte_originel  -->
            <xsl:copy-of select="$return_home"/> – <xsl:copy-of select="$return_index"/> – <a href="./{$biblio}">Bibliographie</a>
        </div>
    </xsl:template>
    
    <!-- TEMPLATES DE LA TRADUCTION -->
    <xsl:template name="_traduction_">
        <xsl:result-document href="{$traduction}" method="html"> <!-- Jusqu'à la div il s'agit dela présentation classique de la page HTML--> -->
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <body>
                    <xsl:attribute name="style">
                        <xsl:value-of select="$body_css"/>
                    </xsl:attribute>
                    <xsl:copy-of select="$body_header"/>
                    <div style="text-align: justify;"> <!-- style du texte-->
                        <h3 style="text-align: center; padding-bottom: 2%;">Traduction</h3> <!-- Titre de la pahe HTML-->
                        <!-- ajout d'un @mode pour différencier le traitement du texte -->
                        <!-- texte du chapitre 2 de celui du chapitre 1 -->
                        <xsl:apply-templates select="./TEI/text" mode="_traduction_"/>
                        <p>>> <a href="./{$originel}">Textes originels</a></p> <!-- Lien vers les autres pages HTML-->
                            <xsl:copy-of select="$return_home"/> - <xsl:copy-of select="$return_index"/> – <a href="./{$biblio}">Bibliographie</a>
                    </div>
                    <xsl:copy-of select="$footer"/> <!-- pied de page -->
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <!-- Template pour le traitement du texte en français-->
    <xsl:template match="//text" mode="_traduction_"> 
        <xsl:for-each select="//back/div[@n='2']/div"> <!-- Création d'une boucle pour récupérer les différents textes-->
            <xsl:variable name="title" select="head"/> <!-- récupération des titres des oeuvres ou se trouvent les textes --> 
            <h3><i><xsl:value-of select="$title"/></i></h3> 
            <p><xsl:apply-templates select="p"/></p> <!-- Récupération des textes qui sont dans des balises p-->
            <!-- boucle afin de reproduire chaque <p> séparément -->
        </xsl:for-each>
    </xsl:template>
    
    <!-- TEMPLATES DE LA PAGE INDEX -->
    <xsl:template name="_index_"> <!-- Jusqu'à la div il s'agit dela présentation classique de la page -->
        <xsl:result-document href="{$index_}">
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <body>
                    <xsl:attribute name="style">
                        <xsl:value-of select="$body_css"/>
                    </xsl:attribute>
                    <xsl:copy-of select="$body_header"/>
                    <div style="{$cube}"> <!-- Création de la liste des éléments contenus dans l'index-->
                        <xsl:for-each-group select="//text//*[self::term or self::placeName or self::persName]" group-by="./@ref"> <!-- Création d'une boucle pour récupérer les balises term, persName, placeName. Ces balises servent pou l'index-->
                            <div>
                                <xsl:for-each-group select="current-group()" group-by="."> <!--La fonction current-group() est utilisée pour faire référence au groupe actuel de nœuds en cours de traitement par l'instruction xsl:for-each-group. group-by="." : L'attribut group-by est utilisé pour spécifier la clé de regroupement. Dans ce cas, le point (.) indique que les nœuds doivent être regroupés en fonction de leurs valeurs de chaîne. Cela signifie que les nœuds ayant la même valeur de chaîne seront regroupés ensemble.-->
                                    <p>
                                        <i><xsl:value-of select="."/></i> : <!--  Pour chaque élément du groupe, il est affiché dans une balise <p> avec une balise <i> pour l'italique, -->
                                        <xsl:variable name="firstOccurrence" select="current-group()[1]"/> <!-- Stocke le premier élément du groupe -->
                                        <xsl:variable name="chapter" select="ancestor::div/@n"/> <!-- Stocke la valeur de l’attribut n de l’élément div-->
                                        <a> <!-- Générationdu lien vers la page HTML-->
                                            <xsl:attribute name="href"> <!-- L'attribut href du lien est attribué dynamiquement en fonction de certaines conditions à l'aide de <xsl:choose>. -->
                                                <xsl:choose>
                                                    <xsl:when test="$chapter = '1' and not(ancestor::div/@n = '2')"> <!-- Si le chapitre est '1' et que l'attribut 'n' du div ancêtre n'est pas égal à '2', il utilise la variable $originel.-->
                                                        <xsl:text>./</xsl:text><xsl:value-of select="$originel"/>
                                                    </xsl:when>
                                                    <xsl:when test="$chapter = '2' and not(ancestor::div/@n = '1')"> <!--Si le chapitre est '2' et que l'attribut 'n' du div ancêtre n'est pas égal à '1', il utilise la variable $traduction. -->
                                                        <xsl:text>./</xsl:text><xsl:value-of select="$traduction"/>
                                                    </xsl:when>
                                                </xsl:choose>
                                            </xsl:attribute>
                                            <xsl:value-of select="$chapter"/> <!-- Cela ajoute la valeur de la variable $chapter au lien.-->
                                        </a>
                                    </p>
                                </xsl:for-each-group>
                            </div>
                        </xsl:for-each-group>
                        <p><xsl:copy-of select="$return_home"/> – <a href="./{$originel}">Textes originels</a> – <a href="./{$traduction}">Textes latins</a> – <a href="./{$biblio}">Bibliographie</a></p> <!-- Liens vers les autres pages HTML-->
                    </div>
                    <xsl:copy-of select="$footer"/> <!-- Récupération du pieds de page-->
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>    
    
    <!-- Template pour la biblio-->
    <xsl:template name="_biblio_"> 
        <xsl:result-document href="{$biblio}" method="html"> <!-- Jusqu'à la div il s'agit dela présentation classique de la page-->
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <body>
                    <xsl:attribute name="style">
                        <xsl:value-of select="$body_css"/>
                    </xsl:attribute>
                    <xsl:copy-of select="$body_header"/>
                    <xsl:text>Bibliographie : </xsl:text>
                    <div style="{$cube}">
                        <ul>
                            <xsl:for-each select="//witness"> <!--Création d'une boucle pour pour générer la bibliographie  -->
                                <li>
                                    <xsl:value-of select="bibl/author"/>,<!-- Récupération de informations sur l'auteur et son oeuvre-->
                                    <i><xsl:value-of select="bibl/title[@type='main']"/></i>, 
                                    <xsl:for-each select="bibl/bibl/editor"> <!-- Récupération des informations sur l'édition dans les lignes en dessous. Une sous boucle est faite pour les cas des éditeurs multiples -->
                                        <xsl:value-of select="name/surname"/>
                                        <xsl:text> </xsl:text>
                                        <xsl:value-of select="name/forename"/>
                                        
                                        <xsl:if test="position() != last()">
                                            <xsl:text> et </xsl:text>
                                        </xsl:if>
                                    </xsl:for-each> (ed.),
                                    <i><xsl:value-of select="bibl/bibl/title[@type='sub']"/></i> <!-- differentiation entre le nom de l'oeuvre et de l'édition -->
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="bibl/bibl/pubPlace"/>,
                                    <xsl:value-of select="bibl/bibl/publisher"/>,
                                    <xsl:value-of select="bibl/bibl/date"/>,
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of select="bibl/bibl/biblScope"/>
                                    <xsl:text>. </xsl:text>
                                </li>
                            </xsl:for-each>
                        </ul> <!-- Liens vers les autres pages -->
                        <p><xsl:copy-of select="$return_home"/> – <a href="./{$originel}">Textes originels</a> – <a href="./{$traduction}">Textes latins</a> - <xsl:copy-of select="$return_index"/></p>
                    </div>
                    <xsl:copy-of select="$footer"/> <!-- Récupération du footer -->
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>