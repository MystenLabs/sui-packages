module 0x498cfc67fcc54c3092747eb6b38acde56889c17a42ff4d67c3e1c1f83995f9d9::tier {
    public fun compute_reward(arg0: u8, arg1: u64) : u64 {
        if (arg0 == 1) {
            return 1000000000 * arg1
        };
        if (arg0 == 2) {
            return 2000000000 * arg1
        };
        if (arg0 == 3) {
            return 3000000000 * arg1
        };
        1000000000 * arg1
    }

    public fun compute_tier(arg0: u64) : u8 {
        assert!(arg0 >= 1000000000000, 1);
        if (arg0 >= 1000000000000) {
            return 1
        };
        if (arg0 >= 5000000000000) {
            return 2
        };
        if (arg0 >= 25000000000000) {
            return 3
        };
        1
    }

    // decompiled from Move bytecode v6
}

