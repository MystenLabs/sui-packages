module 0x18292bb2d61fbd9777b82b5c7f5d430e5a0b7ca946971ce5e94c178a6212b5e0::time {
    public fun check_staleness(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (arg0 < v0) {
            return
        };
        assert!(arg0 - v0 <= arg1, 93492);
    }

    // decompiled from Move bytecode v7
}

