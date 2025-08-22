module 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::common {
    public fun asset_q64_to_usd_q64(arg0: u128, arg1: u128, arg2: bool) : u128 {
        if (arg2) {
            0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_ceil(arg0, arg1, 18446744073709551616)
        } else {
            0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor(arg0, arg1, 18446744073709551616)
        }
    }

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
        epoch_next(arg0) - 3600
    }

    public fun epoch_vote_start(arg0: u64) : u64 {
        epoch_start(arg0) + 3600
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

    public fun o_sail_discount() : u64 {
        50000000
    }

    public fun o_sail_duration() : u64 {
        21600 * 4
    }

    public fun persent_denominator() : u64 {
        100000000
    }

    public fun sail_decimals() : u8 {
        6
    }

    public fun to_period(arg0: u64) : u64 {
        arg0 / 21600 * 21600
    }

    public fun usd_q64_to_asset_q64(arg0: u128, arg1: u128) : u128 {
        0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_floor(arg0, 18446744073709551616, arg1)
    }

    public fun week() : u64 {
        604800
    }

    // decompiled from Move bytecode v6
}

