module 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::attestation {
    fun normalize_attestation(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::vector_utils::slice<u8>(&arg0, 0, 65 - 1);
        let v1 = 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::vector_utils::slice<u8>(&arg0, 65 - 1, 65);
        let v2 = 0x1::vector::pop_back<u8>(&mut v1);
        assert!(v2 >= 27 && v2 <= 28, 3);
        0x1::vector::push_back<u8>(&mut v0, v2 - 27);
        v0
    }

    fun recover_attester(arg0: &vector<u8>, arg1: &vector<u8>) : address {
        let v0 = 0x2::ecdsa_k1::secp256k1_ecrecover(arg0, arg1, 0);
        let v1 = 0x2::ecdsa_k1::decompress_pubkey(&v0);
        let v2 = 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::vector_utils::slice<u8>(&v1, 1, 0x1::vector::length<u8>(&v1));
        let v3 = 0x2::hash::keccak256(&v2);
        let v4 = x"000000000000000000000000";
        0x1::vector::append<u8>(&mut v4, 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::vector_utils::slice<u8>(&v3, 0x1::vector::length<u8>(&v3) - 20, 0x1::vector::length<u8>(&v3)));
        0x2::address::from_bytes(v4)
    }

    public fun verify_attestation_signatures(arg0: vector<u8>, arg1: vector<u8>, arg2: &0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State) {
        let v0 = 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::signature_threshold(arg2);
        assert!(0x1::vector::length<u8>(&arg1) == v0 * 65, 0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::vector_utils::slice<u8>(&arg1, v1 * 65, (v1 + 1) * 65);
            verify_low_s_value(v2);
            let v3 = normalize_attestation(v2);
            let v4 = recover_attester(&v3, &arg0);
            assert!(0x2::address::to_u256(v4) > 0x2::address::to_u256(@0x0), 1);
            assert!(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::is_attester_enabled(arg2, v4), 2);
            v1 = v1 + 1;
        };
    }

    fun verify_low_s_value(arg0: vector<u8>) {
        assert!(0x2::address::to_u256(0x2::address::from_bytes(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::vector_utils::slice<u8>(&arg0, 32, 65 - 1))) <= 0x2::address::to_u256(@0x7fffffffffffffffffffffffffffffff5d576e7357a4501ddfe92f46681b20a0), 4);
    }

    // decompiled from Move bytecode v6
}

