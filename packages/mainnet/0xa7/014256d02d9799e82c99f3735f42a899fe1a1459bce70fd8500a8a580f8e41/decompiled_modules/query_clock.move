module 0xa7014256d02d9799e82c99f3735f42a899fe1a1459bce70fd8500a8a580f8e41::query_clock {
    struct ClockInfo has copy, drop {
        timestamp: u64,
    }

    public fun query_clock(arg0: &0x2::clock::Clock) {
        let v0 = ClockInfo{timestamp: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<ClockInfo>(v0);
    }

    // decompiled from Move bytecode v6
}

