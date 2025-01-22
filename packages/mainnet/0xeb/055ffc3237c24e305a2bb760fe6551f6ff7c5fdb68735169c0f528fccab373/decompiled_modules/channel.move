module 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel {
    struct Channel has store, key {
        id: 0x2::object::UID,
    }

    struct ApprovedMessage {
        source_chain: 0x1::ascii::String,
        message_id: 0x1::ascii::String,
        source_address: 0x1::ascii::String,
        destination_id: address,
        payload: vector<u8>,
    }

    public fun id(arg0: &Channel) : 0x2::object::ID {
        0x2::object::id<Channel>(arg0)
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : Channel {
        let v0 = 0x2::object::new(arg0);
        0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::events::channel_created(0x2::object::uid_to_address(&v0));
        Channel{id: v0}
    }

    public fun consume_approved_message(arg0: &Channel, arg1: ApprovedMessage) : (0x1::ascii::String, 0x1::ascii::String, 0x1::ascii::String, vector<u8>) {
        let ApprovedMessage {
            source_chain   : v0,
            message_id     : v1,
            source_address : v2,
            destination_id : v3,
            payload        : v4,
        } = arg1;
        assert!(v3 == 0x2::object::id_address<Channel>(arg0), 9223372462056538113);
        (v0, v1, v2, v4)
    }

    public(friend) fun create_approved_message(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: address, arg4: vector<u8>) : ApprovedMessage {
        ApprovedMessage{
            source_chain   : arg0,
            message_id     : arg1,
            source_address : arg2,
            destination_id : arg3,
            payload        : arg4,
        }
    }

    public fun destroy(arg0: Channel) {
        let Channel { id: v0 } = arg0;
        0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::events::channel_destroyed(0x2::object::uid_to_address(&v0));
        0x2::object::delete(v0);
    }

    public fun to_address(arg0: &Channel) : address {
        0x2::object::id_address<Channel>(arg0)
    }

    // decompiled from Move bytecode v6
}

