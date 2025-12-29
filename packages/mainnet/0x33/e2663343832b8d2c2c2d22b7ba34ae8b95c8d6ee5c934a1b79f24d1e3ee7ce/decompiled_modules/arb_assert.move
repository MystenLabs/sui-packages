module 0x33e2663343832b8d2c2c2d22b7ba34ae8b95c8d6ee5c934a1b79f24d1e3ee7ce::arb_assert {
    public fun ge_u64(arg0: u64, arg1: u64) {
        assert!(arg0 >= arg1, 0);
    }

    // decompiled from Move bytecode v6
}

