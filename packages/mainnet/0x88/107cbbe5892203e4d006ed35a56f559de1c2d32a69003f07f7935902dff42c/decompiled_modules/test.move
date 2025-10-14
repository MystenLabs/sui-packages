module 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::test {
    struct SignatureVerifiedEvent has copy, drop {
        is_verified: bool,
    }

    struct PublicKeyRecoveredEvent has copy, drop {
        public_key: vector<u8>,
    }

    struct HashGeneratedEvent has copy, drop {
        hash: vector<u8>,
    }

    struct OrderSerializedEvent has copy, drop {
        serialized_order: vector<u8>,
    }

    struct PublicAddressGeneratedEvent has copy, drop {
        addr: vector<u8>,
    }

    struct CoinValue has copy, drop {
        value: u64,
        type_name: 0x1::type_name::TypeName,
        name: 0x1::ascii::String,
        addr: 0x1::ascii::String,
    }

    public fun hash(arg0: address, arg1: address) {
        let v0 = 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::order::get_serialized_order(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::order::pack_order(arg1, 24, 1000000000000000000, 1000000000000000000, 1000000000000000000, arg0, 1747984534000, 1668690862116));
        let v1 = OrderSerializedEvent{serialized_order: v0};
        0x2::event::emit<OrderSerializedEvent>(v1);
        let v2 = HashGeneratedEvent{hash: 0x1::hash::sha2_256(v0)};
        0x2::event::emit<HashGeneratedEvent>(v2);
    }

    public fun get_public_address(arg0: vector<u8>) {
        let v0 = PublicAddressGeneratedEvent{addr: 0x2::address::to_bytes(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::library::get_public_address(arg0))};
        0x2::event::emit<PublicAddressGeneratedEvent>(v0);
    }

    public fun verify_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) {
        let v0 = SignatureVerifiedEvent{is_verified: 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::library::get_result_status(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::library::verify_signature(arg0, arg1, arg2))};
        0x2::event::emit<SignatureVerifiedEvent>(v0);
    }

    public fun get_serialized_order(arg0: address, arg1: address, arg2: u8, arg3: u128, arg4: u128, arg5: u128, arg6: u64, arg7: u128) {
        let v0 = OrderSerializedEvent{serialized_order: 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::order::get_serialized_order(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::order::pack_order(arg0, arg2, arg3, arg4, arg5, arg1, arg6, arg7))};
        0x2::event::emit<OrderSerializedEvent>(v0);
    }

    public fun get_public_address_from_signed_order(arg0: address, arg1: address, arg2: u8, arg3: u128, arg4: u128, arg5: u128, arg6: u64, arg7: u128, arg8: vector<u8>, arg9: vector<u8>) {
        let v0 = 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::order::get_serialized_order(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::order::pack_order(arg0, arg2, arg3, arg4, arg5, arg1, arg6, arg7));
        let v1 = OrderSerializedEvent{serialized_order: v0};
        0x2::event::emit<OrderSerializedEvent>(v1);
        let v2 = HashGeneratedEvent{hash: 0x1::hash::sha2_256(v0)};
        0x2::event::emit<HashGeneratedEvent>(v2);
        let v3 = 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::library::verify_signature(arg8, arg9, v0);
        assert!(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::library::get_result_status(v3), 1000);
        let v4 = PublicAddressGeneratedEvent{addr: 0x2::address::to_bytes(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::library::get_public_address(0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::library::get_result_public_key(v3)))};
        0x2::event::emit<PublicAddressGeneratedEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

