module 0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::randomness {
    struct Random has drop, store {
        state: vector<u8>,
    }

    public fun new(arg0: vector<u8>) : Random {
        Random{state: arg0}
    }

    fun next_digest(arg0: &mut Random) : vector<u8> {
        arg0.state = 0x1::hash::sha3_256(arg0.state);
        arg0.state
    }

    public fun next_u256(arg0: &mut Random) : u256 {
        let v0 = next_digest(arg0);
        let v1 = 0;
        let v2 = 0;
        while (v1 < 32) {
            v2 = v2 + ((0x1::vector::pop_back<u8>(&mut v0) as u256) << 8 * v1);
            v1 = v1 + 1;
        };
        v2
    }

    public fun next_u256_in_range(arg0: &mut Random, arg1: u256, arg2: u256) : u256 {
        assert!(arg2 >= arg1 && arg2 > 0, 0);
        next_u256(arg0) % (arg2 - arg1 + 1) + arg1
    }

    public fun seed(arg0: &Random) : vector<u8> {
        arg0.state
    }

    // decompiled from Move bytecode v6
}

