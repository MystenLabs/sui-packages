module 0xbabb2b101000d2f3926ddc2e2b435f4e4c2c634f70eb5671919b0a907df9f2cf::time {
    public fun check_staleness(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (arg0 < v0) {
            assert!(v0 - arg0 <= 60000, 93493);
            return
        };
        assert!(arg0 - v0 <= arg1, 93492);
    }

    // decompiled from Move bytecode v7
}

