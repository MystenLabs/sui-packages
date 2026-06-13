module 0xd4450b190660b6df4eeb7151dfc249e565ed727aea37bf9aea9266bcece6d8af::reward_apr {
    struct RewardAprState has copy, drop, store {
        apr: u256,
        flow: u64,
        last_sync_ms: u64,
    }

    public fun accrue(arg0: &mut RewardAprState, arg1: u64, arg2: u64) {
        if (arg0.last_sync_ms == 0) {
            arg0.flow = 0;
            arg0.last_sync_ms = arg2;
            return
        };
        let v0 = if (arg0.flow == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg2 <= arg0.last_sync_ms
        };
        if (v0) {
            return
        };
        let v1 = arg2 - arg0.last_sync_ms;
        if (v1 < 3600000) {
            return
        };
        let v2 = 0xd4450b190660b6df4eeb7151dfc249e565ed727aea37bf9aea9266bcece6d8af::apr::annualize(arg0.flow, arg1, v1);
        if (v2 == 0) {
            return
        };
        let v3 = if (v2 > 5000000000000000000) {
            5000000000000000000
        } else {
            v2
        };
        arg0.apr = v3;
        arg0.flow = 0;
        arg0.last_sync_ms = arg2;
    }

    public fun new() : RewardAprState {
        RewardAprState{
            apr          : 0,
            flow         : 0,
            last_sync_ms : 0,
        }
    }

    public fun record(arg0: &mut RewardAprState, arg1: u64) {
        arg0.flow = arg0.flow + arg1;
    }

    public fun value(arg0: &RewardAprState) : u256 {
        arg0.apr
    }

    // decompiled from Move bytecode v7
}

