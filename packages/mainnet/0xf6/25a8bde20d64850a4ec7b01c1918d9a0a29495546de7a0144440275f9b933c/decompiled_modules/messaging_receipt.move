module 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_receipt {
    struct MessagingReceipt has copy, drop, store {
        guid: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32,
        nonce: u64,
        messaging_fee: 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee,
    }

    public fun messaging_fee(arg0: &MessagingReceipt) : &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee {
        &arg0.messaging_fee
    }

    public(friend) fun create(arg0: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg1: u64, arg2: 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee) : MessagingReceipt {
        MessagingReceipt{
            guid          : arg0,
            nonce         : arg1,
            messaging_fee : arg2,
        }
    }

    public fun guid(arg0: &MessagingReceipt) : 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32 {
        arg0.guid
    }

    public fun nonce(arg0: &MessagingReceipt) : u64 {
        arg0.nonce
    }

    // decompiled from Move bytecode v6
}

