module 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message {
    struct Message has copy, drop {
        version: u32,
        source_domain: u32,
        destination_domain: u32,
        nonce: u64,
        sender: address,
        recipient: address,
        destination_caller: address,
        message_body: vector<u8>,
    }

    public fun destination_caller(arg0: &Message) : address {
        arg0.destination_caller
    }

    public fun destination_domain(arg0: &Message) : u32 {
        arg0.destination_domain
    }

    public fun from_bytes(arg0: &vector<u8>) : Message {
        validate_raw_message(arg0);
        Message{
            version            : 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::deserialize::deserialize_u32_be(arg0, 0, 4),
            source_domain      : 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::deserialize::deserialize_u32_be(arg0, 4, 4),
            destination_domain : 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::deserialize::deserialize_u32_be(arg0, 8, 4),
            nonce              : 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::deserialize::deserialize_u64_be(arg0, 12, 8),
            sender             : 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::deserialize::deserialize_address(arg0, 20, 32),
            recipient          : 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::deserialize::deserialize_address(arg0, 52, 32),
            destination_caller : 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::deserialize::deserialize_address(arg0, 84, 32),
            message_body       : 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::vector_utils::slice<u8>(arg0, 116, 0x1::vector::length<u8>(arg0)),
        }
    }

    public fun message_body(arg0: &Message) : vector<u8> {
        arg0.message_body
    }

    public fun new(arg0: u32, arg1: u32, arg2: u32, arg3: u64, arg4: address, arg5: address, arg6: address, arg7: vector<u8>) : Message {
        Message{
            version            : arg0,
            source_domain      : arg1,
            destination_domain : arg2,
            nonce              : arg3,
            sender             : arg4,
            recipient          : arg5,
            destination_caller : arg6,
            message_body       : arg7,
        }
    }

    public fun nonce(arg0: &Message) : u64 {
        arg0.nonce
    }

    public fun recipient(arg0: &Message) : address {
        arg0.recipient
    }

    public fun sender(arg0: &Message) : address {
        arg0.sender
    }

    public fun serialize(arg0: &Message) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::serialize::serialize_u32_be(arg0.version));
        0x1::vector::append<u8>(&mut v0, 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::serialize::serialize_u32_be(arg0.source_domain));
        0x1::vector::append<u8>(&mut v0, 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::serialize::serialize_u32_be(arg0.destination_domain));
        0x1::vector::append<u8>(&mut v0, 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::serialize::serialize_u64_be(arg0.nonce));
        0x1::vector::append<u8>(&mut v0, 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::serialize::serialize_address(arg0.sender));
        0x1::vector::append<u8>(&mut v0, 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::serialize::serialize_address(arg0.recipient));
        0x1::vector::append<u8>(&mut v0, 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::serialize::serialize_address(arg0.destination_caller));
        0x1::vector::append<u8>(&mut v0, arg0.message_body);
        v0
    }

    public fun source_domain(arg0: &Message) : u32 {
        arg0.source_domain
    }

    public(friend) fun update_destination_caller(arg0: &mut Message, arg1: address) {
        arg0.destination_caller = arg1;
    }

    public(friend) fun update_message_body(arg0: &mut Message, arg1: vector<u8>) {
        arg0.message_body = arg1;
    }

    public(friend) fun update_version(arg0: &mut Message, arg1: u32) {
        arg0.version = arg1;
    }

    public(friend) fun validate_raw_message(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) >= 116, 0);
    }

    public fun version(arg0: &Message) : u32 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

