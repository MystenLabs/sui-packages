module 0xa9e63b520470ff9abf66b300c54957e7c573c7376e9a281b2114a703631a5e33::errors {
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

