module 0x8fd774aa4e50b58ff6712ae0133335e123faa4d6c456ee97b05bf390cea41a44::rand {
    public fun rand(arg0: vector<u8>, arg1: u64) : u64 {
        bytes_to_u64(0x1::hash::sha2_256(arg0)) % arg1
    }

    fun bytes_to_u64(arg0: vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            v0 = v0 | (*0x1::vector::borrow<u8>(&arg0, v1) as u64) << ((8 * (7 - v1)) as u8);
            v1 = v1 + 1;
        };
        v0
    }

    public fun calculate_round(arg0: u64) : u64 {
        (arg0 - 1595431050) / 30 + 1
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
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg0, &v3, &v2), 0);
    }

    // decompiled from Move bytecode v6
}

