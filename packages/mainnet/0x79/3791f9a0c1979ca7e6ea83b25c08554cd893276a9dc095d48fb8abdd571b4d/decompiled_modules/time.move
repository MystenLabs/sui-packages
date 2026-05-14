module 0x793791f9a0c1979ca7e6ea83b25c08554cd893276a9dc095d48fb8abdd571b4d::time {
    public fun check_staleness(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (arg0 < v0) {
            return
        };
        assert!(arg0 - v0 <= arg1, 93492);
    }

    // decompiled from Move bytecode v7
}

