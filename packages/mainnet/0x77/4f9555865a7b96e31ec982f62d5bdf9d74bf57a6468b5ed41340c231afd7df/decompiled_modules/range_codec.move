module 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::range_codec {
    struct Strike has copy, drop {
        pos0: u64,
    }

    public(friend) fun grid_tick(arg0: u64, arg1: u64) : u64 {
        arg0 / arg1
    }

    public(friend) fun is_neg_inf(arg0: Strike) : bool {
        arg0.pos0 == 0
    }

    public(friend) fun is_pos_inf(arg0: Strike) : bool {
        arg0.pos0 == 18446744073709551615
    }

    public(friend) fun prefix_limit_tick(arg0: u64, arg1: u64) : u64 {
        0x1::u64::div_ceil(arg0, arg1)
    }

    public(friend) fun settlement_in_range(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        let v0 = prefix_limit_tick(arg2, arg3);
        arg0 < v0 && (arg1 == 1073741823 || v0 <= arg1)
    }

    public fun strike_from_tick(arg0: u64, arg1: u64) : Strike {
        if (arg0 == 0) {
            return Strike{pos0: 0}
        };
        if (arg0 == 1073741823) {
            return Strike{pos0: 18446744073709551615}
        };
        Strike{pos0: arg0 * arg1}
    }

    public(friend) fun value(arg0: Strike) : u64 {
        arg0.pos0
    }

    // decompiled from Move bytecode v7
}

