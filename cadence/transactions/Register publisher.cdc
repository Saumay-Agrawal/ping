import Ping from 0x01

transaction {
  
  prepare(acct: AuthAccount) {

    Ping.addPublisher(pub_address: acct.address)
    
  }

  execute {
    
  }

}