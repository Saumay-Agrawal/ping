import Ping from 0x01

transaction (messageId: UInt64) {

  prepare(acct: AuthAccount) {
    
    let sendersInbox = acct.borrow<&Ping.Inbox>(from: /storage/MyInbox)
        ?? panic("Inbox doesn't exists")

    let message <- sendersInbox.removeMessage(messageId: messageId)

    let recieversInbox = getAccount(message.recipient).getCapability(/public/MyInbox).borrow<&Ping.Inbox>()
        ?? panic("Inbox doesn't exists")

    recieversInbox.saveMessage(message: <- message)

  }

  execute {
    log("Message sent successfully")
  }

}