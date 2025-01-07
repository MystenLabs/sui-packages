module 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::drand_lib {
    public fun verify_drand_sig(arg0: &vector<u8>, arg1: u64) {
        let v0 = x"0000000000000000";
        let v1 = 7;
        while (v1 > 0) {
            *0x1::vector::borrow_mut<u8>(&mut v0, v1) = ((arg1 % 256) as u8);
            arg1 = arg1 >> 8;
            v1 = v1 - 1;
        };
        let v2 = 0x1::hash::sha2_256(v0);
        let v3 = x"83cf0f2896adee7eb8b5f01fcad3912212c437e0073e911fb90022d3e760183c8c4b450b6a0a6c3ac6a5776a2d1064510d1fec758c921cc22b0e17e63aaf4bcb5ed66304de9cf809bd274ca73bab4af5a6e9c76a4bc09e76eae8991ef5ece45a";
        assert!(0x2::bls12381::bls12381_min_sig_verify(arg0, &v3, &v2), 1);
    }

    public fun verify_drand_sig_and_get_outcome(arg0: &vector<u8>, arg1: u64, arg2: u64) : u64 {
        verify_drand_sig(arg0, arg1);
        let v0 = 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::math::derive_randomness(arg0);
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::math::safe_selection(arg2, &v0)
    }

    public fun verify_time_has_passed(arg0: u64, arg1: &vector<u8>, arg2: u64) {
        assert!(arg0 <= 1692803367 + 3 * (arg2 - 1), 1);
        verify_drand_sig(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

