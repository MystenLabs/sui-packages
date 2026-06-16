module 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::library {
    public fun add_intent_bytes_and_hash(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 3);
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(&arg0));
        0x2::hash::blake2b256(&v0)
    }

    fun build_eip191_message(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 25);
        0x1::vector::append<u8>(&mut v0, x"457468657265756d205369676e6564204d6573736167653a0a");
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(0x1::u128::to_string((0x1::vector::length<u8>(arg0) as u128))));
        0x1::vector::append<u8>(&mut v0, *arg0);
        v0
    }

    fun evm_address_from_uncompressed_pubkey(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 1;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        let v2 = 0x2::hash::keccak256(&v0);
        let v3 = 0x1::vector::empty<u8>();
        let v4 = 12;
        while (v4 < 32) {
            0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(&v2, v4));
            v4 = v4 + 1;
        };
        v3
    }

    fun normalize_evm_signature(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::length<u8>(&arg0) - 1;
        let v1 = *0x1::vector::borrow<u8>(&arg0, v0);
        if (v1 >= 27) {
            *0x1::vector::borrow_mut<u8>(&mut arg0, v0) = v1 - 27;
        };
        arg0
    }

    public fun recover_signer_address(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64) : 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::UnifiedAddress {
        assert!(!0x1::vector::is_empty<u8>(&arg0), arg3);
        let v0 = 0x1::vector::pop_back<u8>(&mut arg0);
        if (v0 == 0) {
            let v2 = add_intent_bytes_and_hash(arg2);
            assert!(0x2::ecdsa_k1::secp256k1_verify(&arg0, &arg1, &v2, 1), arg3);
            0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::from_sui_address(sui_address_from_native_pubkey(1, arg1))
        } else if (v0 == 1 || v0 == 2) {
            let v3 = add_intent_bytes_and_hash(arg2);
            assert!(0x2::ed25519::ed25519_verify(&arg0, &arg1, &v3), arg3);
            0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::from_sui_address(sui_address_from_native_pubkey(0, arg1))
        } else if (v0 == 4) {
            assert!(0x1::vector::length<u8>(&arg0) == 65, arg3);
            assert!(0x1::vector::length<u8>(&arg1) == 33, arg3);
            let v4 = build_eip191_message(&arg2);
            let v5 = normalize_evm_signature(arg0);
            assert!(0x2::ecdsa_k1::secp256k1_ecrecover(&v5, &v4, 0) == arg1, arg3);
            let v6 = 0x2::ecdsa_k1::decompress_pubkey(&arg1);
            0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::from_chain_id_and_bytes(0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::chain_id_ethereum(), evm_address_from_uncompressed_pubkey(&v6))
        } else {
            assert!(v0 == 5, arg3);
            assert!(0x1::vector::length<u8>(&arg1) == 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::solana_pubkey_length(), arg3);
            assert!(0x2::ed25519::ed25519_verify(&arg0, &arg1, &arg2), arg3);
            0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::from_chain_id_and_bytes(0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::chain_id_solana(), arg1)
        }
    }

    public fun scheme_ed25519() : u8 {
        1
    }

    public fun scheme_ed25519_ui_wallet() : u8 {
        2
    }

    public fun scheme_evm_wallet() : u8 {
        4
    }

    public fun scheme_secp256k1() : u8 {
        0
    }

    public fun scheme_solana_wallet() : u8 {
        5
    }

    public fun signature_scheme(arg0: &vector<u8>) : u8 {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 > 0, 0);
        *0x1::vector::borrow<u8>(arg0, v0 - 1)
    }

    fun sui_address_from_native_pubkey(arg0: u8, arg1: vector<u8>) : address {
        if (arg0 == 0) {
            0x1::vector::insert<u8>(&mut arg1, 0, 0);
        } else {
            0x1::vector::insert<u8>(&mut arg1, 1, 0);
        };
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address::get_public_address(arg1)
    }

    // decompiled from Move bytecode v7
}

