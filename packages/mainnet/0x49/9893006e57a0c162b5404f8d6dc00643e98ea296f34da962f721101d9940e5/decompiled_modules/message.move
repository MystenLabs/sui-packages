module 0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::message {
    struct Message has copy, drop {
        bridge: 0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::bridge::Bridge,
        chain_id: u32,
        destination: address,
        payload: vector<u8>,
        extra: vector<u8>,
        sender: address,
    }

    public fun bridge(arg0: Message) : 0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::bridge::Bridge {
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

