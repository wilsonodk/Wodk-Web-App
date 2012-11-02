# Wodk Web App #

A PHP/JS web application framework starter kit.

Version 1.0.3

I like to build small simple web apps. Everytime I find myself having to bring 
together all the various files, and build the directory stucture. This project
is about doing that tedious work for me.

## Requirements ##

* PHP >= 5.2.4
* MySQL >= 5.0.1
* Ruby 1.8.7 (for build script)

## What's Installed ##

* [Limonade][] -- A PHP microframework. (version 0.5.0)
* [Twig][] -- A PHP templating engine. (version 1.10.0)
* [Backbone.js][] -- A MVCish framework for JavaScript (version 0.9.2)
* [jQuery][] -- The jQuery Library (version 1.7.2)
* [Underscore.js][] -- A utility JavaScript library (version 1.3.3)
* Wodk/MyDB -- A personal extension to MySQLi, details below (version 1.0.0)
* Wodk/Logger -- A personal logger, detail below (version 1.0.0)
* Wodk/TwigFilters -- A personal extension to Twig, details below (version 1.0.0)

### What It Looks Like ###

	├── .htaccess
	├── index.php
	├── routes.php
	├── web_app.log
	├── controllers
	│   └── AppController.php
	│   └── MainController.php
	│   └── ...
	├── public
	│   └── backbone-min.js
	│   └── jquery-1.7.2.min.js
	│   └── main.css
	│   └── underscore-min.js
	│   └── ...
	├── vendor
	│   └── limonade
	│   └── Twig
	│   └── Wodk
	│   └── ...
	└── views
		└── cache
			└── ...
		└── template
			└── base.html.twig
			└── home.html.twig
			└── macros.twig
			└── ...
        
## How to Use ##

1. Clone the git repo (git clone https://github.com/wilsonodk/Wodk-Web-App.git myapp)
2. Run `./build.rb`, follow the prompts
3. Load the site in a browser, fix any issues you find
4. ???
5. Profit!

### What Information You'll Need ###

* Site Name
> A human readable site name
	
* Base URI
> The URI where the app is being loaded;  
> For URL: `http://example.com/myApp`, the Base URI is: `/myApp/`  

* MySQL Info
> Host name  
> Port  
> Database name  
> User  
> Password  
> Socket  
> Database table name prefix  

### Building: From Route to Controller to Template ###

Let's say you want to render a page at `http://www.example.com/myapp/about`. This assumes that your base URI is `/myapp`.

In `routes.php` setup your routing information:

```php
// GET /about
dispatch('/about', 'MainController::about');
```
In `controllers/MainController.php` create your handler method:

```php
class MainController extends AppController
{
	static function about() {
		return self::template("about.html.twig", array(
			"some_data" => "Some data."
		));
	}
}
```

In `views/templates/about.html.twig` create your template code

```django
{% extends "base.html.twig" %}

{% block head %}
	{{ parent() }}
{% endblock %}

{% block content %}
	{{ parent() }}
	<p>{{ some_data }}</p>
{% endblock %}
```

## Change Log ##

* 1.0.3
> _Released November 1, 2012_
> Improved default template example. Now the head block uses inheritance.

* 1.0.2
> _Released November 1, 2012_
> Improved initial run of the web app.

* 1.0.1
> _Released October 31, 2012_
> Fixes for build script.

* 1.0.0
> _Released October 31, 2012_
> Initial update.

* * * 

## Wodk Classes ##

### MyDB ###

A subclass of [MySQLi][]. It includes a few helper methods that assist with query formatting. Query formatting allows
for a statement to be written like `SELECT * FROM {{table}} WHERE id = %s`, then transformed into `SELECT * FROM myapp_table WHERE id = 1`.

* qry
> This will execute a SQL statement, but is extended to take arguments ala [sprintf][]  
> @param The first argument is the SQL statement.  
> @params The following arguments are items to be formatted into the SQL statement.  
> @return The query with all argments formatted.  

* getInsertId
> @return Returns the insert id from the last INSERT query

* setPrefix
> Will set the prefix to be used when formatting a query. Will determine if we need to use a prefix based on what is passed in.  
> @param $prefix A string to use a the prefix for tables in SQL statements.  
> @return The instance for chaining.  

* setPrefixPattern
> Set the Regular Expression to used for prefix replacement. The default RegEx is `'/{{(\w+)}}/'`. See [preg_replace][] for more information.  
> @param $pattern A string of a RegEx pattern.  
> @return The instance for chaining.  

* setQuery
> Set a "prepared" query for use later.   
> @param The name of the query for use later.  
> @param The SQL query  
> @params The arguments to be formatted into the query  
> @return The instance for chaining.  

* unsetQuery
> Delete a "prepared" query.  
> @param $name The name of the query to remove.  
> @return The instance for chaining.  

* getQuery
> Get a "prepared" query.  
> @param $name The name of the query to return.  
> @return The formatted query.  

* useQuery
> Call a previously "prepared" query.  
> @param $name The name of the query to use.  

* formatQuery
> Public "interface" for prepareQuery  
> @param The SQL query  
> @params The arguments to be formatted into the query  
> @return Formatted query  

* prepareQuery
> Do the formatting of a query.  
> @param $args An array of items to format. First item is the SQL statement. Remaining items are to be formatted into SQL statement.  
> @return The formatted query.  

### Logger ###

A simple logging class. The purpose of this class is to provide a simple log file that can then be displayed to an administrative user of the web app.

* log
> Record a particular message in the file. There are two ways to use it, simple or complex.  
> Simple logging takes one argument, the log message. The resulting entry is `[timestamp] message`.  
> Complex logging takes at least two arguments. The first is the "type" of message. The remaining arguments are messages to log with that "type".  
> The output of complex looks like `[timestamp] (type) message` for every `message` argument passed in.  

* read
> Get the contents of the log, useful for passing from a Controller to a View.  
> @param $as_array Return the log file as a string or an array. Defaults to string.  
> @param $reverse What order to return the array. The default is oldest first.  
> @return Either an array or string of the log file.  

### TwigFilters ###

Two simple extensions to the [Twig][] template language.

* one_space 
> Converts all multi-spaces inside a string to a single string. This is really to cleanup the output of a Twig template. Very handy for whitespace sensive contexts.

* log_style
> Style a single line of Wodk/Logger output. Great for complex output. The `timestamp` is given the class stamp. The `message` is given the class of `type`.

[MySQLi]: http://us1.php.net/manual/en/book.mysqli.php
[sprintf]: http://us1.php.net/manual/en/function.sprintf.php
[Limonade]: https://github.com/sofadesign/limonade
[Twig]: http://twig.sensiolabs.org/
[jQuery]: http://jquery.com/
[Backbone.js]: http://documentcloud.github.com/backbone/
[Underscore.js]: http://documentcloud.github.com/underscore/
[preg_replace]: http://php.net/manual/en/function.preg-replace.php
