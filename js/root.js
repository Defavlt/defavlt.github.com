$(document).ready(function () {	
	
	var $articles = $('article');
	
	if ($articles.length > 1) {
		
		var $article = $("article:first-of-type");
		var $latestNav = $("header nav a:first-of-type");
		
		$article
			.bind("mouseover", function () {
				console.log(
					$latestNav
						.switchClass('', 'nav-latest-hover'));
			})
			.bind("mouseout", function () {
				console.log(
					$latestNav
						.switchClass('nav-latest-hover', ''));
			});
			
		$latestNav
			.bind("mouseover", function () {
				console.log(	
					$article
						.switchClass('', 'article-hover-even'));
			})
			.bind("mouseout", function () {
				console.log(
					$article
						.switchClass('article-hover-even', ''));
			});
	}
	
	if ($articles.length <= 1) {
		
		var headers = $('h1:not(:first-of-type), h2, h3, h4, h5, h6');
		
		headers
			.map(function () {
				var $this = $(this);
				
				$this.attr('id', $this.html().replace(/\s/g, '-'));
			});

		$('h1:first-of-type')
			.attr('id', 'top');
			
		headers
			.append(function (index, html) {
				return $("<a href='#top'> *</a>");
			});
	}
});