import Ping from 0x01

transaction (messageId: UInt64) {
  
  prepare(acct: AuthAccount) {
    
    let inbox = acct.borrow<&Ping.Inbox>(from: /storage/MyInbox)
        ?? panic("Inbox doesn't exists")

    let message: &Ping.Message = inbox.viewMesssage(messageId: messageId)

    message.logMessage()

  }

  execute {
    
  }

}