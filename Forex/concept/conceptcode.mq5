//Forex Rates are till 5th decimal (1.00000) Hence, always 'double' !! 
// This is just a  Quick N Dirty snippet flow as a concept/mindmap
/* EA means Expert Advisor, a script that runs and keepts monitoring incoming price data 'tick',
  and takes action according to pre defined rules.*/
/*EAs would naturally execute at every tick without terminating. Scripts will terminate
 as soon as their appointed tasks are complete. Hence this will be an EA */  

int OnInit() // OnInit() runs once when script is loaded onto chart in MT5
  {  
/* For Script testing security, check if account is demo or LIVE, dont trade accidentally on Live, so, 
   make sure that the account is demo */ 
   if(AccountInfoInteger(ACCOUNT_TRADE_MODE)==ACCOUNT_TRADE_MODE_REAL) 
     { 
      Alert("Script operation is not allowed on a live account!"); 
      return(-1); // Stop further execution. 
     }  
   return(INIT_SUCCEEDED); //proceed if account is demo .. this all will be removed later for live trade.
  }

// Expert deinitialization function                                 |

/*void OnDeinit() // OnDeInit() runs once when script is removed from chart in MT5
  {
//OnDeinit is Not necessary or, This is used to collect some data when script / EA is removed, Error handling etc.
Print("Script Exited"); //Print() outputs to EA log. 
   
  }
// Now the important block of code below... 
// Expert Advisor tick function 
//This is what all happens when script is running on chart in MT5. */                                        

void OnTick() // OnTick() function works for every incoming tick (live price data) of Expert Advisor (EA)
  {
// Now, Check if already any orders are pending or open, if yes,  Warn  and EA should do nothing.
    
    if ({OrdersTotal()>0) // OrdersTotal() returns the number of market and pending orders.   
     { 
      Alert("Warning Pending or Open orders present..Cant Procede"); // If orders are present, EA should stop. 
     }
    else
     {
      double highestM5; //handle for high of last 10 5min candles 
      double lowestM5; //handle for low of last 10 5min candles 
     
      double dblHigh10[]; //array to hold high of last 10 5min candles
      double dblLow10[];  //array to hold low of last 10 5min candles
     
      ArraySetAsSeries (dblHigh10, true ); //setting both arrays as series means last closed-
      ArraySetAsSeries (dblLow10, true ); // -candle is now index 0 (array indexing is reversed) 
   
      highestM5 = CopyHigh(_Symbol, PERIOD_M5, 0, 10, dblHigh10);// populate dbleHigh10 array with High of Last 10 5 min candles
      lowestM5 = CopyLow(_Symbol, PERIOD_M5, 0, 10, dblLow10);  // populate dbleLow10 array with High of Last 10 5 min candles
              
      if(highestM5>0)  //check if highes got copied
      Print("High Copy success "); // :) Just checking if till now things have worked ! 
    
      if(lowestM5>0) //check if lows got copied
      Print("Low Copy success "); // same as above ! Just checking ! 
     
      if(highestM5-lowestM5<5) //checking if higest and lowest of last 10 5min candles is less than 5 points.
      Print("Consolidation found, Now Setting orders if None are Present..");  // if consolidation is found..follow orders related block..
      }         
     // send orders. 
     
             
     // Check account value, set pending BUY and SELL orders with X% of account value. This will be a user defined parameter (set by #property) 
     // 
  }    
      
     
       
