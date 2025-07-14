module 0x6599f870e484d8a03d75b6edba5df9d9b45e3a4b26fd6358f620666bf5698266::time_manager {
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
        21600
    }

    public fun epoch_next(arg0: u64) : u64 {
        arg0 - arg0 % 21600 + 21600
    }

    public fun epoch_prev(arg0: u64) : u64 {
        arg0 - arg0 % 21600 - 21600
    }

    public fun epoch_start(arg0: u64) : u64 {
        arg0 - arg0 % 21600
    }

    public fun epoch_to_seconds(arg0: u64) : u64 {
        arg0 * 21600
    }

    public fun epoch_vote_end(arg0: u64) : u64 {
        arg0 - arg0 % 21600 + 21600 - 3600
    }

    public fun epoch_vote_start(arg0: u64) : u64 {
        arg0 - arg0 % 21600 + 3600
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
        21600
    }

    public fun number_epochs_in_timestamp(arg0: u64) : u64 {
        arg0 / 21600
    }

    public fun to_period(arg0: u64) : u64 {
        arg0 / 21600 * 21600
    }

    public fun week() : u64 {
        604800
    }

    // decompiled from Move bytecode v6
}

