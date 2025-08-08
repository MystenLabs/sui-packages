module 0xce074c6609ab58a4c6545900db6cd73a985956478cd4f1d68349e8de3048707c::errors {
    public fun error_current_tick_out_of_range() : u64 {
        4
    }

    public fun error_invalid_owner() : u64 {
        0
    }

    public fun error_invalid_rebalance_cooldown() : u64 {
        2
    }

    public fun error_invalid_rebalance_paused() : u64 {
        1
    }

    public fun error_last_rebalance_timestamp_after_current_timestamp() : u64 {
        3
    }

    // decompiled from Move bytecode v6
}

