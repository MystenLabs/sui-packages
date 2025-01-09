module 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::messenger_protocol {
    struct MessengerProtocol has copy, drop {
        id: u8,
    }

    public fun allbridge() : MessengerProtocol {
        MessengerProtocol{id: 1}
    }

    public fun id(arg0: &MessengerProtocol) : u8 {
        arg0.id
    }

    public fun wormhole() : MessengerProtocol {
        MessengerProtocol{id: 2}
    }

    // decompiled from Move bytecode v6
}

