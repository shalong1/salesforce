public with sharing class factualViewer_Controller {
	
	public String requestEndpoint {get;set;}
	public String requestMethod {get;set;}
	public String requestBody {get;set;}
	public String responseStatus {get;set;}
	public Integer responseStatusCode {get;set;}
	public String responseBody {get;set;}
	public factualAPI.Response response {get;set;}
	public List<Object> deserializedResturants {get;set;}
	
	public factualViewer_Controller(){
		requestEndpoint = factualAPI.compileEndpoint(
			'restaurants-us',
			'salesforce',
			'33.7550',
            '-84.387314',
			'2500',
             20,
             20,
            'OeKwrTC4THanEPqpLb8hI5v4ZFR0qx2Pu2GjyBRn'
		);
	}

	public void callout(){
		httpResponse res = factualAPI.callout(requestMethod, requestEndpoint, requestBody);
		responseStatus = res.getStatus();
		responseStatusCode = res.getStatusCode();
		responseBody = res.getBody();
	}
	
	public void deserializeTheResturants(){
		if ( string.isNotBlank(responseBody) ){
			//response = (factualAPI.responseResource)JSON.deserialize(responseBody,factualAPI.responseResource.class);
			//response = (factualAPI.Response) System.JSON.deserialize(responseBody, factualAPI.Response.class);
            
            //for(Integer a = 0; a < response.size(); a++){
  				//System.debug('Here are the results:' + responseBody);
			//}
			//
			
            //Http http = new Http();
            //HttpRequest req = new HttpRequest();
            //req.setEndpoint('http://api.v3.factual.com/t/restaurants-us?geo=%7B%22%24circle%22%3A%7B%22%24center%22%3A%5B33.7550%2C+-84.387314%5D%2C%22%24meters%22%3A+2500%7D%7D&KEY=OeKwrTC4THanEPqpLb8hI5v4ZFR0qx2Pu2GjyBRn&limit=20&offset=20');
            //req.setMethod('GET');
            //HttpResponse res = http.send(req);
            // If the request is successful, parse the JSON response.
            //if (res.getStatusCode() == 200) {
                // Deserializes the JSON string into collections of primitive data types.
                Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(responseBody);
                Map<String, Object> response = (Map<String, Object>) results.get('response');
                deserializedResturants = (List<Object>) response.get('data');
                //List<Object> data = (List<Object>) response.get('data');
                // 20 records
                //System.debug(data.size());
                // get the first restaurant's name
                //Map<String, Object> restaurant = (Map<String, Object>) data[0];
                //System.debug(restaurant.get('name'));
                // output all restaurants' names
                //for (Object record: data) {
                //    Map<String, Object> rec = (Map<String, Object>) record;
                //    System.debug(rec.get('name'));
                //}
            //}

            
            //testresponse obj = testresponse.parse(responseBody);
            //System.debug('Here are the results2:' + obj);
            //deserializedResturants = obj[1].data;
            //deserializedResturants = response.data;
            
		}	
	}
    
	
	public List<SelectOption> getMethodOptions(){
		List<SelectOption> options = new List<SelectOption>();
		options.add(new SelectOption('GET','GET'));
		options.add(new SelectOption('POST','GET'));
		options.add(new SelectOption('PUT','GET'));
		options.add(new SelectOption('DELETE','GET'));
		options.add(new SelectOption('HEAD','GET'));
		return options;
	}
}