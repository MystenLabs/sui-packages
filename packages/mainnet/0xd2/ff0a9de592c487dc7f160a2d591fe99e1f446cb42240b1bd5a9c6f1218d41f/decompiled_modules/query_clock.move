module 0xd2ff0a9de592c487dc7f160a2d591fe99e1f446cb42240b1bd5a9c6f1218d41f::query_clock {
    struct ClockInfo has copy, drop {
        timestamp: u64,
    }

    public fun query_clock(arg0: &0x2::clock::Clock) {
        let v0 = ClockInfo{timestamp: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<ClockInfo>(v0);
    }

    // decompiled from Move bytecode v6
}

