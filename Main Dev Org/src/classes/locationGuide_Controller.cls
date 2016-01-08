public class locationGuide_Controller {
    
    public String requestLatitude {get;set;}
    public String requestLongitude {get;set;}
    public String selectedRange {get;set;}
    public String requestEndpoint {get;set;}
    public String responseBody {get;set;}
    public String requestBody {get;set;}
    public String responseStatus {get;set;}
	public Integer responseStatusCode {get;set;}
	public List<Object> deserializedResturants {get;set;}
    
    public locationGuide_Controller(){
		requestLatitude='33.7550';
		requestLongitude='-84.387314';
    }
    
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('100','Small'));
        options.add(new SelectOption('500','Medium'));
        options.add(new SelectOption('5000','Large'));
        return options;
    }
    
    public void findTheResturants(){
		
			requestEndpoint = factualAPI.compileEndpoint(
			'restaurants-us',
			'salesforce',
			requestLatitude,//'33.7550',
            requestLongitude,//'-84.387314',
			selectedRange,//'2500',
             20,
             20,
            'OeKwrTC4THanEPqpLb8hI5v4ZFR0qx2Pu2GjyBRn'
		);
		
		httpResponse res = factualAPI.callout('GET', requestEndpoint, requestBody);
		responseStatus = res.getStatus();
		responseStatusCode = res.getStatusCode();
		responseBody = res.getBody();
		
		if ( string.isNotBlank(responseBody) ){	
			Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(responseBody);
            Map<String, Object> response = (Map<String, Object>) results.get('response');
            deserializedResturants = (List<Object>) response.get('data');
		}

    }

}