module 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::u128 {
    public fun safe_from_u256(arg0: u256) : u128 {
        assert!(arg0 <= 340282366920938463463374607431768211455, 1);
        (arg0 as u128)
    }

    // decompiled from Move bytecode v6
}

