module 0xf87a7c3d60f596da675a8764d6bca32110e36d4bcdc44a64cdc50aebe6bed25f::M22 {
    struct BridgeMessage has copy, drop, store {
        message_type: u8,
        message_version: u8,
        seq_num: u64,
        source_chain: u8,
        payload: vector<u8>,
    }

    public fun deserialize_message_test_only(arg0: vector<u8>) : BridgeMessage {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = &mut v0;
        make_generic_message(0x2::bcs::peel_u8(&mut v0), 0x2::bcs::peel_u8(&mut v0), peel_u64_be_for_testing(v1), 0x2::bcs::peel_u8(&mut v0), 0x2::bcs::into_remainder_bytes(v0))
    }

    public(friend) fun make_generic_message(arg0: u8, arg1: u8, arg2: u64, arg3: u8, arg4: vector<u8>) : BridgeMessage {
        BridgeMessage{
            message_type    : arg0,
            message_version : arg1,
            seq_num         : arg2,
            source_chain    : arg3,
            payload         : arg4,
        }
    }

    fun peel_u64_be(arg0: &mut 0x2::bcs::BCS) : u64 {
        let v0 = 64;
        let v1 = 0;
        while (v0 > 0) {
            let v2 = v0 - 8;
            v0 = v2;
            v1 = v1 + ((0x2::bcs::peel_u8(arg0) as u64) << v2);
        };
        v1
    }

    public(friend) fun peel_u64_be_for_testing(arg0: &mut 0x2::bcs::BCS) : u64 {
        peel_u64_be(arg0)
    }

    fun reverse_bytes(arg0: vector<u8>) : vector<u8> {
        0x1::vector::reverse<u8>(&mut arg0);
        arg0
    }

    public fun serialize_message(arg0: BridgeMessage) : vector<u8> {
        let BridgeMessage {
            message_type    : v0,
            message_version : v1,
            seq_num         : v2,
            source_chain    : v3,
            payload         : v4,
        } = arg0;
        let v5 = v2;
        let v6 = 0x1::vector::empty<u8>();
        let v7 = &mut v6;
        0x1::vector::push_back<u8>(v7, v0);
        0x1::vector::push_back<u8>(v7, v1);
        0x1::vector::append<u8>(&mut v6, reverse_bytes(0x2::bcs::to_bytes<u64>(&v5)));
        0x1::vector::push_back<u8>(&mut v6, v3);
        0x1::vector::append<u8>(&mut v6, v4);
        v6
    }

    // decompiled from Move bytecode v6
}

