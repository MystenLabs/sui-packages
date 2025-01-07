module 0xe5d048ec043ff73f2fb8e7ab25958c956ceaf5b082cf285aaee3cc1a0267fe2a::random_lib {
    public(friend) fun verify_and_random<T0, T1, T2>(arg0: &0xe5d048ec043ff73f2fb8e7ab25958c956ceaf5b082cf285aaee3cc1a0267fe2a::pool::Pool<T0, T1, T2>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64) : u64 {
        let v0 = 0xe5d048ec043ff73f2fb8e7ab25958c956ceaf5b082cf285aaee3cc1a0267fe2a::pool::current_round<T0, T1, T2>(arg0);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg1, &arg2, &arg3), 0);
        0x1::vector::append<u8>(&mut arg1, 0x2::bcs::to_bytes<u64>(&v0));
        0x1::vector::append<u8>(&mut arg1, arg3);
        let v1 = 0x2::bcs::new(0x2::hash::blake2b256(&arg1));
        0x2::bcs::peel_u64(&mut v1) % (arg4 + 1)
    }

    // decompiled from Move bytecode v6
}

