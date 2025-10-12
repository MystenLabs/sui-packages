module 0x8a2becbfd338901bed86275f02b47b68bcc37bc7ef9e25bce83897c2f5134db0::xaum_indicator_pyth_adapter {
    public fun get_ema120_current(arg0: &0x3cb5ee3e66d3d113fa8edf590578fb2121462c0596d530ab16e68c74515cb6e6::xaum_indicator_core::PriceStorage) : u256 {
        0x3cb5ee3e66d3d113fa8edf590578fb2121462c0596d530ab16e68c74515cb6e6::xaum_indicator_core::get_ema120_current(arg0)
    }

    public fun get_latest_price(arg0: &0x3cb5ee3e66d3d113fa8edf590578fb2121462c0596d530ab16e68c74515cb6e6::xaum_indicator_core::PriceStorage) : u256 {
        0x3cb5ee3e66d3d113fa8edf590578fb2121462c0596d530ab16e68c74515cb6e6::xaum_indicator_core::get_latest_price(arg0)
    }

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

    public fun init_feed(arg0: &mut 0x3cb5ee3e66d3d113fa8edf590578fb2121462c0596d530ab16e68c74515cb6e6::xaum_indicator_core::PriceStorage, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x3cb5ee3e66d3d113fa8edf590578fb2121462c0596d530ab16e68c74515cb6e6::xaum_indicator_core::is_pyth_feed_bound(arg0), 59906);
        0x3cb5ee3e66d3d113fa8edf590578fb2121462c0596d530ab16e68c74515cb6e6::xaum_indicator_core::bind_pyth_feed_id(arg0, 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1));
    }

    public fun update_xaum_price(arg0: &mut 0x3cb5ee3e66d3d113fa8edf590578fb2121462c0596d530ab16e68c74515cb6e6::xaum_indicator_core::PriceStorage, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::type_name::with_defining_ids<0x2::sui::SUI>() == 0x3cb5ee3e66d3d113fa8edf590578fb2121462c0596d530ab16e68c74515cb6e6::xaum_indicator_core::get_asset_type(arg0), 59905);
        assert!(0x3cb5ee3e66d3d113fa8edf590578fb2121462c0596d530ab16e68c74515cb6e6::xaum_indicator_core::is_pyth_feed_bound(arg0), 59907);
        let v0 = 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1);
        assert!(0x3cb5ee3e66d3d113fa8edf590578fb2121462c0596d530ab16e68c74515cb6e6::xaum_indicator_core::is_matching_pyth_feed_id(arg0, &v0), 59908);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg1, arg2, 60);
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
        0x3cb5ee3e66d3d113fa8edf590578fb2121462c0596d530ab16e68c74515cb6e6::xaum_indicator_core::update_price_storage_external(arg0, convert_price_to_u256(&v2, &v3));
    }

    // decompiled from Move bytecode v6
}

