public with sharing class factualAPI {
	public static String BASE_URL = 'http://api.v3.factual.com/t/';
		//http://api.v3.factual.com/t/restaurants-us?geo=%7B%22%24circle%22%3A%7B%22%24center%22%3A%5B33.7550%2C%20-84.387314%5D%2C%22%24meters%22%3A%202500%7D%7D&offset=20&limit=20&KEY=OeKwrTC4THanEPqpLb8hI5v4ZFR0qx2Pu2GjyBRn
    
	//Method to perform a callout and return an httpResponse
	public static httpResponse callout(String httpMethod, String endpoint, String body){
		//Instantiate an httpRequest and set the required attributes
		httpRequest req = new httpRequest();
		req.setMethod(httpMethod);
		req.setEndpoint(endpoint);

		//Optional attributes are often required to conform to the 3rd Party Web Service Requirements
		req.setHeader('Accept-Encoding','gzip, deflate');

		//You can adjust the timeout duration (in milliseconds) to deal with slow servers or large payloads
		req.setTimeout(120000);

		//Use the HTTP Class to send the httpRequest and receive an httpResposne
		/*If you are not using an HttpCalloutMock: 
		if (!test.isRunningTest){
		*/
		httpResponse res = new http().send(req);
		/*If you are not using an HttpCalloutMock: 
		}
		*/
		system.debug(res.toString());
		system.debug(res.getBody());
		return res;
	}

	//Method to deserialize the response body
	public static responseResource deserialize(httpResponse res){
		return (responseResource)JSON.deserialize(res.getBody(),responseResource.class);
	}

/********************* Apex Inner Classes to represent Factual objects ***********************/

	public class Response {
		public List<Data> data;
		public Integer included_rows;
	}

	public Integer version;
	public String status;
	public Response response;

	public class Hours {
		public List<List<String>> monday;
		public List<List<String>> tuesday;
		public List<List<String>> wednesday;
		public List<List<String>> thursday;
		public List<List<String>> friday;
		public List<List<String>> saturday;
	}

	public class Data {
		public Boolean accessible_wheelchair;
		public String address;
		public Boolean alcohol;
		public Boolean alcohol_bar;
		public Boolean alcohol_beer_wine;
		public Boolean alcohol_byob;
		public String attire;
		public List<Integer> category_ids;
		public List<List<String>> category_labels;
		public String country;
		public List<String> cuisine;
		public String email;
		public String factual_id;
		public String fax;
		public Boolean groups_goodfor;
		public Hours hours;
		public String hours_display;
		public Boolean kids_goodfor;
		public Double latitude;
		public String locality;
		public Double longitude;
		public Boolean meal_breakfast;
		public Boolean meal_cater;
		public Boolean meal_deliver;
		public Boolean meal_dinner;
		public Boolean meal_lunch;
		public Boolean meal_takeout;
		public String name;
		public List<String> neighborhood;
		public Boolean open_24hrs;
		public Boolean options_healthy;
		public Boolean options_vegan;
		public Boolean options_vegetarian;
		public Boolean parking;
		public Boolean parking_free;
		public Boolean parking_garage;
		public Boolean parking_lot;
		public Boolean parking_street;
		public Boolean parking_valet;
		public Boolean payment_cashonly;
		public String postcode;
		public Integer price;
		public Integer rating;
		public String region;
		public Boolean reservations;
		public Boolean seating_outdoor;
		public String tel;
		public String website;
		public Boolean wifi;
		public Double distance;
		public Boolean options_glutenfree;
		public Boolean smoking;
		public String address_extended;
		public List<String> attire_required;
		public Boolean room_private;
		public Boolean parking_validated;
		public Boolean options_lowfat;
		public String chain_id;
		public String chain_name;
		public String founded;
		public String owner;
		public Boolean kids_menu;
	}

	public class Hours_Z {
		public List<List<String>> monday;
		public List<List<String>> tuesday;
		public List<List<String>> wednesday;
		public List<List<String>> thursday;
		public List<List<String>> friday;
		public List<List<String>> saturday;
		public List<List<String>> sunday;
	}

	
    
    
    
    
    
    
    
    
    
    
    
    
    //Outermost class included in the response from Factual
	public class responseResource {
		public Integer version {get;set;}
		public String status {get;set;}
		public List<resturantResource> data {get;set;}
	}

	//Class to represent a Resturant posted on Factual
	public class dataResource {
        //public Integer included_rows {get;set;}
        //public List<resturantResource> data {get;set;}
	}
    
    public class resturantResource {
        public String name {get;set;}
        public String address {get;set;}
        public String tel {get;set;}
    }

    

/********************* Other Useful Methods ***********************/

	// http://api.v3.factual.com/t/restaurants-us?geo=%7B%22%24circle%22%3A%7B%22%24center%22%3A%5B33.7550%2C%20-84.387314%5D%2C%22%24meters%22%3A%202500%7D%7D&offset=20&limit=20&KEY=OeKwrTC4THanEPqpLb8hI5v4ZFR0qx2Pu2GjyBRn
    public static responseResource questions_Unanswered(String site, String latitude, String longitude, String range, Integer offset, Integer resp_limit, String key ){
		httpResponse res = callout('GET', compileEndpoint('restaurants-us',site,latitude,longitude,range,offset,resp_limit,key) , null);
		if ( res.getStatusCode() == 200 && string.isNotBlank(res.getBody()) ){
			return deserialize(res);
		}
		return null;
	}

	public static String compileEndpoint(String call, String site, String latitude, String longitude, String range, Integer offset, Integer resp_limit, String key ){
		//Integer pagesize, Date fromdate, Date todate, String order, Date min, Date max, String sortParam, String tagged
        PageReference endpoint = new PageReference(BASE_URL+call);
		if ( string.isNotBlank(site) ){
			//endpoint.getParameters().put('site',site);	
        }
		if ( string.isNotBlank(longitude) ){
			
            endpoint.getParameters().put('geo','{"$circle":{"$center":[' + latitude + ', ' + longitude + '],"$meters": ' + range + '}}');
        }
		if ( offset != null ){
			endpoint.getParameters().put('offset',string.valueOf(offset));
		}
        if ( resp_limit != null ){
			endpoint.getParameters().put('limit',string.valueOf(resp_limit));
		}
        if ( string.isNotBlank(key) ){
			endpoint.getParameters().put('KEY',key);
		}
        
		return endpoint.getURL();
    }
}