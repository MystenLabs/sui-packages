module 0x5a1be1a62c21d9dab3bfd4d453ebf6dc1df8984285a68eedd6b3c27139b84115::errors {
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

