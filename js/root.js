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
});
