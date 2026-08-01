module 0xe338cb78badd67607b64c62661534572248a23500503c7e65f56bdba68e71952::circuit_breaker {
    struct PriceAttestation has copy, drop, store {
        feed_id: 0x2::object::ID,
        price_1e18: u128,
        attested_at_ms: u64,
        sample_age_ms: u64,
        dispersion_bps: u64,
        band_bps: u64,
    }

    public fun assert_execution_quality(arg0: u64, arg1: u64) {
        assert!(arg0 >= arg1, 305);
    }

    public fun assert_feed(arg0: &PriceAttestation, arg1: 0x2::object::ID) {
        assert!(arg0.feed_id == arg1, 307);
    }

    public fun attest(arg0: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64) : PriceAttestation {
        let v0 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::current_result(arg0);
        let v1 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::result(v0);
        assert!(!0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::neg(v1), 300);
        let v2 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::value(v1);
        assert!(v2 > 0, 301);
        let v3 = 0x2::clock::timestamp_ms(arg1);
        assert!(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::max_timestamp_ms(v0) <= v3, 306);
        let v4 = v3 - 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::min_timestamp_ms(v0);
        assert!(v4 <= arg2, 302);
        let v5 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::value(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::mean(v0));
        let v6 = 0xe338cb78badd67607b64c62661534572248a23500503c7e65f56bdba68e71952::math::to_bps(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::value(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::stdev(v0)), v5);
        assert!(v6 <= arg3, 303);
        let v7 = 0xe338cb78badd67607b64c62661534572248a23500503c7e65f56bdba68e71952::math::to_bps(0xe338cb78badd67607b64c62661534572248a23500503c7e65f56bdba68e71952::math::abs_diff_u128(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::value(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::max_result(v0)), 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::value(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::min_result(v0))), v5);
        assert!(v7 <= arg3, 304);
        PriceAttestation{
            feed_id        : 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::id(arg0),
            price_1e18     : v2,
            attested_at_ms : v3,
            sample_age_ms  : v4,
            dispersion_bps : v6,
            band_bps       : v7,
        }
    }

    public fun attested_at_ms(arg0: &PriceAttestation) : u64 {
        arg0.attested_at_ms
    }

    public fun band_bps(arg0: &PriceAttestation) : u64 {
        arg0.band_bps
    }

    public fun dispersion_bps(arg0: &PriceAttestation) : u64 {
        arg0.dispersion_bps
    }

    public fun fair_value_out(arg0: &PriceAttestation, arg1: u64, arg2: u8, arg3: u8) : u64 {
        let v0 = 0xe338cb78badd67607b64c62661534572248a23500503c7e65f56bdba68e71952::math::rescale(0xe338cb78badd67607b64c62661534572248a23500503c7e65f56bdba68e71952::math::mul_div_u128((arg1 as u128), arg0.price_1e18, (0xe338cb78badd67607b64c62661534572248a23500503c7e65f56bdba68e71952::math::pow10(18) as u128)), arg2, arg3);
        assert!(v0 <= 18446744073709551615, 305);
        (v0 as u64)
    }

    public fun feed_id(arg0: &PriceAttestation) : 0x2::object::ID {
        arg0.feed_id
    }

    public fun minimum_acceptable_out(arg0: &PriceAttestation, arg1: u64, arg2: u8, arg3: u8, arg4: u64) : u64 {
        0xe338cb78badd67607b64c62661534572248a23500503c7e65f56bdba68e71952::math::bps_complement_of(fair_value_out(arg0, arg1, arg2, arg3), arg4)
    }

    public fun price_1e18(arg0: &PriceAttestation) : u128 {
        arg0.price_1e18
    }

    public fun realised_slippage_bps(arg0: u64, arg1: u64) : u64 {
        if (arg0 >= arg1 || arg1 == 0) {
            return 0
        };
        0xe338cb78badd67607b64c62661534572248a23500503c7e65f56bdba68e71952::math::to_bps(((arg1 - arg0) as u128), (arg1 as u128))
    }

    public fun sample_age_ms(arg0: &PriceAttestation) : u64 {
        arg0.sample_age_ms
    }

    // decompiled from Move bytecode v7
}

