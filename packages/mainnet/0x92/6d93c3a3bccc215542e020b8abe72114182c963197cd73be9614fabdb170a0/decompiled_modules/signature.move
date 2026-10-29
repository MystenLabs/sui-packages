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

    fun on_evm_chain(arg0: u8, arg1: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress) : 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress {
        if (arg0 == 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::chain_id(&arg1)) {
            arg1
        } else {
            0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::from_chain_id_and_bytes(arg0, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::bytes(&arg1))
        }
    }

    fun resolve_signer(arg0: &0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg1: 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg2: &vector<address>) : 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress {
        if (0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::chain_id(&arg1) != 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::chain_id_ethereum()) {
            return arg1
        };
        let v0 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::chain_id(arg0);
        if (0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::is_evm_chain_id(v0)) {
            return on_evm_chain(v0, arg1)
        };
        let v1 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::evm_chain_ids();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&v1)) {
            let v3 = *0x1::vector::borrow<u8>(&v1, v2);
            let v4 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::sui_address_from_chain(v3, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::bytes(&arg1));
            if (v4 == 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::identifier(arg0) || 0x1::vector::contains<address>(arg2, &v4)) {
                return on_evm_chain(v3, arg1)
            };
            v2 = v2 + 1;
        };
        arg1
    }

    public fun verify_user_signature(arg0: &0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, arg1: vector<address>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64) : 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress {
        let v0 = resolve_signer(arg0, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::library::recover_signer_address(arg3, arg4, arg2, arg5), &arg1);
        assert_signer_authorized(arg0, &v0, arg1, arg5);
        v0
    }

    // decompiled from Move bytecode v7
}

