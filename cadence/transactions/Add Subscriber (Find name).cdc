import Ping from 0x01
import FIND from 0x35717efbbce11c74

transaction (pub_name: String) {

  prepare(acct: AuthAccount) {
    let pub_address = FIND.lookupAddess(pub_name)
    Ping.subscribe(pub_address: pub_address, sub_address: acct.address)
  }

  execute {
    
  }

}