<?php

class AppController
{
	static function template($template, $extra_params = array()) {
		$twig 	= option('twig');
		$params = array_merge(option(), $extra_params);
		$tmpl 	= $twig->loadTemplate($template);
		return $tmpl->render($params);
	}
}

?>