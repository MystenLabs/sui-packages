module 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::verify {
    fun get_eth_pubkey(arg0: &vector<u8>) : 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::evm_pubkey::EvmPubkey {
        let v0 = 0x2::hash::keccak256(arg0);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 12;
        while (v2 < 32) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, v2));
            v2 = v2 + 1;
        };
        0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::evm_pubkey::from_bytes(v1)
    }

    fun get_recoverable_message(arg0: &vector<u8>) : vector<u8> {
        let v0 = x"19";
        0x1::vector::append<u8>(&mut v0, x"457468657265756d205369676e6564204d6573736167653a0a3332");
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v1, v0);
        0x1::vector::append<u8>(&mut v1, *arg0);
        v1
    }

    fun get_rsv_signature_from_parts(arg0: &vector<u8>, arg1: &vector<u8>, arg2: u8) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x1::vector::append<u8>(&mut v0, *arg1);
        0x1::vector::push_back<u8>(&mut v0, arg2);
        v0
    }

    fun get_stork_message(arg0: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::evm_pubkey::EvmPubkey, arg1: vector<u8>, arg2: u64, arg3: 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::i128::I128, arg4: vector<u8>, arg5: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::evm_pubkey::get_bytes(arg0));
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, x"000000000000000000000000000000000000000000000000");
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 8;
        while (v2 > 0) {
            v2 = v2 - 1;
            0x1::vector::push_back<u8>(&mut v1, ((arg2 >> v2 * 8 & 255) as u8));
        };
        0x1::vector::append<u8>(&mut v0, v1);
        let v3 = if (0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::i128::is_negative(&arg3)) {
            255
        } else {
            0
        };
        let v4 = 0x1::vector::empty<u8>();
        let v5 = &mut v4;
        0x1::vector::push_back<u8>(v5, v3);
        0x1::vector::push_back<u8>(v5, v3);
        0x1::vector::push_back<u8>(v5, v3);
        0x1::vector::push_back<u8>(v5, v3);
        0x1::vector::push_back<u8>(v5, v3);
        0x1::vector::push_back<u8>(v5, v3);
        0x1::vector::push_back<u8>(v5, v3);
        0x1::vector::push_back<u8>(v5, v3);
        0x1::vector::push_back<u8>(v5, v3);
        0x1::vector::push_back<u8>(v5, v3);
        0x1::vector::push_back<u8>(v5, v3);
        0x1::vector::push_back<u8>(v5, v3);
        0x1::vector::push_back<u8>(v5, v3);
        0x1::vector::push_back<u8>(v5, v3);
        0x1::vector::push_back<u8>(v5, v3);
        0x1::vector::push_back<u8>(v5, v3);
        0x1::vector::append<u8>(&mut v0, v4);
        0x1::vector::append<u8>(&mut v0, 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::i128::to_bytes(arg3));
        0x1::vector::append<u8>(&mut v0, arg4);
        0x1::vector::append<u8>(&mut v0, arg5);
        v0
    }

    fun get_stork_message_hash(arg0: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::evm_pubkey::EvmPubkey, arg1: vector<u8>, arg2: u64, arg3: 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::i128::I128, arg4: vector<u8>, arg5: vector<u8>) : vector<u8> {
        let v0 = get_stork_message(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::hash::keccak256(&v0)
    }

    fun recover_secp256k1_pubkey(arg0: &vector<u8>, arg1: &vector<u8>) : 0x1::option::Option<vector<u8>> {
        let v0 = *0x1::vector::borrow<u8>(arg1, 64);
        let v1 = &v0;
        let v2 = if (*v1 == 27) {
            0
        } else if (*v1 == 28) {
            1
        } else {
            return 0x1::option::none<vector<u8>>()
        };
        let v3 = *arg1;
        0x1::vector::pop_back<u8>(&mut v3);
        0x1::vector::push_back<u8>(&mut v3, v2);
        let v4 = 0x2::ecdsa_k1::secp256k1_ecrecover(&v3, arg0, 0);
        let v5 = 0x2::ecdsa_k1::decompress_pubkey(&v4);
        0x1::vector::remove<u8>(&mut v5, 0);
        0x1::option::some<vector<u8>>(v5)
    }

    fun verify_ecdsa_signature(arg0: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::evm_pubkey::EvmPubkey, arg1: &vector<u8>, arg2: &vector<u8>) : bool {
        if (0x1::vector::length<u8>(arg2) != 65) {
            return false
        };
        let v0 = get_recoverable_message(arg1);
        let v1 = recover_secp256k1_pubkey(&v0, arg2);
        if (v1 == 0x1::option::none<vector<u8>>()) {
            return false
        };
        let v2 = 0x1::option::extract<vector<u8>>(&mut v1);
        get_eth_pubkey(&v2) == *arg0
    }

    public fun verify_stork_evm_signature(arg0: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::evm_pubkey::EvmPubkey, arg1: vector<u8>, arg2: u64, arg3: 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::i128::I128, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: u8) : bool {
        let v0 = get_stork_message_hash(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = get_rsv_signature_from_parts(&arg6, &arg7, arg8);
        verify_ecdsa_signature(arg0, &v0, &v1)
    }

    // decompiled from Move bytecode v6
}

