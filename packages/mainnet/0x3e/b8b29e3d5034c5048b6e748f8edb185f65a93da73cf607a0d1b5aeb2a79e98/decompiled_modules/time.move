module 0x3eb8b29e3d5034c5048b6e748f8edb185f65a93da73cf607a0d1b5aeb2a79e98::time {
    public fun check_staleness(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (arg0 < v0) {
            return
        };
        assert!(arg0 - v0 <= arg1, 93492);
    }

    // decompiled from Move bytecode v7
}

