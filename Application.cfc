component output="false"
{
    this.name = "CFShoutout";
    this.applicationTimeout = createTimespan(0,2,0,0);
    this.mappings["/contest"] = getDirectoryFromPath(getCurrentTemplatePath());
    
    this.wschannels = [{name="shoutout", cfclistener="ShoutoutSocketService"}]; 

    // REST Settings
    this.restsettings.skipCFCWithError = true; 

    
    // ORM SETUP
    this.ormEnabled = "true"; 
    this.ormSettings.datasource = "cfshoutout"; 
    this.ormsettings.cfclocation = "model";
    this.ormsettings.dbcreate = "update";
    this.ormsettings.searchenabled = "true"; 
    this.ormSettings.search.autoindex = "true"; 
    this.ormSettings.search.language = "English";
    this.ormsettings.search.indexDir = getDirectoryFromPath(getCurrentTemplatePath()) & "/ormindex";
    
    public boolean function onRequestStart()
    {

        if( structKeyExists( url, "ORMReload" ) ){
            ORMReload();
            ORMIndex(); 
        }

        if(structKeyExists(url, "initREST"))
        {
            restInitApplication(getDirectoryFromPath(getCurrentTemplatePath()),this.name);
        }
 
        return true;
    }

    function onWSRequestStart( type, channel, user ){

    }
}