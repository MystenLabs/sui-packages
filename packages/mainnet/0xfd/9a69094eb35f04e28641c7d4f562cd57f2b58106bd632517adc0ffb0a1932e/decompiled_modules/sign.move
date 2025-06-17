module 0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::sign {
    struct BridgeSign has store {
        signers: vector<address>,
    }

    public(friend) fun create() : BridgeSign {
        BridgeSign{signers: 0x1::vector::empty<address>()}
    }

    fun encode_message_bytes(arg0: 0x1::ascii::String, arg1: address, arg2: u64, arg3: 0x1::ascii::String, arg4: u64) : vector<u8> {
        let v0 = 0x1::ascii::into_bytes(arg3);
        let v1 = 0x2::bcs::to_bytes<u64>(&arg4);
        let v2 = 0x1::ascii::into_bytes(arg0);
        let v3 = 0x2::bcs::to_bytes<address>(&arg1);
        let v4 = 0x2::bcs::to_bytes<u64>(&arg2);
        let v5 = b"SUI_BRIDGE_MESSAGE";
        0x1::vector::push_back<u8>(&mut v5, (0x1::vector::length<u8>(&v0) as u8));
        0x1::vector::append<u8>(&mut v5, v0);
        0x1::vector::push_back<u8>(&mut v5, (0x1::vector::length<u8>(&v1) as u8));
        0x1::vector::append<u8>(&mut v5, v1);
        0x1::vector::push_back<u8>(&mut v5, (0x1::vector::length<u8>(&v2) as u8));
        0x1::vector::append<u8>(&mut v5, v2);
        0x1::vector::push_back<u8>(&mut v5, (0x1::vector::length<u8>(&v3) as u8));
        0x1::vector::append<u8>(&mut v5, v3);
        0x1::vector::push_back<u8>(&mut v5, (0x1::vector::length<u8>(&v4) as u8));
        0x1::vector::append<u8>(&mut v5, v4);
        v5
    }

    public(friend) fun info(arg0: &BridgeSign) : vector<address> {
        arg0.signers
    }

    fun min_signer_count(arg0: &BridgeSign) : u64 {
        let v0 = 0x1::vector::length<address>(&arg0.signers);
        if (v0 >= 3) {
            (v0 * 2 + 2) / 3
        } else {
            2
        }
    }

    public(friend) fun op_signers(arg0: &mut BridgeSign, arg1: address, arg2: bool) {
        if (arg2) {
            assert!(!0x1::vector::contains<address>(&arg0.signers, &arg1), 4);
            0x1::vector::push_back<address>(&mut arg0.signers, arg1);
        } else {
            assert!(0x1::vector::contains<address>(&arg0.signers, &arg1), 5);
            let (_, v1) = 0x1::vector::index_of<address>(&arg0.signers, &arg1);
            0x1::vector::remove<address>(&mut arg0.signers, v1);
        };
    }

    fun recover_eth_address(arg0: &vector<u8>, arg1: &vector<u8>) : address {
        let v0 = 0x2::ecdsa_k1::secp256k1_ecrecover(arg0, arg1, 0);
        let v1 = 0x2::ecdsa_k1::decompress_pubkey(&v0);
        0x1::vector::remove<u8>(&mut v1, 0);
        let v2 = 0x2::hash::keccak256(&v1);
        let v3 = 0x1::vector::length<u8>(&v2);
        let v4 = 0x1::vector::empty<u8>();
        let v5 = 0;
        while (v5 < 12) {
            0x1::vector::push_back<u8>(&mut v4, 0);
            v5 = v5 + 1;
        };
        0x1::vector::append<u8>(&mut v4, slice_range(v2, v3 - 20, v3));
        0x2::address::from_bytes(v4)
    }

    fun slice_range(arg0: vector<u8>, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        while (arg1 < arg2) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0, arg1));
            arg1 = arg1 + 1;
        };
        v0
    }

    public(friend) fun verify_signatures<T0>(arg0: &BridgeSign, arg1: vector<vector<u8>>, arg2: address, arg3: u64, arg4: 0x1::ascii::String, arg5: u64) {
        assert!(0x1::vector::length<address>(&arg0.signers) >= 3, 6);
        let v0 = encode_message_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()), arg2, arg3, arg4, arg5);
        let v1 = 0x2::vec_set::empty<address>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(&arg1)) {
            let v3 = recover_eth_address(0x1::vector::borrow<vector<u8>>(&arg1, v2), &v0);
            assert!(!0x2::vec_set::contains<address>(&v1, &v3), 1);
            assert!(0x1::vector::contains<address>(&arg0.signers, &v3), 2);
            0x2::vec_set::insert<address>(&mut v1, v3);
            v2 = v2 + 1;
        };
        assert!(0x2::vec_set::size<address>(&v1) >= min_signer_count(arg0), 3);
    }

    // decompiled from Move bytecode v6
}

