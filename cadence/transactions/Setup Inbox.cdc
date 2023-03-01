import Ping from 0x01

transaction {
  
  prepare(acct: AuthAccount) {
    
    acct.save(<- Ping.createInbox(), to: /storage/MyInbox)

    acct.link<&Ping.Inbox>(/public/MyInbox, target: /storage/MyInbox)

  }

  execute {
    log("Inbox setup successful.")
  }

}