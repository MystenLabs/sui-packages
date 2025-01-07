module 0xe3f0614ae7b7feb77a142385cb71abb36d6e0e269c5f4fc5604b3b7e1b1d45dc::drand_lib {
    public fun derive_randomness(arg0: vector<u8>) : vector<u8> {
        0x2::hash::blake2b256(&arg0)
    }

    public fun is_current_round(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg3) / 1000 < 1595431050 + 30 * arg2, 12290);
        verify_drand_signature(arg0, arg1, arg2);
    }

    public fun safe_selection(arg0: u64, arg1: &vector<u8>) : u64 {
        assert!(0x1::vector::length<u8>(arg1) >= 16, 12289);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 16) {
            let v2 = v0 << 8;
            v0 = v2 + (*0x1::vector::borrow<u8>(arg1, v1) as u128);
            v1 = v1 + 1;
        };
        ((v0 % (arg0 as u128)) as u64)
    }

    public fun verify_drand_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: u64) {
        let v0 = x"0000000000000000";
        let v1 = 7;
        while (v1 > 0) {
            *0x1::vector::borrow_mut<u8>(&mut v0, v1) = ((arg2 % 256) as u8);
            arg2 = arg2 >> 8;
            v1 = v1 - 1;
        };
        0x1::vector::append<u8>(&mut arg1, v0);
        let v2 = 0x1::hash::sha2_256(arg1);
        let v3 = x"868f005eb8e6e4ca0a47c8a77ceaa5309a47978a7c71bc5cce96366b5d7a569937c529eeda66c7293784a9402801af31";
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg0, &v3, &v2), 12289);
    }

    // decompiled from Move bytecode v6
}

