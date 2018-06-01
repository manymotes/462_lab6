ruleset track_trips {
  meta {
    name "track_tips"
    description <<
A first ruleset for the Quickstart
>>
    author "Phil Windley"
    logging on
    
    shares hello
  }
  
  global {
   long_trip = 1000;
  }
  
  rule process_trip {
    select when car new_trip
    pre{
      length = event:attr("mileage")
    }
    send_directive("trip", {"mileage": length})
    
    always{
      raise explicit event "trip_process" attributes event:attrs
    }
  }
  
  rule find_long_trips {
    select when explicit trip_process
     pre{
      length = event:attr("mileage")
     
    }
    
    if(length > long_trip) then 
      send_directive("trip", {"mileage is BIGGER": length})
    fired{
     
      raise explicit event "found_long_trip"
        attributes event:attrs;
        
    }
    
  }
  
  
}
