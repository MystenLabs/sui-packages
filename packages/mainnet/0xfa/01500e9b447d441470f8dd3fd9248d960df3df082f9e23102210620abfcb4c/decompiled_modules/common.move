module 0xfa01500e9b447d441470f8dd3fd9248d960df3df082f9e23102210620abfcb4c::common {
    public fun asset_q64_to_usd_q64(arg0: u128, arg1: u128, arg2: bool) : u128 {
        if (arg2) {
            0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::full_math_u128::mul_div_ceil(arg0, arg1, 18446744073709551616)
        } else {
            0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::full_math_u128::mul_div_floor(arg0, arg1, 18446744073709551616)
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

    public fun decimal_to_q64(arg0: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::Decimal) : u128 {
        decimal_to_q64_decimals(arg0, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::pow_10(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::dec(arg0)))
    }

    public fun decimal_to_q64_decimals(arg0: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::Decimal, arg1: u128) : u128 {
        assert!(!0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::neg(arg0), 440708559177319000);
        0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::full_math_u128::mul_div_floor(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::value(arg0), 18446744073709551616, arg1)
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
        epoch_next(arg0) - 3600
    }

    public fun epoch_vote_start(arg0: u64) : u64 {
        epoch_start(arg0) + 3600
    }

    public fun get_time_checked_price_q64(arg0: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg1: u8, arg2: u8, arg3: &0x2::clock::Clock) : u128 {
        let v0 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::current_result(arg0);
        assert!(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::timestamp_ms(v0) + 60000 > 0x2::clock::timestamp_ms(arg3), 286529906002696900);
        let v1 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::result(v0);
        assert!(!0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::neg(v1), 986261309772136700);
        let v2 = if (arg1 > arg2) {
            0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::dec(v1) + arg1 - arg2
        } else {
            0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::dec(v1) - arg2 - arg1
        };
        decimal_to_q64_decimals(v1, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::pow_10(v2))
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

    public fun o_sail_discount() : u64 {
        50000000
    }

    public fun o_sail_duration() : u64 {
        604800 * 4
    }

    public fun persent_denominator() : u64 {
        100000000
    }

    public fun sail_decimals() : u8 {
        6
    }

    public fun to_period(arg0: u64) : u64 {
        arg0 / 604800 * 604800
    }

    public fun usd_decimals() : u8 {
        6
    }

    public fun usd_q64_to_asset_q64(arg0: u128, arg1: u128) : u128 {
        0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::full_math_u128::mul_div_floor(arg0, 18446744073709551616, arg1)
    }

    public fun week() : u64 {
        604800
    }

    // decompiled from Move bytecode v6
}

