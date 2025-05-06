module 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::utils {
    public fun ratio_calc(arg0: u64, arg1: u64) : u64 {
        ratio_check(arg1);
        arg0 * arg1 / 10000
    }

    public fun ratio_check(arg0: u64) {
        assert!(arg0 >= 0, 900002);
    }

    // decompiled from Move bytecode v6
}

