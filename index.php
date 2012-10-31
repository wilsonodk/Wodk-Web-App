<?php
// Setup constants
// Wodk Web App constants
define('SITE_ROOT',		__DIR__);
define('CACHE_DIR',		SITE_ROOT . '/views/cache');
define('TEMPLATE_DIR',	SITE_ROOT . '/views/templates');
define('SITE_NAME',		%%site_name%%);
define('WODK_LOG',		SITE_ROOT . '/web_app.log');
define('WODK_BASE_URI',	'%%base_uri%%');
// Use this with halt() to send a 403
define('FORBIDDEN',		403);
// Database connection
define('DB_HOST', 		%%db_hostname%%);
define('DB_PORT',		%%db_port%%);
define('DB_NAME',		%%db_database%%);
define('DB_USER',		%%db_username%%);
define('DB_PASS',		%%db_password%%);
define('DB_SOCK',		%%db_socket%%);
define('DB_PFIX',		%%db_prefix%%);

// Get the micro-framework Limonade
require_once('vendors/limonade.php');
// Load Database Class
require_once('vendors/Wodk/MyDB.php');
// Get Logger Class
require_once('vendors/Wodk/Logger.php');
// Get our templating engine Twig
require_once('vendors/Twig/Autoloader.php');
Twig_Autoloader::register();
// Load our Twig Extension
require_once('vendors/Wodk/TwigFilters.php');
// Get our routes
require_once('routes.php');

// Global helpers
function get_post($var) {
	if (isset($_POST[$var])) {
		return $_POST[$var];
	}
	else {
		return NULL;
	}
}

function get_flash_messages($all) {
	$errs = array();
	$msgs = array();
	foreach ($all as $type => $msg) {
		if (strpos($type, 'error') !== FALSE) {
			array_push($errs, $msg);
		}
		elseif (strpos($type, 'message') !== FALSE) {
			array_push($msgs, $msg);
		}
	}
	option('have_flash_errors', count($errs) ? TRUE : FALSE);
	option('flash_errors', $errs);
	option('have_flash_messages', count($msgs) ? TRUE : FALSE);
	option('flash_messages', $msgs);
	return array('errors' => $errs, 'messages' => $msgs);
}

// Limonade 
function configure() {
	// Setup logging
	$log = new Logger(WODK_LOG);
	option('log', $log);

	// Setup environment
	$localhost = preg_match('/^localhost(\:\d+)?/', $_SERVER['HTTP_HOST']);
	$env =  $localhost ? ENV_DEVELOPMENT : ENV_PRODUCTION;
	option('env', $env);
	option('base_uri', WODK_BASE_URI);
	option('site_name', SITE_NAME);

	// Setup database
	$db = new MyDB(DB_HOST, DB_USER, DB_PASS, DB_NAME, DB_PORT, DB_SOCK);
	option('db', $db->setPrefix(DB_PFIX));

	// Setup template engine
	$cache = $env == ENV_PRODUCTION ? CACHE_DIR : FALSE;
	$loader = new Twig_Loader_Filesystem(TEMPLATE_DIR);
	$twig	= new Twig_Environment($loader, array(
		'cache' => $cache,
	));
	$twig->getExtension('core')->setTimezone('America/New_York');
	$twig->addExtension(new TwigFilters());
	option('twig', $twig);

	// Setup other application configurations
}

function before() {
	// Load flash
	get_flash_messages(flash_now());
}

function before_exit($exit) {
	$db = option('db');
	$db->close();
}
// Start app
run();

?>