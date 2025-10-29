module 0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::clock_utils {
    public(friend) fun timestamp_seconds(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    // decompiled from Move bytecode v6
}

