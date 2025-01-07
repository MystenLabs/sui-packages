module 0x663bc547b1d1110b56c7d11feac603f607d75dce392539f3329f8ba29e42d95e::random_lib {
    public fun verify_and_random(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64) : u64 {
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg0, &arg1, &arg2), 0);
        0x1::vector::append<u8>(&mut arg0, arg2);
        let v0 = 0x2::bcs::new(0x2::hash::blake2b256(&arg0));
        0x2::bcs::peel_u64(&mut v0) % (arg3 + 1)
    }

    // decompiled from Move bytecode v6
}

