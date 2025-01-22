module 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::message_ticket {
    struct MessageTicket {
        source_id: address,
        destination_chain: 0x1::ascii::String,
        destination_address: 0x1::ascii::String,
        payload: vector<u8>,
        version: u64,
    }

    public fun destination_address(arg0: &MessageTicket) : 0x1::ascii::String {
        arg0.destination_address
    }

    public fun destination_chain(arg0: &MessageTicket) : 0x1::ascii::String {
        arg0.destination_chain
    }

    public(friend) fun destroy(arg0: MessageTicket) : (address, 0x1::ascii::String, 0x1::ascii::String, vector<u8>, u64) {
        let MessageTicket {
            source_id           : v0,
            destination_chain   : v1,
            destination_address : v2,
            payload             : v3,
            version             : v4,
        } = arg0;
        (v0, v1, v2, v3, v4)
    }

    public(friend) fun new(arg0: address, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: vector<u8>, arg4: u64) : MessageTicket {
        MessageTicket{
            source_id           : arg0,
            destination_chain   : arg1,
            destination_address : arg2,
            payload             : arg3,
            version             : arg4,
        }
    }

    public fun payload(arg0: &MessageTicket) : vector<u8> {
        arg0.payload
    }

    public fun source_id(arg0: &MessageTicket) : address {
        arg0.source_id
    }

    public fun version(arg0: &MessageTicket) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

