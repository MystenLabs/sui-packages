module 0xdc9db55b752d1bcdd84e67cce275e10a48ed72d91863483cc8061d8de3d038b0::xaum_indicator_pyth_adapter {
    public fun get_ema120_current(arg0: &0x9d217b1d311dcf242bfd92cc4cf79518b93334fbf52d94cf8a64345e5309b21b::xaum_indicator_core::PriceStorage) : u256 {
        0x9d217b1d311dcf242bfd92cc4cf79518b93334fbf52d94cf8a64345e5309b21b::xaum_indicator_core::get_ema120_current(arg0)
    }

    public fun get_latest_price(arg0: &0x9d217b1d311dcf242bfd92cc4cf79518b93334fbf52d94cf8a64345e5309b21b::xaum_indicator_core::PriceStorage) : u256 {
        0x9d217b1d311dcf242bfd92cc4cf79518b93334fbf52d94cf8a64345e5309b21b::xaum_indicator_core::get_latest_price(arg0)
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

    public fun init_feed(arg0: &0x9d217b1d311dcf242bfd92cc4cf79518b93334fbf52d94cf8a64345e5309b21b::xaum_indicator_core::AdminCap, arg1: &mut 0x9d217b1d311dcf242bfd92cc4cf79518b93334fbf52d94cf8a64345e5309b21b::xaum_indicator_core::PriceStorage, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &mut 0x2::tx_context::TxContext) {
        0x9d217b1d311dcf242bfd92cc4cf79518b93334fbf52d94cf8a64345e5309b21b::xaum_indicator_core::assert_admin(arg1, arg0);
        assert!(!0x9d217b1d311dcf242bfd92cc4cf79518b93334fbf52d94cf8a64345e5309b21b::xaum_indicator_core::is_pyth_feed_bound(arg1), 59906);
        0x9d217b1d311dcf242bfd92cc4cf79518b93334fbf52d94cf8a64345e5309b21b::xaum_indicator_core::bind_pyth_feed_id(arg1, arg0, 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2));
    }

    public fun update_xaum_price(arg0: &0x9d217b1d311dcf242bfd92cc4cf79518b93334fbf52d94cf8a64345e5309b21b::xaum_indicator_core::AdminCap, arg1: &mut 0x9d217b1d311dcf242bfd92cc4cf79518b93334fbf52d94cf8a64345e5309b21b::xaum_indicator_core::PriceStorage, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &mut 0x75d76cf4afd63e98f35c94aa28ae78ec4ddf13f4a878c6ef4aeb98e9b580b3d5::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9d217b1d311dcf242bfd92cc4cf79518b93334fbf52d94cf8a64345e5309b21b::xaum_indicator_core::assert_admin(arg1, arg0);
        assert!(0x1::type_name::with_defining_ids<0x2::sui::SUI>() == 0x9d217b1d311dcf242bfd92cc4cf79518b93334fbf52d94cf8a64345e5309b21b::xaum_indicator_core::get_asset_type(arg1), 59905);
        assert!(0x9d217b1d311dcf242bfd92cc4cf79518b93334fbf52d94cf8a64345e5309b21b::xaum_indicator_core::is_pyth_feed_bound(arg1), 59907);
        let v0 = 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2);
        assert!(0x9d217b1d311dcf242bfd92cc4cf79518b93334fbf52d94cf8a64345e5309b21b::xaum_indicator_core::is_matching_pyth_feed_id(arg1, &v0), 59908);
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
        0x9d217b1d311dcf242bfd92cc4cf79518b93334fbf52d94cf8a64345e5309b21b::xaum_indicator_core::update_price_storage_external(arg1, convert_price_to_u256(&v2, &v3));
        0x9d217b1d311dcf242bfd92cc4cf79518b93334fbf52d94cf8a64345e5309b21b::xaum_indicator_core::push_gr_indicators_to_x_oracle(arg1, arg0, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

