module 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::guard {
    public fun assert_before(arg0: &0x2::clock::Clock, arg1: u64) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        assert!(v0 <= arg1, 2);
        assert!(arg1 - v0 <= 3600000, 3);
    }

    public fun assert_live(arg0: &0x2::clock::Clock, arg1: u64, arg2: u64, arg3: u64) {
        assert_before(arg0, arg1);
        assert_min(arg2, arg3);
    }

    public fun assert_min(arg0: u64, arg1: u64) {
        assert!(arg0 >= arg1, 1);
    }

    // decompiled from Move bytecode v7
}

