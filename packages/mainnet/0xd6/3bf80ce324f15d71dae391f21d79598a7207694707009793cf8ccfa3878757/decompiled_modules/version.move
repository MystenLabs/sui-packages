module 0xd63bf80ce324f15d71dae391f21d79598a7207694707009793cf8ccfa3878757::version {
    public fun assert_is_current(arg0: u64) {
        assert!(arg0 == 1, 1);
    }

    public fun current() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

