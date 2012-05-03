component rest="true" restpath="shoutouts" {

	import model.Shoutout;

	remote Array function list() httpmethod="GET"
    {
        var resArray = [];
        var shouts = entityLoad('Shoutout');
        for(var shout in shouts)
            arrayAppend(resArray,shout.toStruct());
        return resArray;
    }  

    remote any function find(string searchString restargsource="Path") httpmethod="GET"  restpath="find/{searchString}"
    {
        var searchResult = ORMSearch(searchString&"*",'Shoutout',["content"]);
        if(searchResult.MaxTotalCount){
             // found some issues serializing the ORMSearch result via XML
             // also found some issues 
             var entities = [];
             for(var resEntity in searchResult.data)
             {
                arrayAppend(entities,resEntity.entity.toStruct());
             }
             return entities;
        }
        else{
            return [];
        }
    }

    remote any function read(string id restargsource="Path") httpmethod="GET" restpath="{id}"
    {
        var shout = entityLoad("Shoutout",id,true);
        return shout.toStruct();
    }  

    //  create a new shoutout from the page form
    remote any function create(
            required string content restargsource="Form",
            required numeric lat restargsource="Form",
            required numeric lng restargsource="Form") httpmethod="POST"
    {

        var contentValid = REFindNoCase(".*",content);
        var latValid = REFindNoCase("^-?\d+\.?\d?",lat);
        var lngValid = REFindNoCase("^-?\d+\.?\d?",lng);
      
        if(contentValid && latValid && lngValid)
        {
            var shout = entityNew('Shoutout');
            shout.setContent(content);
            shout.setLat(lat);
            shout.setLng(lng);
            entitySave(shout);
            ormFlush();

            // notify users of new shoutouts!
            WSPublish("shoutout",{event='newUserShoutout',shoutout=shout.toStruct()});

            return shout.toStruct();
        }
        else
        {
             throw(type="InvalidRequest", errorCode='503', detail='Invalid Data');            
        }

    }  
    
    // update
    // delete  

}