module 0x7e0c6e1400054f63f866562bd719e72ca7633384c617edd79db27738ad81846::prover {
    struct ProveRollEvent has copy, drop, store {
        result_roll: u64,
    }

    struct ProveBLSEvent has copy, drop, store {
        proof_result: bool,
    }

    public entry fun fun_get_roll(arg0: vector<u8>) : u64 {
        roll(0x2::hash::blake2b256(&arg0))
    }

    public entry fun prove_game(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x2::object::ID) : bool {
        let v0 = 0x2::object::id_to_bytes(&arg2);
        let v1 = 0x2::bls12381::bls12381_min_pk_verify(&arg0, &arg1, &v0);
        let v2 = ProveBLSEvent{proof_result: v1};
        0x2::event::emit<ProveBLSEvent>(v2);
        v1
    }

    fun roll(arg0: vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 32) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(&arg0, v1) as u256);
            v1 = v1 + 1;
        };
        let v3 = ((v0 % 38) as u64);
        let v4 = ProveRollEvent{result_roll: v3};
        0x2::event::emit<ProveRollEvent>(v4);
        v3
    }

    // decompiled from Move bytecode v6
}

