module 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::oracle_pyth {
    struct CanonicalPrice has copy, drop {
        mantissa: u64,
        negative: bool,
        exponent: u8,
        publish_time_ms: u64,
        confidence: u64,
    }

    public fun cmp_gt() : u8 {
        0
    }

    public fun cmp_gte() : u8 {
        1
    }

    public fun cmp_lt() : u8 {
        2
    }

    public fun cmp_lte() : u8 {
        3
    }

    public fun invalidate_after_deadline<T0>(arg0: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::Market<T0>, arg1: &0x2::clock::Clock) {
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::oracle_kind<T0>(arg0) == 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::oracle_kind_pyth(), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::oracle_kind_mismatch());
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::resolve_deadline_ms<T0>(arg0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_too_early());
        assert!(v0 >= 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::settlement_deadline_ms<T0>(arg0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_too_early());
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::set_resolution<T0>(arg0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::status_invalid(), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::payout_half_e6(), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::payout_half_e6(), arg1);
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_market_invalidated(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::protocol_id<T0>(arg0), 0x2::object::id<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::Market<T0>>(arg0));
    }

    public(friend) fun new_canonical_price(arg0: u64, arg1: bool, arg2: u8, arg3: u64, arg4: u64) : CanonicalPrice {
        CanonicalPrice{
            mantissa        : arg0,
            negative        : arg1,
            exponent        : arg2,
            publish_time_ms : arg3,
            confidence      : arg4,
        }
    }

    public(friend) fun resolve_with_canonical_price<T0>(arg0: &mut 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::Market<T0>, arg1: CanonicalPrice, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::oracle<T0>(arg0);
        assert!(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::oracle_kind<T0>(arg0) == 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::oracle_kind_pyth(), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::oracle_kind_mismatch());
        assert!(v0 >= 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::target_timestamp_ms<T0>(arg0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::resolve_too_early());
        assert!(v0 >= 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::settlement_deadline_ms<T0>(arg0), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::resolve_too_early());
        let v2 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::oracle_target_timestamp_ms(&v1);
        assert!(arg1.publish_time_ms >= v2 && arg1.publish_time_ms <= v2 + 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::oracle_publish_window_ms(&v1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::price_out_of_window());
        assert!(arg1.exponent == 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::oracle_threshold_exponent(&v1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_price());
        assert!(!arg1.negative && arg1.mantissa > 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::invalid_price());
        assert!((arg1.confidence as u128) * 10000 / (arg1.mantissa as u128) <= (0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::oracle_max_confidence_ratio_bps(&v1) as u128), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::confidence_too_wide());
        let v3 = 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::oracle_comparison(&v1);
        let (v4, v5, v6) = if (v3 == 0 && arg1.mantissa > 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::oracle_threshold_mantissa(&v1) || v3 == 1 && arg1.mantissa >= 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::oracle_threshold_mantissa(&v1) || v3 == 2 && arg1.mantissa < 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::oracle_threshold_mantissa(&v1) || arg1.mantissa <= 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::oracle_threshold_mantissa(&v1)) {
            (0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::status_resolved_yes(), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::payout_full_e6(), 0)
        } else {
            (0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::status_resolved_no(), 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::payout_full_e6())
        };
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::set_resolution<T0>(arg0, v4, v5, v6, arg2);
        0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::events::emit_market_resolved(0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::protocol_id<T0>(arg0), 0x2::object::id<0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::market::Market<T0>>(arg0), v4, v5, v6, arg1.mantissa, arg1.negative, arg1.exponent, arg1.publish_time_ms);
    }

    // decompiled from Move bytecode v7
}

