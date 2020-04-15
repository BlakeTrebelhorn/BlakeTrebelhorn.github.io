<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="utf-8" indent="yes" />
	
	<xsl:variable name="debug" select="true()"/>
	<xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'"/>
	<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
	<xsl:template match="/">
		<html lang="en">

    		<head>
				<!-- Required meta tags -->
				<meta charset="utf-8"/>
				<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
				<!-- Bootstrap CSS -->
				<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous"/>
				<!-- Optional JavaScript -->
				<!-- jQuery first, then Popper.js, then Bootstrap JS -->
				<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"/>
				<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"/>
				<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"/>

				<!-- BS Select -->
				<!-- Latest compiled and minified CSS -->
				<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/css/bootstrap-select.min.css"/>

				<!-- Latest compiled and minified JavaScript -->
				<script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/js/bootstrap-select.min.js"/>
				<title>Blake Trebelhorn</title>
				<style type="text/css">
					.card-flip {
					  perspective: 1000px;
					}

					.flipped {
					  transform: rotateY(180deg);
					}

					.card-flip,
					.front,
					.back {
					  width: 100%;
					  //height: 480px;
					}

					.flip {
					  transition: 0.6s;
					  transform-style: preserve-3d;
					  position: relative;
					}

					.front,
					.back {
					  backface-visibility: hidden;
					  position: absolute;
					  top: 0;
					  left: 0;
					}

					.front {
					  z-index: 2;
					  transform: rotateY(0deg);
					}

					.back {
					  transform: rotateY(180deg);
					}
				</style>
				
				<script type="text/javascript">
					$(document).ready(function() {
						$(".card-flip").click(function() {
							$(this).find('.flip').toggleClass('flipped');
						});
						$('.card-flip').each(function() {
							var maxHeight = $(this).find('.front-card').height();
							if ($(this).find('.back-card').height() > maxHeight) {
								maxHeight = $(this).find('.back-card').height();
							}
							this.style.height = maxHeight;
						});
					});
				</script>
			</head>

			<body>
				<a href="../index.html">Return to main site</a>
				<div class="container">
					<div class="row d-none">
						<xsl:if test="$debug">
							<xsl:attribute name="class">row</xsl:attribute>
						</xsl:if>
						<div class="col-xs-12 col-sm-5">
							<div class="form-group">
								<label for="search" class="mr-2">Search</label>
								<input type="text" class="form-control" id="search" placeholder="Search">
									<xsl:attribute name="onkeyup">
										$('.card-flip').show();
										var filter = $(this).val() + "";
										$(".card-flip:not([data-title*='" + filter.toLowerCase() + "'])").hide();
									</xsl:attribute>
								</input>
							</div>
						</div>
						<div class="col-xs-12 col-sm-2">Or</div>
						<div class="col-xs-12 col-sm-5">
							<div class="form-group">
								<label for="exampleFormControlSelect1" class="mr-2">Filter</label>
								<select multiple="multiple" class="selectpicker" id="exampleFormControlSelect1">
									<option>1</option>
									<option>2</option>
									<option>3</option>
									<option>4</option>
									<option>5</option>
								</select>
							</div>
						</div>
					</div>
					<div id="card-container">
						<div class="row">
							<xsl:if test="$debug">
								<xsl:attribute name="class"><!-- clear out if test --></xsl:attribute>
							</xsl:if>
							<xsl:apply-templates select="/Root/Recipes/Recipe"/>
						</div>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>
		
	<xsl:template match="Recipe">
		<div class="card-flip col-xs-12 col-sm-6 col-lg-4 mb-3" id="{ID}" data-title="{translate(Title, $lowercase, $uppercase)}">
			<xsl:attribute name="data-tags">
				<xsl:for-each select="Tags/Tag">
					<xsl:value-of select="concat(., ',')"/>
				</xsl:for-each>
			</xsl:attribute>
			<xsl:if test="$debug">
				<xsl:attribute name="class">card-flip mb-3</xsl:attribute>
			</xsl:if>
			<div class="flip">
				<div class="front">
					<!-- front content -->
					<div class="card border-dark front-card">
					  <div class="card-header"><xsl:value-of select="Title"/></div>
						<ul class="list-group list-group-flush">
							<xsl:for-each select="Ingredients/Ingredient">
								<li class="list-group-item"><xsl:value-of select="."/></li>
							</xsl:for-each>
						</ul>
						<xsl:if test="Links/Link">
							<div class="card-body">
								<xsl:for-each select="Links/Link">
									<a class="card-link" href="{HREF}" role="button" target="_blank"><xsl:value-of select="Text"/></a>
								</xsl:for-each>
							</div>
						</xsl:if>
					</div>
				</div>
				<div class="back">
					<!-- back content -->
					<div class="card border-dark back-card">
					  <div class="card-header"><xsl:value-of select="Title"/></div>
						<div class="card-body">
							<p class="card-text">
								<ol>
									<xsl:for-each select="Instructions/Instruction">
										<li><xsl:value-of select="."/></li>
									</xsl:for-each>
								</ol>
							</p>
						</div>
						<xsl:if test="Notes/Note">
							<p class="card-text">
								<ul>
									<xsl:for-each select="Notes/Note">
										<li><xsl:value-of select="."/></li>
									</xsl:for-each>
								</ul>
							</p>
						</xsl:if>
					</div>
				</div>
			</div>
		</div>
	</xsl:template>
</xsl:stylesheet>