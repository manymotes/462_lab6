ruleset trip_store {
  meta {
    name "track_tips"
    description <<
A first ruleset for the Quickstart
>>
    author "Phil Windley"
    logging on
    shares hello, trips, long_trips, short_trips
    provides trips, long_trips, short_trips
  }
  
  global {
    trips = function(){
     ent:trips.klog("trips: ");
     
    }
    long_trips = function(){
     ent:long_trips.klog("long trips: ");
     
    }  
    
    short_trips = function(){
     ent:trips.filter(function(x){x.values()[0]<1000}) 
    }
    
  
  }
  
  rule collect_trips {
    select when explicit processed_trip
    pre{
      length = event:attr("mileage")
     time_stamp = time:now()
    }
    
    
    
    always{
      ent:trips:=ent:trips.defaultsTo([]).append({}.put(time_stamp, length));
    }
  }
  
  rule collect_long_trips {
    select when explicit found_long_trip
    
     pre{
      length = event:attr("mileage")
     time_stamp = time:now()
    }
    
    
    
    always{
      ent:long_trips:=ent:long_trips.defaultsTo([]).append({}.put(time_stamp, length));
    }
  }
  
  rule clear_trips {
    select when car trip_reset
    
    always{
      ent:long_trips := [];
      ent:trips := [];
    }
  }
  
  
}
