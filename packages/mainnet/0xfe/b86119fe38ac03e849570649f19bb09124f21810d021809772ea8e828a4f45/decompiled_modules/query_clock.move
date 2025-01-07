module 0xfeb86119fe38ac03e849570649f19bb09124f21810d021809772ea8e828a4f45::query_clock {
    struct ClockInfo has copy, drop {
        timestamp: u64,
    }

    public fun query_clock(arg0: &0x2::clock::Clock) {
        let v0 = ClockInfo{timestamp: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<ClockInfo>(v0);
    }

    // decompiled from Move bytecode v6
}

