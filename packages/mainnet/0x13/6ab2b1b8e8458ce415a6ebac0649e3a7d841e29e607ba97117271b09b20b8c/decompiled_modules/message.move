module 0x136ab2b1b8e8458ce415a6ebac0649e3a7d841e29e607ba97117271b09b20b8c::message {
    struct Message has copy, drop {
        bridge: 0x136ab2b1b8e8458ce415a6ebac0649e3a7d841e29e607ba97117271b09b20b8c::bridge::Bridge,
        chain_id: u32,
        destination: address,
        payload: vector<u8>,
        extra: vector<u8>,
        sender: address,
    }

    public fun bridge(arg0: Message) : 0x136ab2b1b8e8458ce415a6ebac0649e3a7d841e29e607ba97117271b09b20b8c::bridge::Bridge {
        arg0.bridge
    }

    public fun chain_id(arg0: Message) : u32 {
        arg0.chain_id
    }

    public fun destination(arg0: Message) : address {
        arg0.destination
    }

    public fun extra(arg0: Message) : vector<u8> {
        arg0.extra
    }

    public fun payload(arg0: Message) : vector<u8> {
        arg0.payload
    }

    public fun sender(arg0: Message) : address {
        arg0.sender
    }

    // decompiled from Move bytecode v6
}

