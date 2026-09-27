module 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::cctp {
    public fun chain_id_from_domain(arg0: u32) : u8 {
        if (arg0 == 8) {
            0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::chain_id_sui()
        } else if (arg0 == 0) {
            0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::chain_id_ethereum()
        } else if (arg0 == 5) {
            0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::chain_id_solana()
        } else {
            255
        }
    }

    public fun domain_ethereum() : u32 {
        0
    }

    public fun domain_from_chain_id(arg0: u8) : u32 {
        if (arg0 == 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::chain_id_ethereum()) {
            0
        } else if (arg0 == 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::chain_id_solana()) {
            5
        } else {
            assert!(arg0 == 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::chain_id_sui(), 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::invalid_chain_address());
            8
        }
    }

    public fun domain_solana() : u32 {
        5
    }

    public fun domain_sui() : u32 {
        8
    }

    public fun left_pad_to_32(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::length<u8>(&arg0);
        assert!(v0 <= 32, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::invalid_chain_address());
        let v1 = 0x1::vector::empty<u8>();
        while (v0 < 32) {
            0x1::vector::push_back<u8>(&mut v1, 0);
            v0 = v0 + 1;
        };
        0x1::vector::append<u8>(&mut v1, arg0);
        v1
    }

    public fun message_sender_raw_bytes(arg0: u8, arg1: address) : vector<u8> {
        if (arg0 == 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::chain_id_ethereum()) {
            trailing_bytes(0x2::address::to_bytes(arg1), 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::evm_address_length())
        } else {
            0x2::address::to_bytes(arg1)
        }
    }

    public fun mint_recipient(arg0: &0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress) : address {
        let v0 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::chain_id(arg0);
        if (v0 == 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::chain_id_ethereum()) {
            0x2::address::from_bytes(left_pad_to_32(0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::bytes(arg0)))
        } else {
            assert!(v0 == 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::chain_id_solana(), 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::invalid_chain_address());
            0x2::address::from_bytes(0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::bytes(arg0))
        }
    }

    public fun trailing_bytes(arg0: vector<u8>, arg1: u64) : vector<u8> {
        let v0 = 0x1::vector::length<u8>(&arg0);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = v0 - arg1;
        while (v2 < v0) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&arg0, v2));
            v2 = v2 + 1;
        };
        v1
    }

    public fun unified_message_sender(arg0: u32, arg1: address) : 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress {
        let v0 = chain_id_from_domain(arg0);
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::from_chain_id_and_bytes(v0, message_sender_raw_bytes(v0, arg1))
    }

    public fun verify_withdraw<T0: drop>(arg0: address, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u128, arg5: u128, arg6: u64, arg7: vector<u8>, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: u64, arg11: u64, arg12: u64) : (0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress, address, vector<u8>) {
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::signature::assert_signed_payload_fresh(arg9, arg6, arg10);
        let v0 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::from_tagged_bytes(arg1);
        let v1 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::from_tagged_bytes(arg2);
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::assert_same_chain(&v0, &v1);
        assert!(!0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::is_sui(&v1), arg11);
        let (v2, v3) = if (0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::chain_id(&v1) == 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::chain_id_solana()) {
            let v4 = 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::from_tagged_bytes(arg3);
            0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::assert_same_chain(&v0, &v4);
            (0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::withdraw_solana(arg0, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::type_string<T0>(), v0, v1, v4, arg4, arg5, arg6), mint_recipient(&v4))
        } else {
            assert!(0x1::vector::length<u8>(&arg3) == 0, arg11);
            (0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::withdraw(arg0, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::payload::type_string<T0>(), v0, v1, arg4, arg5, arg6), mint_recipient(&v1))
        };
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::signature::verify_user_signature(&v0, 0x1::vector::empty<address>(), v2, arg7, arg8, arg12);
        (v0, v1, v3, 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::get_hash(v2))
    }

    // decompiled from Move bytecode v7
}

