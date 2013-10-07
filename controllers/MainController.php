<?php
class MainController extends AppController
{
    static function home() {
        // This code is here to show how to use a controller.
        // As well as to help confirm that everything is working.
        // Feel free to delete.
        $statuses = array();

        if (file_exists(SITE_ROOT . '/build.rb')) {
            $statuses[] = 'You can safely remove the build script now.';
        }

        if (!is_writable(SITE_ROOT . '/views/cache')) {
            $statuses[] = 'The /views/cache directory is not writable. This needs to be updated.';
        }

        if (!is_writable(SITE_ROOT . '/web_app.log')) {
            $statuses[] = 'The log file (/web_app.log) is not writable. This needs to be updated.';
        }

        return self::template('home.html.twig', array(
            'statuses' => $statuses,
        ));
    }
}
?>
