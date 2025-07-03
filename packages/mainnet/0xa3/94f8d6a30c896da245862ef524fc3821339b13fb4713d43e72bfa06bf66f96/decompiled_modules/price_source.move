module 0xa394f8d6a30c896da245862ef524fc3821339b13fb4713d43e72bfa06bf66f96::price_source {
    struct MmtOraclePriceSource has drop {
        dummy_field: bool,
    }

    fun scale_price_to_formatted_decimals(arg0: u64, arg1: u8) : u64 {
        if (arg1 < 9) {
            arg0 * 0x2::math::pow(10, 9 - arg1)
        } else {
            arg0 / 0x2::math::pow(10, arg1 - 9)
        }
    }

    public fun set_k_oracle_price<T0>(arg0: &mut 0x68de0e378e28e8e809314f85f1e849be26d3ebfee71bcdf43a196918fc58a4eb::oracle::PriceReceipt<T0>, arg1: &0x68de0e378e28e8e809314f85f1e849be26d3ebfee71bcdf43a196918fc58a4eb::oracle::MmtOracle, arg2: &0xa394f8d6a30c896da245862ef524fc3821339b13fb4713d43e72bfa06bf66f96::registry::Registry, arg3: bool, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x2::clock::Clock) {
        0xa394f8d6a30c896da245862ef524fc3821339b13fb4713d43e72bfa06bf66f96::version::assert_current_version(0xa394f8d6a30c896da245862ef524fc3821339b13fb4713d43e72bfa06bf66f96::registry::version(arg2));
        0xa394f8d6a30c896da245862ef524fc3821339b13fb4713d43e72bfa06bf66f96::registry::assert_pyth_price_info_object<T0>(arg2, arg5);
        let (v0, v1, v2) = 0xa394f8d6a30c896da245862ef524fc3821339b13fb4713d43e72bfa06bf66f96::pyth_adapter::get_pyth_price(arg4, arg5, arg6);
        if (arg3) {
            let v3 = MmtOraclePriceSource{dummy_field: false};
            0x68de0e378e28e8e809314f85f1e849be26d3ebfee71bcdf43a196918fc58a4eb::oracle::set_primary_price<T0, MmtOraclePriceSource>(v3, arg0, arg1, scale_price_to_formatted_decimals(v0, v1), v2);
        } else {
            let v4 = MmtOraclePriceSource{dummy_field: false};
            0x68de0e378e28e8e809314f85f1e849be26d3ebfee71bcdf43a196918fc58a4eb::oracle::set_secondary_price<T0, MmtOraclePriceSource>(v4, arg0, arg1, scale_price_to_formatted_decimals(v0, v1), v2);
        };
    }

    // decompiled from Move bytecode v6
}

