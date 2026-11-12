module 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::errors {
    public(friend) fun absorb_then_liquidate_unsupported() : u64 {
        6
    }

    public(friend) fun invalid_decimals() : u64 {
        5
    }

    public(friend) fun invalid_liquidation() : u64 {
        3
    }

    public(friend) fun invalid_liquidation_amt() : u64 {
        2
    }

    public(friend) fun invalid_oracle_price() : u64 {
        4
    }

    public(friend) fun top_tick_does_not_exist() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

