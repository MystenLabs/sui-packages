module 0xa2acc6992412439af93549eb5c65fd7d9ff4fab278b50c117777ab51e7527f20::message {
    struct Message has copy, drop {
        bridge: 0xa2acc6992412439af93549eb5c65fd7d9ff4fab278b50c117777ab51e7527f20::bridge::Bridge,
        chain_id: u32,
        destination: u32,
        payload: vector<u8>,
        extra: vector<u8>,
        sender: address,
    }

    public fun bridge(arg0: Message) : 0xa2acc6992412439af93549eb5c65fd7d9ff4fab278b50c117777ab51e7527f20::bridge::Bridge {
        arg0.bridge
    }

    public fun chain_id(arg0: Message) : u32 {
        arg0.chain_id
    }

    public fun destination(arg0: Message) : u32 {
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

