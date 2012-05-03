component extends="CFIDE.websocket.ChannelListener"
{

    public any function getAllSubscribersDetail(string channelName){

      retData.type =  'subInfo';
      retData.subscribers = WSgetSubscribers(arguments.channelName);
      WSPublish(arguments.channelName, retData);

      return true;  
    }

    public boolean function authenticate(String userName, String password, Struct connectionInfo)
    {   
       return true;
    }

    public boolean function allowSubscribe(Struct subscriberInfo)
    {
       return true;
    }

    public boolean function allowPublish(Struct publisherInfo)
    {
       return true;
    }

    public any function beforePublish( any message, Struct publisherInfo)
    {
      return message;
    }

    public boolean function canSendMessage(any message, Struct subscriberInfo, Struct publisherInfo)
    {
      return true;
    }

    public any function beforeSendMessage(any message, Struct subscriberInfo)
    {
      return message;
    }

    public function afterUnsubscribe(Struct subscriberInfo)
    {

    }
}