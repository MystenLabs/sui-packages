module 0xee2b616f5f00d0df943312bea4c4f8d1a5dbc9ccc89014bbe357d3d19ddb4927::common {
    public fun current_period(arg0: &0x2::clock::Clock) : u64 {
        to_period(current_timestamp(arg0))
    }

    public fun current_timestamp(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun day() : u64 {
        86400
    }

    public fun epoch_next(arg0: u64) : u64 {
        arg0 - arg0 % 86400 + 86400
    }

    public fun epoch_start(arg0: u64) : u64 {
        arg0 - arg0 % 86400
    }

    public fun epoch_vote_end(arg0: u64) : u64 {
        arg0 - arg0 % 86400 + 86400 - 3600
    }

    public fun epoch_vote_start(arg0: u64) : u64 {
        arg0 - arg0 % 86400 + 3600
    }

    public fun get_time_to_finality() : u64 {
        500
    }

    public fun hour() : u64 {
        3600
    }

    public fun max_lock_time() : u64 {
        125798400
    }

    public fun min_lock_time() : u64 {
        86400
    }

    public fun to_period(arg0: u64) : u64 {
        arg0 / 86400 * 86400
    }

    public fun week() : u64 {
        86400
    }

    // decompiled from Move bytecode v6
}

