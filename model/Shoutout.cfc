component hint="Shoutout" persistent="true" indexable="true" autoindex="true" {

	property name="id" fieldType="id" generator="uuid";
	property name="content" indexable="true";

	property name="lat";
	property name="lng";

	property name="created" ormType="timestamp";

	function init(){
		setCreated(Now());
	}

	// workaround for odd serialization issues.
	remote function toStruct(){
		var s = {};
		s['id'] = getID();
		s['content'] = getContent();
		s['lat'] = getLat();
		s['lng'] = getLng();
		s['created'] = getCreated();
		return s;
	}

}