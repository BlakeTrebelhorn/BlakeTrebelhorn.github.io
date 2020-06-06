<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="utf-8" indent="yes" />
	
	<xsl:key name="uniqueTags" match="/Root/Recipes/Recipe/Tags/Tag/text()" use="."/>
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
				<title>Recipes | Blake Trebelhorn</title>
				<!-- https://stackoverflow.com/a/16436975 -->
				<script type="text/javascript">
					function arraysEqual(a, b) {
						if (a === b) return true;
						if (a == null || b == null) return false;
						if (a.length !== b.length) return false;

						// If you don't care about the order of the elements inside
						// the array, you should sort both arrays here.
						// Please note that calling sort on an array will modify that array.
						// you might want to clone your array first.

						for (var i = 0; i &lt; a.length; ++i) {
							if (a[i] !== b[i]) return false;
						}

						return true;
					}

					$(document).ready(function () {
						var $card = $('.card');
						var $filterSelect = $('#filterSelect');
						var $search = $('#search');
						$filterSelect.change(function () {
						    $search.val('');
							var selectedOptionsArray = $(this).val();
							$card.show();
							if (selectedOptionsArray.length) {
								$card.each(function () {
									var $this = $(this);
									var cardTags = $this.data('tags').split(',').filter(item => item);
									var intersection = selectedOptionsArray.filter(x => cardTags.includes(x));
									if (!arraysEqual(intersection, selectedOptionsArray)) {
										$this.hide();
									}
								});
							}
						});

						$search.keyup(function () {
						    $filterSelect.val('').selectpicker('refresh');
							$card.show();
							var filter = $(this).val() + "";
							if (filter) {
								$(".card:not([data-title*='" + filter.toLowerCase() + "'])").hide();
							}
						});
					});
				</script>
			</head>

			<body>
				<a href="../index.html">Return to main site</a>
				<div class="container">
					<div class="row no-gutters">
						<div class="col-xs-12 col-sm-5">
							<div class="form-group">
								<label for="search" class="mr-2 sr-only">Search</label>
								<input type="text" class="form-control" id="search" placeholder="Search"/>
							</div>
						</div>
						<div class="col-xs-12 col-sm-2 font-weight-bold text-sm-center mb-3 mb-sm-0">Or</div>
						<div class="col-xs-12 col-sm-5">
							<div class="form-group">
								<label for="filterSelect" class="sr-only">Filter</label>
								<select multiple="multiple" class="selectpicker" id="filterSelect" title="Filter">
									<optgroup label="Type">
										<xsl:for-each
												select="/Root/Recipes/Recipe/Tags/Tag[@type = 'category']/text()[generate-id() = generate-id(key('uniqueTags', .)[1])]">
											<xsl:sort select="string-length(substring-after('|Main|Side|Desert|Other|', .))" data-type="number" order="descending"/>
											<option>
												<xsl:value-of select="."/>
											</option>
										</xsl:for-each>
									</optgroup>
									<optgroup>
										<xsl:for-each
												select="/Root/Recipes/Recipe/Tags/Tag[not(@type)]/text()[generate-id() = generate-id(key('uniqueTags', .)[1])]">
											<option>
												<xsl:value-of select="."/>
											</option>
										</xsl:for-each>
									</optgroup>
								</select>
							</div>
						</div>
					</div>
					<xsl:apply-templates select="/Root/Recipes/Recipe"/>
				</div>
			</body>
		</html>
	</xsl:template>
		
	<xsl:template match="Recipe">
		<div class="card border-dark mb-3" id="{ID}" data-title="{translate(Title, $uppercase, $lowercase)}">
			<xsl:attribute name="data-tags">
				<xsl:for-each select="Tags/Tag">
					<xsl:value-of select="concat(., ',')"/>
				</xsl:for-each>
			</xsl:attribute>
			<div class="card-header"><xsl:value-of select="Title"/></div>
			<a class="list-group-item border-top-0 text-info" data-toggle="collapse" href="{concat('#Ingredients', ID)}">
				Ingredients
			</a>
			<ul id="{concat('Ingredients', ID)}" class="collapse list-group list-group-flush">
				<xsl:for-each select="Ingredients/Ingredient">
					<li class="list-group-item"><xsl:value-of select="."/></li>
				</xsl:for-each>
			</ul>
			<a class="list-group-item text-info" href="{concat('#Instructions', ID)}" data-toggle="collapse">
				Instructions
			</a>
			<div class="card-body collapse" id="{concat('Instructions', ID)}">
				<ol>
					<xsl:for-each select="Instructions/Instruction">
						<li><xsl:value-of select="."/></li>
					</xsl:for-each>
				</ol>
				<xsl:if test="Notes/Note">
					<ul>
						<xsl:for-each select="Notes/Note">
							<li><xsl:value-of select="."/></li>
						</xsl:for-each>
					</ul>
				</xsl:if>
			</div>
			<div class="card-body">
				<xsl:if test="Links/Link">
					Source<xsl:if test="count(Links/Link) &gt; 1">s</xsl:if>:
					<xsl:for-each select="Links/Link">
						<a class="card-link" href="{HREF}" role="button" target="_blank">
							<xsl:value-of select="Text"/>
						</a>
					</xsl:for-each>
				</xsl:if>
			</div>
		</div>
	</xsl:template>
</xsl:stylesheet>