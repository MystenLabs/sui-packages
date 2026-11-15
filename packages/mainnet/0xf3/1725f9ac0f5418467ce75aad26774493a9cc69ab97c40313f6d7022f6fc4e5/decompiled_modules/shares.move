module 0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::shares {
    public fun mint(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0) {
            return arg0
        };
        assert!(arg2 > 0, 100);
        0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::math::mul_div(arg0, arg1, arg2)
    }

    public fun redeem(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 <= arg1, 101);
        if (arg0 == 0) {
            return 0
        };
        0xf332e48e1c3ca49e806ebd3cbca0fdb6de213f5906503cffdd7d74a9f28da3e1::math::mul_div(arg0, arg2, arg1)
    }

    // decompiled from Move bytecode v7
}

