module 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::drand_lib {
    fun calculate_epoch_round(arg0: u64) : u64 {
        if ((arg0 - 1692803367) % 3 == 0) {
            (arg0 - 1692803367) / 3
        } else {
            (arg0 - 1692803367) / 3 + 1
        }
    }

    public fun verify_drand_signature(arg0: vector<u8>, arg1: u64) {
        let v0 = x"0000000000000000";
        let v1 = 7;
        while (v1 > 0) {
            *0x1::vector::borrow_mut<u8>(&mut v0, v1) = ((arg1 % 256) as u8);
            arg1 = arg1 >> 8;
            v1 = v1 - 1;
        };
        let v2 = 0x1::hash::sha2_256(v0);
        let v3 = x"83cf0f2896adee7eb8b5f01fcad3912212c437e0073e911fb90022d3e760183c8c4b450b6a0a6c3ac6a5776a2d1064510d1fec758c921cc22b0e17e63aaf4bcb5ed66304de9cf809bd274ca73bab4af5a6e9c76a4bc09e76eae8991ef5ece45a";
        assert!(0x2::bls12381::bls12381_min_sig_verify(&arg0, &v3, &v2), 1000);
    }

    public fun verify_round_time(arg0: u64, arg1: vector<u8>, arg2: u64) {
        assert!(calculate_epoch_round(arg0) == arg2, 1001);
        verify_drand_signature(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

