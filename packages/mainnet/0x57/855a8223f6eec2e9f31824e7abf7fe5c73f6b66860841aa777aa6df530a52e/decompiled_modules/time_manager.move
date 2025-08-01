module 0x57855a8223f6eec2e9f31824e7abf7fe5c73f6b66860841aa777aa6df530a52e::time_manager {
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

