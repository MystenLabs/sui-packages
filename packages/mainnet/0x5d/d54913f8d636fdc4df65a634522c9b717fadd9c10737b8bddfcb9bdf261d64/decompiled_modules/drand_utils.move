module 0x5dd54913f8d636fdc4df65a634522c9b717fadd9c10737b8bddfcb9bdf261d64::drand_utils {
    public fun derive_randomness(arg0: vector<u8>) : vector<u8> {
        0x1::hash::sha2_256(arg0)
    }

    public fun safe_selection(arg0: u64, arg1: u64, arg2: vector<u8>, arg3: vector<u8>) : u64 {
        verify_drand_signature(arg2, arg3, arg1);
        let v0 = derive_randomness(arg2);
        assert!(0x1::vector::length<u8>(&v0) >= 16, 0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 16) {
            let v3 = v1 << 8;
            v1 = v3 + (*0x1::vector::borrow<u8>(&v0, v2) as u128);
            v2 = v2 + 1;
        };
        ((v1 % (arg0 as u128)) as u64)
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
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg0, &v3, &v2), 1);
    }

    // decompiled from Move bytecode v6
}

