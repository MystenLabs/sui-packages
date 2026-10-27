module 0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::voucher {
    public fun claim_message(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: u64, arg6: u64) : vector<u8> {
        let v0 = b"RARE_ITEM_V1";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<0x1::string::String>>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<0x1::string::String>>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg6));
        v0
    }

    public fun state_message(arg0: 0x2::object::ID, arg1: u64, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: u64, arg5: u64) : vector<u8> {
        let v0 = b"RARE_ITEM_STATE_V1";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<0x1::string::String>>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<0x1::string::String>>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg5));
        v0
    }

    public(friend) fun verify(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(!0x1::vector::is_empty<u8>(arg0), 501);
        assert!(0x2::clock::timestamp_ms(arg4) < arg3, 502);
        assert!(0x2::ed25519::ed25519_verify(arg2, arg0, arg1), 503);
    }

    // decompiled from Move bytecode v7
}

