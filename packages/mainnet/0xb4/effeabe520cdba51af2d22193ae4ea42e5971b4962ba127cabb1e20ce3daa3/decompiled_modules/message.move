module 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message {
    struct USDC has drop {
        dummy_field: bool,
    }

    struct BridgeMessage has copy, drop, store {
        message_type: u8,
        message_version: u8,
        seq_num: u64,
        source_chain: u8,
        payload: vector<u8>,
    }

    struct BridgeMessageKey has copy, drop, store {
        source_chain: u8,
        message_type: u8,
        bridge_seq_num: u64,
    }

    struct TokenPayload has drop {
        sender_address: vector<u8>,
        target_chain: u8,
        target_address: vector<u8>,
        token_type: u8,
        amount: u64,
    }

    struct EmergencyOp has drop {
        op_type: u8,
    }

    public fun create_emergency_op_message(arg0: u8, arg1: u64, arg2: u8) : BridgeMessage {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, arg2);
        BridgeMessage{
            message_type    : 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message_types::emergency_op(),
            message_version : 1,
            seq_num         : arg1,
            source_chain    : arg0,
            payload         : v0,
        }
    }

    public fun create_key(arg0: u8, arg1: u8, arg2: u64) : BridgeMessageKey {
        BridgeMessageKey{
            source_chain   : arg0,
            message_type   : arg1,
            bridge_seq_num : arg2,
        }
    }

    public fun create_token_bridge_message(arg0: u8, arg1: u64, arg2: vector<u8>, arg3: u8, arg4: vector<u8>, arg5: u8, arg6: u64) : BridgeMessage {
        let v0 = b"";
        0x1::vector::push_back<u8>(&mut v0, (0x1::vector::length<u8>(&arg2) as u8));
        0x1::vector::append<u8>(&mut v0, arg2);
        0x1::vector::push_back<u8>(&mut v0, arg3);
        0x1::vector::push_back<u8>(&mut v0, (0x1::vector::length<u8>(&arg4) as u8));
        0x1::vector::append<u8>(&mut v0, arg4);
        0x1::vector::push_back<u8>(&mut v0, arg5);
        0x1::vector::append<u8>(&mut v0, reverse_bytes(0x2::bcs::to_bytes<u64>(&arg6)));
        BridgeMessage{
            message_type    : 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message_types::token(),
            message_version : 1,
            seq_num         : arg1,
            source_chain    : arg0,
            payload         : v0,
        }
    }

    public fun emergency_op_type(arg0: &EmergencyOp) : u8 {
        arg0.op_type
    }

    public fun extract_emergency_op_payload(arg0: &BridgeMessage) : EmergencyOp {
        assert!(0x1::vector::length<u8>(&arg0.payload) == 1, 0);
        EmergencyOp{op_type: *0x1::vector::borrow<u8>(&arg0.payload, 0)}
    }

    public fun extract_token_bridge_payload(arg0: &BridgeMessage) : TokenPayload {
        let v0 = 0x2::bcs::new(arg0.payload);
        let v1 = &mut v0;
        let v2 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v2), 0);
        TokenPayload{
            sender_address : 0x2::bcs::peel_vec_u8(&mut v0),
            target_chain   : 0x2::bcs::peel_u8(&mut v0),
            target_address : 0x2::bcs::peel_vec_u8(&mut v0),
            token_type     : 0x2::bcs::peel_u8(&mut v0),
            amount         : peel_u64_be(v1),
        }
    }

    public fun key(arg0: &BridgeMessage) : BridgeMessageKey {
        create_key(arg0.source_chain, arg0.message_type, arg0.seq_num)
    }

    public fun message_type(arg0: &BridgeMessage) : u8 {
        arg0.message_type
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

    fun reverse_bytes(arg0: vector<u8>) : vector<u8> {
        0x1::vector::reverse<u8>(&mut arg0);
        arg0
    }

    public fun seq_num(arg0: &BridgeMessage) : u64 {
        arg0.seq_num
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
        let v6 = b"";
        0x1::vector::push_back<u8>(&mut v6, v0);
        0x1::vector::push_back<u8>(&mut v6, v1);
        0x1::vector::append<u8>(&mut v6, reverse_bytes(0x2::bcs::to_bytes<u64>(&v5)));
        0x1::vector::push_back<u8>(&mut v6, v3);
        0x1::vector::append<u8>(&mut v6, v4);
        v6
    }

    public fun source_chain(arg0: &BridgeMessage) : u8 {
        arg0.source_chain
    }

    public fun token_amount(arg0: &TokenPayload) : u64 {
        arg0.amount
    }

    public fun token_target_address(arg0: &TokenPayload) : vector<u8> {
        arg0.target_address
    }

    public fun token_target_chain(arg0: &TokenPayload) : u8 {
        arg0.target_chain
    }

    public fun token_type(arg0: &TokenPayload) : u8 {
        arg0.token_type
    }

    // decompiled from Move bytecode v7
}

