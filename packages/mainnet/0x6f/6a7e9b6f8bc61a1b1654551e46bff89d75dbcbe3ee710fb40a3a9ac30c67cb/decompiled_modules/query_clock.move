module 0x6f6a7e9b6f8bc61a1b1654551e46bff89d75dbcbe3ee710fb40a3a9ac30c67cb::query_clock {
    struct ClockInfo has copy, drop {
        timestamp: u64,
    }

    public fun query_clock(arg0: &0x2::clock::Clock) {
        let v0 = ClockInfo{timestamp: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<ClockInfo>(v0);
    }

    // decompiled from Move bytecode v6
}

