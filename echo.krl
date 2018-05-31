ruleset echo {
  meta {
    name "echo"
    description <<
      Playing with an echo endpoint
    >>
    author "Phil Windley"
    logging on
  }

  rule hello_world is active {
    select when echo hello
    send_directive("say", {"something":"Hello World"})
  }
 
  rule echo is active {
    select when echo message
      pre{
      m = event:attr("input")
    }
    
    //input re#(.*)# setting(m);
    
    send_directive("say", {"something":m})
  }
}
