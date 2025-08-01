module 0xb5bf2fa7b948647f81a095e57f2a090776a501ad4c8d251d3018299d24025a3d::time_manager {
    public fun current_period(arg0: &0x2::clock::Clock) : u64 {
        to_period(current_timestamp(arg0))
    }

    public fun current_timestamp(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun day() : u64 {
        86400
    }

    public fun epoch() : u64 {
        604800
    }

    public fun epoch_next(arg0: u64) : u64 {
        arg0 - arg0 % 604800 + 604800
    }

    public fun epoch_prev(arg0: u64) : u64 {
        arg0 - arg0 % 604800 - 604800
    }

    public fun epoch_start(arg0: u64) : u64 {
        arg0 - arg0 % 604800
    }

    public fun epoch_to_seconds(arg0: u64) : u64 {
        arg0 * 604800
    }

    public fun epoch_vote_end(arg0: u64) : u64 {
        arg0 - arg0 % 604800 + 604800 - 3600
    }

    public fun epoch_vote_start(arg0: u64) : u64 {
        arg0 - arg0 % 604800 + 3600
    }

    public fun get_time_to_finality_ms() : u64 {
        500
    }

    public fun hour() : u64 {
        3600
    }

    public fun max_lock_time() : u64 {
        125798400
    }

    public fun min_lock_time() : u64 {
        604800
    }

    public fun number_epochs_in_timestamp(arg0: u64) : u64 {
        arg0 / 604800
    }

    public fun to_period(arg0: u64) : u64 {
        arg0 / 604800 * 604800
    }

    public fun week() : u64 {
        604800
    }

    // decompiled from Move bytecode v6
}

