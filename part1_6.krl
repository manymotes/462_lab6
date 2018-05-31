ruleset track_tips {
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
   
  }
  
  rule response_trip {
    select when echo message
    pre{
      length = event:attr("mileage")
    }
    send_directive("trip", {"mileage": length})
  }
}
