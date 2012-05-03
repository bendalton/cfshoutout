About
========================

*CFShoutout* is an example application that utilizes some of the new Adobe ColdFusion 10 features.

Some of these include:
-   Restful Web Services
-   WebSocket Support
-   ORM Search (via Apache Solr)

It also leverages:
-   ESRI's JavaScrip APIs for Mapping
-   HTML5 GeoLocation features
-   Twitter Bootstrap for layout and styling
-   Bootswatch.com's "Superhero" CSS Styles


Disclaimer
--------------------
This code is FAR from production-worthy and is likely to include some bad-practices or ugly workarounds. Please forgive me! Use this at your own risk. If you would like to make a suggestion, please email me directly or submit a pull request and I will incorporate it into the code: bendalton@gmail.com

Usage
--------------------
1. Install/Configure CF10
2. Create a datasource called "cfshoutout"
3. Upload code the the appropriate location in your wwwroot (in my case it was /contest)
4. visit your application and add ?initREST&ORMReload to the URL to create the database tables and initialize the webservice


Licenses and Acknowledgements
---------------------
The content included in this project is free-to-use for any purpose you feel fit. Portions of this project are licensed separately so please refer to any appended license, if one exists, for a given file.

Portions of this project can be attributed to:

Twitter Bootstrap Project
http://twitter.github.com/bootstrap/
Code licensed under the Apache License v2.0. Documentation licensed under CC BY 3.0.
Icons from Glyphicons Free, licensed under CC BY 3.0.

ESRI JavaScript API
http://help.arcgis.com/en/webapi/javascript/arcgis/
License Agreement: http://help.arcgis.com/en/webapi/javascript/arcgis/help/jshelp_termsofuse.htm

Bootswatch.com "Superhero" Twitter Bootstrap Theme
http://bootswatch.com/

Insipration and examples were drawn from:
http://blog.dkferguson.com/index.cfm/2012/2/17/ColdFusion-10-WebSockets-Demo-App
http://www.boyzoid.com/blog/index.cfm/2012/2/17/ColdFusion-10--ORM-Search
http://www.anujgakhar.com/2012/02/20/using-rest-services-in-coldfusion-10/


