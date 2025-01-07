module 0x19c44d50cc52bb0eccc8be71dda7fd5b36dcdf67971bd45b2019ec988fe6f3f9::prover {
    public entry fun fun_get_roll(arg0: vector<u8>) : u64 {
        roll(0x2::hash::blake2b256(&arg0))
    }

    public entry fun prove_game(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x2::object::ID) : bool {
        let v0 = 0x2::object::id_to_bytes(&arg2);
        0x2::bls12381::bls12381_min_pk_verify(&arg0, &arg1, &v0)
    }

    fun roll(arg0: vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 32) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(&arg0, v1) as u256);
            v1 = v1 + 1;
        };
        ((v0 % 38) as u64)
    }

    // decompiled from Move bytecode v6
}

