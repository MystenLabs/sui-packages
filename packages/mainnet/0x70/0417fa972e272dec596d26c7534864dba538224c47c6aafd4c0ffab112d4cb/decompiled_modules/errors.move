module 0x700417fa972e272dec596d26c7534864dba538224c47c6aafd4c0ffab112d4cb::errors {
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

