import Ping from 0x01

transaction {
  
  prepare(acct: AuthAccount) {
    
    let inbox = acct.borrow<&Ping.Inbox>(from: /storage/MyInbox)
        ?? panic("Inbox doesn't exists")

    log(inbox.getMessages())

  }

  execute {
    
  }

}