pub contract Ping {

    // address registry
    pub var registry: {Address: {Address: Bool}}

    pub var messageID: UInt64
    
    // message resource
    pub resource Message {
        
        pub let id: UInt64
        pub var content: String
        pub var sender: Address
        pub var recipient: Address
        pub var broadcast: Bool

        // Initialize message
        init(initID: UInt64, content: String, sender: Address, recipient: Address, broadcast: Bool) {
            self.id = initID
            self.content = content
            self.sender = sender
            self.recipient = recipient
            self.broadcast = broadcast
        }

        pub fun logMessage(): Void {
            log("Message details:")
            log(self.id)
            log(self.content)
            log(self.sender)
            log(self.recipient)
            log(self.broadcast)
        }
    }

    //inbox resource
    pub resource Inbox {

        pub var messages: @{UInt64: Message}

        init() {
            self.messages <- {}
        }

        destroy() {
            destroy self.messages
        }

        pub fun removeMessage(messageId: UInt64): @Message {
            let message <- self.messages.remove(key: messageId)
                ?? panic("Message does not exists")
            return <- message
        }

        pub fun saveMessage(message: @Message) {
            self.messages[message.id] <-! message
        } 

        pub fun getMessages(): [UInt64] {
            return self.messages.keys
        }

        pub fun viewMesssage(messageId: UInt64): &Message {
            return (&self.messages[messageId] as &Message?)!
        }

    }

    // constructor
    init() {
        self.messageID = 0
        self.registry = {}
    }

    // utility functions

    // function to create a new message
    pub fun createMessage(content: String, sender: Address, recipient: Address, broadcast: Bool): @Message {
        self.messageID = self.messageID + 1
        return <-create Message(initID: self.messageID, content: content, sender: sender, recipient: recipient, broadcast: broadcast)
    }

    pub fun createInbox(): @Inbox {
        return <- create Inbox()
    }

    pub fun isPublisher(pub_address: Address): Bool {
        return self.registry.containsKey(pub_address)
    }

    pub fun addPublisher(pub_address: Address): Void {
        self.registry.insert(key: pub_address, {})
        log("New publisher added.")
        log(pub_address)
        log(self.registry)
    }

    pub fun removePublisher(pub_address: Address): Void {
        self.registry.remove(key: pub_address)
        log("Publisher removed.")
        log(pub_address)
        log(self.registry)
    }

    pub fun isSubscriber(pub_address: Address, sub_address: Address): Bool {
        
        if self.registry[pub_address]?.containsKey(sub_address) == true {
            return true
        }
        return false
    }

    pub fun subscribe(pub_address: Address, sub_address: Address): Void {

        if pub_address == sub_address {
            log("Publisher can't be subscriber")
            return
        }
        
        if self.isSubscriber(pub_address: pub_address, sub_address: sub_address) {
            log("Already a subscriber")
            return
        }
        
        if self.isPublisher(pub_address: pub_address) {
            self.registry[pub_address]?.insert(key: sub_address, true)
            log("New subscriber added.")
            log(pub_address)
            log(sub_address)
            log(self.registry)
            return
        }
        
        log("Unknown error")
        
    }

    pub fun unsubscribe(pub_address: Address, sub_address: Address): Void {
        
        if self.isSubscriber(pub_address: pub_address, sub_address: sub_address) == false {
            log("Not a subscriber")
            return
        }
        
        if self.isPublisher(pub_address: pub_address) {
            self.registry[pub_address]?.remove(key: sub_address)
            log("Subscriber removed.")
            log(pub_address)
            log(sub_address)
            log(self.registry)
            return
        }

        log("Unknown error")
    
    }

    
}
