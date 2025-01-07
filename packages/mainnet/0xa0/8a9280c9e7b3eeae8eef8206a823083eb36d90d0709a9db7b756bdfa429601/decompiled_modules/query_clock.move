module 0xa08a9280c9e7b3eeae8eef8206a823083eb36d90d0709a9db7b756bdfa429601::query_clock {
    struct ClockInfo has copy, drop {
        timestamp: u64,
    }

    public fun query_clock(arg0: &0x2::clock::Clock) {
        let v0 = ClockInfo{timestamp: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<ClockInfo>(v0);
    }

    // decompiled from Move bytecode v6
}

