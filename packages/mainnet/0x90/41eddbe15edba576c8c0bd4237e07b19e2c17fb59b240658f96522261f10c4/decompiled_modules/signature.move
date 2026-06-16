module 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::signature {
    public fun assert_caller_authorized(arg0: &0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg1: address, arg2: vector<address>, arg3: u64) {
        assert!(arg1 == 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(arg0) || 0x1::vector::contains<address>(&arg2, &arg1), arg3);
    }

    public fun assert_signed_payload_fresh(arg0: &0x2::clock::Clock, arg1: u64, arg2: u64) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        assert!(arg1 > v0 && arg1 - v0 <= 3600000, arg2);
    }

    public fun assert_signer_authorized(arg0: &0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg1: &0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg2: vector<address>, arg3: u64) {
        let v0 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(arg1);
        assert!(0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(arg0) == v0 || 0x1::vector::contains<address>(&arg2, &v0), arg3);
    }

    public fun verify_user_signature(arg0: &0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg1: vector<address>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64) : 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress {
        let v0 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::library::recover_signer_address(arg3, arg4, arg2, arg5);
        assert_signer_authorized(arg0, &v0, arg1, arg5);
        v0
    }

    // decompiled from Move bytecode v7
}

