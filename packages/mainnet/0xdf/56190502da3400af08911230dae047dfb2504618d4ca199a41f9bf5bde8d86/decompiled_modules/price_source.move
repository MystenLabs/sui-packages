module 0xdf56190502da3400af08911230dae047dfb2504618d4ca199a41f9bf5bde8d86::price_source {
    struct KOraclePriceSource has drop {
        dummy_field: bool,
    }

    fun scale_price_to_formatted_decimals(arg0: u64, arg1: u8) : u64 {
        if (arg1 < 9) {
            arg0 * 0x2::math::pow(10, 9 - arg1)
        } else {
            arg0 / 0x2::math::pow(10, arg1 - 9)
        }
    }

    public fun set_k_oracle_price<T0>(arg0: &mut 0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::oracle::PriceReceipt<T0>, arg1: &0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::oracle::KriyaOracle, arg2: &0xdf56190502da3400af08911230dae047dfb2504618d4ca199a41f9bf5bde8d86::registry::Registry, arg3: bool, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x2::clock::Clock) {
        0xdf56190502da3400af08911230dae047dfb2504618d4ca199a41f9bf5bde8d86::version::assert_current_version(0xdf56190502da3400af08911230dae047dfb2504618d4ca199a41f9bf5bde8d86::registry::version(arg2));
        0xdf56190502da3400af08911230dae047dfb2504618d4ca199a41f9bf5bde8d86::registry::assert_pyth_price_info_object<T0>(arg2, arg5);
        let (v0, v1, v2) = 0xdf56190502da3400af08911230dae047dfb2504618d4ca199a41f9bf5bde8d86::pyth_adapter::get_pyth_price(arg4, arg5, arg6);
        if (arg3) {
            let v3 = KOraclePriceSource{dummy_field: false};
            0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::oracle::set_primary_price<T0, KOraclePriceSource>(v3, arg0, arg1, scale_price_to_formatted_decimals(v0, v1), v2);
        } else {
            let v4 = KOraclePriceSource{dummy_field: false};
            0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::oracle::set_secondary_price<T0, KOraclePriceSource>(v4, arg0, arg1, scale_price_to_formatted_decimals(v0, v1), v2);
        };
    }

    // decompiled from Move bytecode v6
}

