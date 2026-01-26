module 0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::pyth_adapter {
    fun convert_pyth_i64(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64) : 0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::zo_i64::I64 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(arg0);
        let v1 = if (v0) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(arg0)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(arg0)
        };
        0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::zo_i64::new(v1, v0)
    }

    public fun get_pyth_price<T0>(arg0: &0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::core::OracleRegistry, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock, arg3: u64) : 0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::core::NormalizedPrice {
        0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::core::check_version(arg0);
        let v0 = 0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::core::get_config<T0>(arg0);
        assert!(0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::core::is_pyth_enabled<T0>(v0), 6);
        let v1 = 0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::core::config_pyth_feeder_id<T0>(v0);
        assert!(0x1::option::is_some<0x2::object::ID>(&v1), 5);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::uid_to_inner(arg1) == *0x1::option::borrow<0x2::object::ID>(&v1), 5);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg1);
        let v3 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v2);
        assert!(v3 <= v4 || v3 - v4 <= arg3, 4);
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v2);
        let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v2);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v5), 3);
        let v7 = (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v5) as u128);
        assert!(v7 > 0, 7);
        0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::core::make_pyth_price(v7, convert_pyth_i64(&v6), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v2), v4)
    }

    // decompiled from Move bytecode v6
}

