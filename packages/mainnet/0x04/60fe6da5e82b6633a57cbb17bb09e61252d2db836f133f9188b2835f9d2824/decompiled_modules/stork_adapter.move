module 0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::stork_adapter {
    public fun get_stork_price<T0>(arg0: &0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::OracleRegistry, arg1: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::StorkState, arg2: &0x2::clock::Clock, arg3: u64) : 0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::NormalizedPrice {
        0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::check_version(arg0);
        let v0 = 0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::get_config<T0>(arg0);
        assert!(0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::is_stork_enabled<T0>(v0), 8);
        let v1 = 0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::config_stork_feeder_id<T0>(v0);
        assert!(0x1::option::is_some<vector<u8>>(&v1), 9);
        let v2 = 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::stork::get_temporal_numeric_value_unchecked(arg1, *0x1::option::borrow<vector<u8>>(&v1));
        let v3 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v4 = 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value::get_timestamp_ns(&v2) / 1000000000;
        assert!(v3 <= v4 || v3 - v4 <= arg3, 10);
        normalize_stork_value(&v2)
    }

    fun normalize_stork_value(arg0: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value::TemporalNumericValue) : 0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::NormalizedPrice {
        let v0 = 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value::get_quantized_value(arg0);
        assert!(!0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::i128::is_negative(&v0), 11);
        let v1 = 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::i128::get_magnitude_if_positive(&v0);
        assert!(v1 > 0, 12);
        0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::make_stork_price(v1, 0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::zo_i64::new(18, true), 0, 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value::get_timestamp_ns(arg0) / 1000000000)
    }

    // decompiled from Move bytecode v6
}

