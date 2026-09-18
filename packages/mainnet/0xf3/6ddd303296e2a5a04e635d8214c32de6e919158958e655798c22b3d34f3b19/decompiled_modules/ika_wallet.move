module 0xf36ddd303296e2a5a04e635d8214c32de6e919158958e655798c22b3d34f3b19::ika_wallet {
    fun decode_public_key(arg0: vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg0) <= 16384, 1);
        let v0 = 0x2::bcs::new(arg0);
        assert!(0x2::bcs::peel_u8(&mut v0) == 1, 1);
        let v1 = 0x2::bcs::peel_vec_u8(&mut v0);
        assert!(0x1::vector::length<u8>(&v1) == 32, 1);
        let v2 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v2), 1);
        let v3 = 0x2::bcs::new(0x2::bcs::peel_vec_u8(&mut v0));
        assert!(0x2::bcs::peel_u8(&mut v3) <= 1, 1);
        let v4 = b"";
        let v5 = 0;
        while (v5 < 32) {
            0x1::vector::push_back<u8>(&mut v4, 0x2::bcs::peel_u8(&mut v3));
            v5 = v5 + 1;
        };
        let v6 = b"";
        let v7 = 0;
        while (v7 < 32) {
            0x1::vector::push_back<u8>(&mut v6, 0x2::bcs::peel_u8(&mut v3));
            v7 = v7 + 1;
        };
        assert!(v1 == v6, 1);
        let v8 = 0x2::bcs::into_remainder_bytes(v3);
        assert!(!0x1::vector::is_empty<u8>(&v8), 1);
        v1
    }

    public(friend) fun public_key(arg0: &0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWallet, arg1: &0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap) : vector<u8> {
        assert!(0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::curve(arg0) == 2, 0);
        assert!(!0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::is_imported_key_dwallet(arg0), 0);
        let v0 = 0x2::object::id<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(arg1);
        validate_shared_prefix(0x2::bcs::to_bytes<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWallet>(arg0), 0x2::object::id_to_address(&v0));
        decode_public_key(*0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::validate_active_and_get_public_output(arg0))
    }

    fun validate_shared_prefix(arg0: vector<u8>, arg1: address) {
        let v0 = 0x2::bcs::new(arg0);
        0x2::bcs::peel_address(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        assert!(0x2::bcs::peel_u32(&mut v0) == 2, 0);
        assert!(0x2::bcs::peel_u8(&mut v0) == 1, 0);
        let v1 = 0x2::bcs::peel_vec_u8(&mut v0);
        assert!(!0x1::vector::is_empty<u8>(&v1) && 0x1::vector::length<u8>(&v1) <= 1024, 0);
        assert!(0x2::bcs::peel_address(&mut v0) == arg1, 2);
        0x2::bcs::peel_address(&mut v0);
        assert!(!0x2::bcs::peel_bool(&mut v0), 0);
    }

    // decompiled from Move bytecode v7
}

