module 0x8c36f834b0c0b9853d2bd047d9c49f4f9aa8d7a9244d7b36c17c74d765396142::random_lib {
    public(friend) fun verify_and_random<T0, T1, T2>(arg0: &0x8c36f834b0c0b9853d2bd047d9c49f4f9aa8d7a9244d7b36c17c74d765396142::pool::GlobalConfig, arg1: &0x8c36f834b0c0b9853d2bd047d9c49f4f9aa8d7a9244d7b36c17c74d765396142::pool::Pool<T0, T1, T2>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &0x2::clock::Clock) : u64 {
        assert!(0x8c36f834b0c0b9853d2bd047d9c49f4f9aa8d7a9244d7b36c17c74d765396142::pool::config_veriosn(arg0) == 1, 0);
        let v0 = 0x8c36f834b0c0b9853d2bd047d9c49f4f9aa8d7a9244d7b36c17c74d765396142::pool::current_round<T0, T1, T2>(arg1);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg2, &arg3, &arg4), 1);
        0x1::vector::append<u8>(&mut arg2, 0x2::bcs::to_bytes<u64>(&v0));
        0x1::vector::append<u8>(&mut arg2, 0x2::bcs::to_bytes<u64>(&v1));
        0x1::vector::append<u8>(&mut arg2, arg4);
        let v2 = 0x2::bcs::new(0x2::hash::blake2b256(&arg2));
        0x2::bcs::peel_u64(&mut v2) % (arg5 + 1)
    }

    // decompiled from Move bytecode v6
}

