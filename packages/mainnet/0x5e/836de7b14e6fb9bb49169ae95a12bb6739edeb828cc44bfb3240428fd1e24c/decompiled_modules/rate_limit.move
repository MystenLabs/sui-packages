module 0x5e836de7b14e6fb9bb49169ae95a12bb6739edeb828cc44bfb3240428fd1e24c::rate_limit {
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
        0x5e836de7b14e6fb9bb49169ae95a12bb6739edeb828cc44bfb3240428fd1e24c::structs::emit_rate_limit_set(arg1, arg2);
    }

    public(friend) fun track(arg0: &mut RateLimit, arg1: u64, arg2: u64) {
        assert!(arg0.amount > 0, 55);
        if (arg2 >= arg0.window_start_ms + arg0.window_ms) {
            let v0 = arg2 - arg0.window_start_ms;
            let v1 = v0 / arg0.window_ms;
            if (v1 >= 2) {
                arg0.volume = 0;
            } else {
                arg0.volume = (((arg0.volume as u128) * ((arg0.window_ms - v0 - arg0.window_ms) as u128) / (arg0.window_ms as u128)) as u64);
            };
            arg0.window_start_ms = arg0.window_start_ms + v1 * arg0.window_ms;
        };
        assert!(arg0.volume + arg1 <= arg0.amount, 53);
        arg0.volume = arg0.volume + arg1;
    }

    // decompiled from Move bytecode v6
}

