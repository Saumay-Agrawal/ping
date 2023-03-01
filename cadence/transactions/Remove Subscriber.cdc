import Ping from 0x01

transaction (pub_address: Address) {

  prepare(acct: AuthAccount) {
    Ping.unsubscribe(pub_address: pub_address, sub_address: acct.address)
  }

  execute {
    
  }

}