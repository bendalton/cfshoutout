<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>CFShoutout</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

	 <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>

    <script src="assets/js/bootstrap.min.js"></script>

  	<link rel="stylesheet" type="text/css" href="http://serverapi.arcgisonline.com/jsapi/arcgis/2.8/js/dojo/dijit/themes/claro/claro.css">
    
    <link rel="stylesheet" type="text/css" href="http://serverapi.arcgisonline.com/jsapi/arcgis/2.8/js/esri/dijit/css/Popup.css">
    
    <link href="assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/css/bootstrap-responsive.css" rel="stylesheet">
    <style type="text/css">
      body {
        padding-top: 60px;
        padding-bottom: 40px;
      }
    </style>

    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

	<script>


  var restfulURL = "/rest/CFShoutout/shoutouts.json"


	function geolocateSuccess(result){
		$(':input[name=lat]').val(result.coords.latitude);
		$(':input[name=lng]').val(result.coords.longitude);
	}

	function geolocateError(error){
		// do nothing here, have default location
	}

	if (navigator.geolocation) {
	  navigator.geolocation.getCurrentPosition(geolocateSuccess, geolocateError);
	}

	var clientid;
	function onWSMessage(message){

		if (message.type == "response" && !clientid) {
	        clientid = message.clientid;    
	    }

	    if (message.type == "data") {
	        var data = JSON.parse(message.data);        
	        if(data.EVENT && data.EVENT === "newUserShoutout")
	        {
	        	addShoutout(data.SHOUTOUT);
	        }
	    }
	}

	function addShoutout(shoutout){
		drawShoutout(shoutout);
	}

	function showShoutForm(){
		$('#shoutModal').modal();
	}

	function sendShoutout(){
		$('#shoutModal').modal('hide');

		$.ajax({
		  type: 'POST',
		  url: restfulURL,
		  data: {content:$(':input[name=content]').val(),lat:$(':input[name=lat]').val(),lng:$(':input[name=lng]').val()}
		});
	}

	function getCurrentShoutouts(){
		$.ajax({
		  url: restfulURL,
		  dataType: 'json',
		  success: onCurrentShoutoutResults
		});
	}

	function onCurrentShoutoutResults(result,resultA){
		for(var i=0;i<result.length;i++)
		{
			addShoutout(result[i]);
		}
	}

	$(function(){
		$(".shoutButton").click(showShoutForm);
		$(".shoutSend").click(sendShoutout);
		
	});

	</script>

	<script type="text/javascript" src="http://serverapi.arcgisonline.com/jsapi/arcgis/?v=2.8">
    </script>

    <script type="text/javascript">
      dojo.require("dijit.dijit"); 
      dojo.require("dijit.layout.BorderContainer");
      dojo.require("dijit.layout.ContentPane");
      dojo.require("esri.map");
      dojo.require("esri.IdentityManager");
      dojo.require("esri.arcgis.utils");
        
      var map;

      function init() {
      
        map = new esri.Map("map");
       	map.addLayer(new esri.layers.ArcGISTiledMapServiceLayer("http://services.arcgisonline.com/ArcGIS/rest/services/Canvas/World_Light_Gray_Base/MapServer"));

 		dojo.connect(map, 'onLoad', function(theMap) { 
          //resize the map when the browser resizes
          dojo.connect(dijit.byId('map'), 'resize', map,map.resize);
          getCurrentShoutouts();
        });
      }


      function resizeMap() {
        var resizeTimer;
        clearTimeout(resizeTimer);
        resizeTimer = setTimeout(function() {
          map.resize();
          map.reposition();
        }, 500);
      }

      function drawShoutout(shoutout){
      	var infoTemplate = new esri.InfoTemplate("Shoutout!", "Message: ${content}");
        var symbol = new esri.symbol.SimpleMarkerSymbol(esri.symbol.SimpleMarkerSymbol.STYLE_CIRCLE, 15, new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_SOLID, new dojo.Color([0,0,255]), 2), new dojo.Color([0,0,255]));

        var point = new esri.geometry.Point(shoutout.lng, shoutout.lat);
        var location = esri.geometry.geographicToWebMercator(point);
        var graphic = new esri.Graphic(location, symbol, shoutout, infoTemplate);
        map.graphics.add(graphic);
        
        map.infoWindow.setTitle(graphic.getTitle());
        map.infoWindow.setContent(graphic.getContent());
        
        //display the info window with the address information
        var screenPnt = map.toScreen(location);
        map.infoWindow.resize(200,100);
        map.infoWindow.show(screenPnt,map.getInfoWindowAnchor(screenPnt));
     }

      //show map on load
      dojo.addOnLoad(init);
    </script>

	<cfwebsocket name="shoutoutWS" subscribeTo="shoutout" onMessage="onWSMessage">
  </head>

  <body>

    <div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container-fluid">
          
          <a class="brand" href="#"><b><i>&lt;CF&gt;</i> ShoutOut!</a>
          
          <div class="btn-group pull-right">
            <a class="btn btn-large shoutButton" href="#">
              <i class="icon-envelope"></i> Shout!
            </a>
          </div>
       </div>
      </div>
    </div>

    <div class="container-fluid">
      <div class="row-fluid">
       <div id="map"></div>
       </div>
    </div>


	<div class="modal" style="display:none" id="shoutModal">
		<div class="modal-header">
			<button class="close" data-dismiss="modal">×</button>
			<h3>Post a ShoutOut</h3>
			</div>
			<div class="modal-body">
				<form id="shoutForm" class="form-horizontal" action="/rest/CFShoutout/shoutouts" method="POST" onsubmit="return false;">
					<input type="hidden" name="lat" value="37.329407">
					<input type="hidden" name="lng" value="-121.895057">
					
					<fieldset>
				    <div class="control-group">
				      <label class="control-label" for="input01">Your message</label>
				      <div class="controls">
				        <textarea name="content" type="email"></textarea>
				        <p class="help-block">Type a brief message for display.</p>
				      </div>
				    </div>
				  </fieldset>
			</div>
			<div class="modal-footer">
			<input type="submit" class="shoutSend" value="Shout Out!">
			</form>	
		</div>
	</div>


	
  </body>
</html>
