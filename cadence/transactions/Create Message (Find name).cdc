import Ping from 0x01
import FIND from 0x35717efbbce11c74

transaction (message: String, sub_name: String) {

  prepare(acct: AuthAccount) {

    let sub_address = FIND.lookupAddess(sub_name)
    
    if Ping.isSubscriber(pub_address: acct.address, sub_address: sub_address) {

        let newMessage <- Ping.createMessage(content: message, sender: acct.address, recipient: sub_address, broadcast: false)
        newMessage.logMessage()

        let inbox = acct.borrow<&Ping.Inbox>(from: /storage/MyInbox)
            ?? panic("Inbox doesn't exists")
        
        inbox.saveMessage(message: <- newMessage)

        log("Message created & saved successfully")

    } else {

        log("Message could not be created. Permission error")

    }
  }

  execute {
    log("-")
  }

}