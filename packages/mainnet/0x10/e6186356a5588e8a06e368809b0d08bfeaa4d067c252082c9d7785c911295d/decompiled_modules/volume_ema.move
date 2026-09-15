module 0x10e6186356a5588e8a06e368809b0d08bfeaa4d067c252082c9d7785c911295d::volume_ema {
    struct State has drop, store {
        started_ms: u64,
        updated_ms: u64,
        rate_scaled: u128,
        tau_ms: u64,
    }

    public(friend) fun below(arg0: &State, arg1: u64, arg2: u64) : bool {
        daily_volume(arg0, arg1) < (arg2 as u128)
    }

    public(friend) fun daily_volume(arg0: &State, arg1: u64) : u128 {
        assert!(arg1 >= arg0.updated_ms, 1);
        let v0 = (decay(arg0.rate_scaled, arg1 - arg0.updated_ms, arg0.tau_ms) as u256);
        let v1 = if (v0 % 1000000000000 > 0) {
            1
        } else {
            0
        };
        ((v0 / 1000000000000 + v1) as u128)
    }

    public(friend) fun decay(arg0: u128, arg1: u64, arg2: u64) : u128 {
        assert!(arg2 >= 86400000, 1);
        if (arg1 == 0 || arg0 == 0) {
            return arg0
        };
        if (arg1 / arg2 >= 128) {
            return 0
        };
        let v0 = 1000000000000000000000000000000000000;
        let v1 = 1000000000000000000000000000000000000;
        let v2 = 1;
        while (v2 <= 24) {
            v0 = v0 * (arg1 as u256) * 1000000000000000000000000000000000000 / (arg2 as u256) / 256 / 1000000000000000000000000000000000000 * v2;
            v1 = v1 + v0;
            v2 = v2 + 1;
        };
        let v3 = 1000000000000000000000000000000000000 * 1000000000000000000000000000000000000 / v1;
        v2 = 0;
        while (v2 < 8) {
            let v4 = v3 * v3;
            v3 = v4 / 1000000000000000000000000000000000000;
            v2 = v2 + 1;
        };
        let v5 = (arg0 as u256) * 0x1::u256::min(1000000000000000000000000000000000000, v3 + 512);
        let v6 = if (v5 % 1000000000000000000000000000000000000 > 0) {
            1
        } else {
            0
        };
        ((v5 / 1000000000000000000000000000000000000 + v6) as u128)
    }

    public(friend) fun horizon_ms(arg0: &State) : u64 {
        arg0.tau_ms
    }

    public(friend) fun new(arg0: u64, arg1: u64) : State {
        assert!(arg1 >= 86400000, 1);
        State{
            started_ms  : arg0,
            updated_ms  : arg0,
            rate_scaled : 0,
            tau_ms      : arg1,
        }
    }

    public(friend) fun ready(arg0: &State, arg1: u64, arg2: u64) : bool {
        arg1 >= arg0.started_ms && arg1 - arg0.started_ms >= arg2
    }

    public(friend) fun record(arg0: &mut State, arg1: u64, arg2: u64) {
        assert!(arg2 >= arg0.updated_ms, 1);
        let v0 = (decay(arg0.rate_scaled, arg2 - arg0.updated_ms, arg0.tau_ms) as u256);
        let v1 = (arg1 as u256) * (86400000 as u256) * 1000000000000;
        let v2 = if (v1 % (arg0.tau_ms as u256) > 0) {
            1
        } else {
            0
        };
        let v3 = v1 / (arg0.tau_ms as u256) + v2;
        assert!(v0 <= 340282366920938463463374607431768211455 - v3, 2);
        arg0.rate_scaled = ((v0 + v3) as u128);
        arg0.updated_ms = arg2;
    }

    public(friend) fun reset_horizon(arg0: &mut State, arg1: u64, arg2: u64) {
        assert!(arg1 >= arg0.updated_ms && arg2 >= 86400000, 1);
        if (arg0.tau_ms != arg2) {
            arg0.tau_ms = arg2;
            arg0.started_ms = arg1;
            arg0.updated_ms = arg1;
            arg0.rate_scaled = 0;
        };
    }

    public(friend) fun started_ms(arg0: &State) : u64 {
        arg0.started_ms
    }

    public(friend) fun updated_ms(arg0: &State) : u64 {
        arg0.updated_ms
    }

    // decompiled from Move bytecode v7
}

