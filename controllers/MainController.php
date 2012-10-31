<?php
require_once('AppController.php');
class MainController extends AppController 
{
	static function home() {
		return self::template('home.html.twig', array(			
		));
	}
}

?>
