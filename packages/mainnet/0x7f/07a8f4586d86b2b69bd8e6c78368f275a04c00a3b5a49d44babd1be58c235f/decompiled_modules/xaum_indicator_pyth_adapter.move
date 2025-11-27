module 0x7f07a8f4586d86b2b69bd8e6c78368f275a04c00a3b5a49d44babd1be58c235f::xaum_indicator_pyth_adapter {
    fun convert_price_to_u256(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64) : u256 {
        let v0 = if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(arg0)) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(arg0)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(arg0)
        };
        let v1 = if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(arg1)) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(arg1)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(arg1)
        };
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(arg1)) {
            (v0 as u256) * 1000000000000000000 / (0x1::u64::pow(10, (v1 as u8)) as u256)
        } else {
            (v0 as u256) * (0x1::u64::pow(10, (v1 as u8)) as u256) * 0x1::u256::pow(10, ((18 - v1) as u8))
        }
    }

    public fun get_ema120_current(arg0: &0xa1663c30a7a9603e8f4f5e4705790c2a68faf6457e39d4a75b922fe48b050f16::xaum_indicator_core::PriceStorage) : u256 {
        0xa1663c30a7a9603e8f4f5e4705790c2a68faf6457e39d4a75b922fe48b050f16::xaum_indicator_core::get_ema120_current(arg0)
    }

    public fun get_latest_price(arg0: &0xa1663c30a7a9603e8f4f5e4705790c2a68faf6457e39d4a75b922fe48b050f16::xaum_indicator_core::PriceStorage) : u256 {
        0xa1663c30a7a9603e8f4f5e4705790c2a68faf6457e39d4a75b922fe48b050f16::xaum_indicator_core::get_latest_price(arg0)
    }

    public fun init_feed(arg0: &0xa1663c30a7a9603e8f4f5e4705790c2a68faf6457e39d4a75b922fe48b050f16::xaum_indicator_core::AdminCap, arg1: &mut 0xa1663c30a7a9603e8f4f5e4705790c2a68faf6457e39d4a75b922fe48b050f16::xaum_indicator_core::PriceStorage, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &mut 0x2::tx_context::TxContext) {
        0xa1663c30a7a9603e8f4f5e4705790c2a68faf6457e39d4a75b922fe48b050f16::xaum_indicator_core::assert_admin(arg1, arg0);
        assert!(!0xa1663c30a7a9603e8f4f5e4705790c2a68faf6457e39d4a75b922fe48b050f16::xaum_indicator_core::is_pyth_feed_bound(arg1), 59906);
        0xa1663c30a7a9603e8f4f5e4705790c2a68faf6457e39d4a75b922fe48b050f16::xaum_indicator_core::bind_pyth_feed_id(arg1, arg0, 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2));
    }

    public fun update_xaum_price(arg0: &0xa1663c30a7a9603e8f4f5e4705790c2a68faf6457e39d4a75b922fe48b050f16::xaum_indicator_core::AdminCap, arg1: &mut 0xa1663c30a7a9603e8f4f5e4705790c2a68faf6457e39d4a75b922fe48b050f16::xaum_indicator_core::PriceStorage, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &mut 0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xa1663c30a7a9603e8f4f5e4705790c2a68faf6457e39d4a75b922fe48b050f16::xaum_indicator_core::assert_admin(arg1, arg0);
        assert!(0x1::type_name::with_defining_ids<0x2::sui::SUI>() == 0xa1663c30a7a9603e8f4f5e4705790c2a68faf6457e39d4a75b922fe48b050f16::xaum_indicator_core::get_asset_type(arg1), 59905);
        assert!(0xa1663c30a7a9603e8f4f5e4705790c2a68faf6457e39d4a75b922fe48b050f16::xaum_indicator_core::is_pyth_feed_bound(arg1), 59907);
        let v0 = 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2);
        assert!(0xa1663c30a7a9603e8f4f5e4705790c2a68faf6457e39d4a75b922fe48b050f16::xaum_indicator_core::is_matching_pyth_feed_id(arg1, &v0), 59908);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg2, arg4, 60);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v1);
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v2)) {
            return
        };
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v1);
        let v4 = if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v3)) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v3)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v3)
        };
        if (!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v3) && v4 > 18) {
            return
        };
        0xa1663c30a7a9603e8f4f5e4705790c2a68faf6457e39d4a75b922fe48b050f16::xaum_indicator_core::update_price_storage_external(arg1, convert_price_to_u256(&v2, &v3));
        0xa1663c30a7a9603e8f4f5e4705790c2a68faf6457e39d4a75b922fe48b050f16::xaum_indicator_core::push_gr_indicators_to_x_oracle(arg1, arg0, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

