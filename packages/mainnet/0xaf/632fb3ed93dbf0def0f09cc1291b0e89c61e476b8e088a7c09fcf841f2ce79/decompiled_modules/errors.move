module 0xaf632fb3ed93dbf0def0f09cc1291b0e89c61e476b8e088a7c09fcf841f2ce79::errors {
    public fun error_current_tick_out_of_range() : u64 {
        4
    }

    public fun error_invalid_compound_interval() : u64 {
        11
    }

    public fun error_invalid_compound_paused() : u64 {
        13
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

    public fun error_invalid_signature() : u64 {
        10
    }

    public fun error_invalid_sqrt_price() : u64 {
        5
    }

    public fun error_invalid_strategy_id() : u64 {
        6
    }

    public fun error_invalid_tick_lower_index() : u64 {
        7
    }

    public fun error_invalid_tick_upper_index() : u64 {
        8
    }

    public fun error_last_compound_timestamp_in_future() : u64 {
        14
    }

    public fun error_last_rebalance_timestamp_after_current_timestamp() : u64 {
        3
    }

    public fun error_position_registry_not_exists() : u64 {
        9
    }

    public fun error_total_position_value_above_trigger_threshold() : u64 {
        15
    }

    public fun error_total_position_value_below_trigger_threshold() : u64 {
        12
    }

    public fun error_version_too_high() : u64 {
        16
    }

    // decompiled from Move bytecode v6
}

