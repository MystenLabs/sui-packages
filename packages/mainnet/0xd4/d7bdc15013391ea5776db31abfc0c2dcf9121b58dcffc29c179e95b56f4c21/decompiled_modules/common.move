module 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common {
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
        assert!(!0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::neg(arg0), 440708559177319000);
        0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::full_math_u128::mul_div_floor(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::value(arg0), 18446744073709551616, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::pow_10(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::dec(arg0)))
    }

    public fun epoch() : u64 {
        43200
    }

    public fun epoch_next(arg0: u64) : u64 {
        arg0 - arg0 % 43200 + 43200
    }

    public fun epoch_prev(arg0: u64) : u64 {
        arg0 - arg0 % 43200 - 43200
    }

    public fun epoch_start(arg0: u64) : u64 {
        arg0 - arg0 % 43200
    }

    public fun epoch_to_seconds(arg0: u64) : u64 {
        arg0 * 43200
    }

    public fun epoch_vote_end(arg0: u64) : u64 {
        epoch_next(arg0) - 3600
    }

    public fun epoch_vote_start(arg0: u64) : u64 {
        epoch_start(arg0) + 3600
    }

    public fun get_time_checked_price_q64(arg0: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg1: &0x2::clock::Clock) : u128 {
        let v0 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::current_result(arg0);
        assert!(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::timestamp_ms(v0) > 0x2::clock::timestamp_ms(arg1) - 60000, 286529906002696900);
        let v1 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::result(v0);
        assert!(!0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::neg(v1), 986261309772136700);
        decimal_to_q64(v1)
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
        43200
    }

    public fun number_epochs_in_timestamp(arg0: u64) : u64 {
        arg0 / 43200
    }

    public fun o_sail_discount() : u64 {
        50000000
    }

    public fun o_sail_duration() : u64 {
        43200 * 4
    }

    public fun persent_denominator() : u64 {
        100000000
    }

    public fun to_period(arg0: u64) : u64 {
        arg0 / 43200 * 43200
    }

    public fun usd_q64_to_asset_q64(arg0: u128, arg1: u128) : u128 {
        0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::full_math_u128::mul_div_floor(arg0, 18446744073709551616, arg1)
    }

    public fun week() : u64 {
        604800
    }

    // decompiled from Move bytecode v6
}

