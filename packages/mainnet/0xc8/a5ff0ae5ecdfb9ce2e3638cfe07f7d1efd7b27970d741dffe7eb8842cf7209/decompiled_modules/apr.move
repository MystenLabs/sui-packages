module 0xc8a5ff0ae5ecdfb9ce2e3638cfe07f7d1efd7b27970d741dffe7eb8842cf7209::apr {
    struct AprState has copy, drop, store {
        apr: u256,
        last_ratio: u256,
        last_sync_ms: u64,
    }

    public(friend) fun annualize(arg0: u64, arg1: u64, arg2: u64) : u256 {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg2 == 0
        };
        if (v0) {
            return 0
        };
        (arg0 as u256) * 31536000000 * 1000000000000000000 / (arg1 as u256) * (arg2 as u256)
    }

    public fun new() : AprState {
        AprState{
            apr          : 0,
            last_ratio   : 0,
            last_sync_ms : 0,
        }
    }

    public fun observe_ratio(arg0: &mut AprState, arg1: u256, arg2: u64) {
        if (arg0.last_sync_ms == 0) {
            arg0.last_ratio = arg1;
            arg0.last_sync_ms = arg2;
            return
        };
        if (arg2 <= arg0.last_sync_ms || arg2 - arg0.last_sync_ms < 180000) {
            return
        };
        if (arg0.last_ratio > 0 && arg1 > arg0.last_ratio) {
            let v0 = (arg1 - arg0.last_ratio) * 31536000000 * 1000000000000000000 / arg0.last_ratio * ((arg2 - arg0.last_sync_ms) as u256);
            let v1 = if (v0 > 10000000000000000000) {
                10000000000000000000
            } else {
                v0
            };
            arg0.apr = v1;
        };
        arg0.last_ratio = arg1;
        arg0.last_sync_ms = arg2;
    }

    public fun ratio_from_amounts(arg0: u64, arg1: u64) : u256 {
        if (arg1 == 0) {
            0
        } else {
            (arg0 as u256) * 1000000000000000000 / (arg1 as u256)
        }
    }

    public fun set(arg0: &mut AprState, arg1: u256) {
        arg0.apr = arg1;
    }

    public fun value(arg0: &AprState) : u256 {
        arg0.apr
    }

    // decompiled from Move bytecode v7
}

