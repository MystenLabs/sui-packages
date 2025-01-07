module 0xf4ac8ea2c9d8ab58e47cd70e1f1ef095de5a61444ef676c0627055afe48b5262::drand_lib {
    public fun derive_randomness(arg0: vector<u8>) : vector<u8> {
        0x1::hash::sha2_256(arg0)
    }

    public entry fun just_check_drand(arg0: vector<u8>, arg1: vector<u8>, arg2: u64) {
        verify_drand_signature(arg0, arg1, arg2);
    }

    public fun safe_selection(arg0: u64, arg1: &vector<u8>, arg2: u128) : u64 {
        assert!(0x1::vector::length<u8>(arg1) >= 16, 0);
        let v0 = 0;
        while (v0 < 16) {
            let v1 = arg2 << 8;
            arg2 = v1 + (*0x1::vector::borrow<u8>(arg1, v0) as u128);
            v0 = v0 + 1;
        };
        ((arg2 % (arg0 as u128)) as u64)
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
        0x2::bls12381::bls12381_min_pk_verify(&arg0, &v3, &v2);
        let v4 = x"868f005eb8e6e4ca0a47c8a77ceaa5309a47978a7c71bc5cce96366b5d7a569937c529eeda66c7293784a9402801af31";
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg0, &v4, &v2), 1);
    }

    public fun verify_time_has_passed(arg0: u64, arg1: vector<u8>, arg2: vector<u8>, arg3: u64) {
        assert!(arg0 <= 1595431050 + 30 * (arg3 - 1), 1);
        verify_drand_signature(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

