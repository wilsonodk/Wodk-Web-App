<?php
class AppController
{
    static public function register() {
        ini_set('unserialize_callback_func', 'spl_autoload_call');
        spl_autoload_register(array(new self, 'autoload'));
    }

    static public function autoload($class) {
        if (strpos($class, 'Controller') === FALSE) {
            return;
        }

        if (is_file($file = dirname(__FILE__).'/'.$class.'.php')) {
            require $file;
        }
    }

    static function template($template, $extra_params = array()) {
        $twig   = option('twig');
        $params = array_merge(option(), $extra_params);
        $tmpl   = $twig->loadTemplate($template);

        return $tmpl->render($params);
    }
}
?>
