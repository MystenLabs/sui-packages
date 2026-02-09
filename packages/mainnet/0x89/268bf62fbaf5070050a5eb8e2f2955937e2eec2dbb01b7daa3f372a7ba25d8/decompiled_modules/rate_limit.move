module 0x89268bf62fbaf5070050a5eb8e2f2955937e2eec2dbb01b7daa3f372a7ba25d8::rate_limit {
    struct RateLimit has store {
        window_ms: u64,
        amount: u64,
        window_start_ms: u64,
        volume: u64,
    }

    public(friend) fun new() : RateLimit {
        RateLimit{
            window_ms       : 3600000,
            amount          : 0,
            window_start_ms : 0,
            volume          : 0,
        }
    }

    public(friend) fun set(arg0: &mut RateLimit, arg1: u64, arg2: u64) {
        assert!(arg1 > 0, 58);
        arg0.window_ms = arg1;
        arg0.amount = arg2;
        0x89268bf62fbaf5070050a5eb8e2f2955937e2eec2dbb01b7daa3f372a7ba25d8::structs::emit_rate_limit_set(arg1, arg2);
    }

    public(friend) fun track(arg0: &mut RateLimit, arg1: u64, arg2: u64) {
        assert!(arg0.amount > 0, 55);
        if (arg2 >= arg0.window_start_ms + arg0.window_ms) {
            arg0.window_start_ms = arg2;
            arg0.volume = 0;
        };
        assert!(arg0.volume + arg1 <= arg0.amount, 53);
        arg0.volume = arg0.volume + arg1;
    }

    // decompiled from Move bytecode v6
}

