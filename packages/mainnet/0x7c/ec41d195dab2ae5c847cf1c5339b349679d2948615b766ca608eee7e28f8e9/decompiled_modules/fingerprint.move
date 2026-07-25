module 0x7cec41d195dab2ae5c847cf1c5339b349679d2948615b766ca608eee7e28f8e9::fingerprint {
    public fun assert_fp(arg0: u128, arg1: u128) {
        assert!(arg0 == arg1, 1);
    }

    public fun compute_fp(arg0: u128, arg1: u128, arg2: u64, arg3: u64) : u128 {
        arg0 ^ arg1 << 64 ^ (arg2 as u128) << 96 ^ (arg3 as u128) << 104
    }

    public fun pool_fp(arg0: u128, arg1: u128, arg2: u64, arg3: u64) : u128 {
        compute_fp(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

