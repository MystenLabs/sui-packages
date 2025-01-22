module 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::message {
    struct Message has copy, drop, store {
        source_chain: 0x1::ascii::String,
        message_id: 0x1::ascii::String,
        source_address: 0x1::ascii::String,
        destination_id: address,
        payload_hash: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::Bytes32,
    }

    public(friend) fun hash(arg0: &Message) : 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::Bytes32 {
        let v0 = 0x2::bcs::to_bytes<Message>(arg0);
        0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::from_bytes(0x2::hash::keccak256(&v0))
    }

    public(friend) fun peel(arg0: &mut 0x2::bcs::BCS) : Message {
        Message{
            source_chain   : 0x1::ascii::string(0x2::bcs::peel_vec_u8(arg0)),
            message_id     : 0x1::ascii::string(0x2::bcs::peel_vec_u8(arg0)),
            source_address : 0x1::ascii::string(0x2::bcs::peel_vec_u8(arg0)),
            destination_id : 0x2::bcs::peel_address(arg0),
            payload_hash   : 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::peel(arg0),
        }
    }

    public(friend) fun command_id(arg0: &Message) : 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::Bytes32 {
        message_to_command_id(arg0.source_chain, arg0.message_id)
    }

    public(friend) fun message_to_command_id(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String) : 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::Bytes32 {
        let v0 = 0x1::ascii::into_bytes(arg0);
        0x1::vector::append<u8>(&mut v0, b"_");
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(arg1));
        0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::from_bytes(0x2::hash::keccak256(&v0))
    }

    public(friend) fun new(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: address, arg4: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::Bytes32) : Message {
        Message{
            source_chain   : arg0,
            message_id     : arg1,
            source_address : arg2,
            destination_id : arg3,
            payload_hash   : arg4,
        }
    }

    // decompiled from Move bytecode v6
}

