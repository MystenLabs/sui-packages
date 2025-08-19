module 0x454ae856685130db7e5f86851add03d8252cebddbaff59db196548f3bd93d32a::price_source {
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

    public fun set_k_oracle_price<T0>(arg0: &mut 0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::oracle::PriceReceipt<T0>, arg1: &0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::oracle::MmtOracle, arg2: &0x454ae856685130db7e5f86851add03d8252cebddbaff59db196548f3bd93d32a::registry::Registry, arg3: bool, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::registry::SetPriceCapRegistry, arg7: &0x2::clock::Clock) {
        0x454ae856685130db7e5f86851add03d8252cebddbaff59db196548f3bd93d32a::version::assert_current_version(0x454ae856685130db7e5f86851add03d8252cebddbaff59db196548f3bd93d32a::registry::version(arg2));
        0x454ae856685130db7e5f86851add03d8252cebddbaff59db196548f3bd93d32a::registry::assert_pyth_price_info_object<T0>(arg2, arg5);
        let (v0, v1, v2) = 0x454ae856685130db7e5f86851add03d8252cebddbaff59db196548f3bd93d32a::pyth_adapter::get_pyth_price<T0>(arg4, arg5, arg2, arg7);
        if (arg3) {
            let v3 = MmtOraclePriceSource{dummy_field: true};
            0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::oracle::set_primary_price_safe<T0, MmtOraclePriceSource>(v3, arg0, arg1, scale_price_to_formatted_decimals(v0, v1), v2, 0x454ae856685130db7e5f86851add03d8252cebddbaff59db196548f3bd93d32a::registry::get_oracle_set_price_cap(arg2), arg6);
        } else {
            let v4 = MmtOraclePriceSource{dummy_field: false};
            0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::oracle::set_secondary_price_safe<T0, MmtOraclePriceSource>(v4, arg0, arg1, scale_price_to_formatted_decimals(v0, v1), v2, 0x454ae856685130db7e5f86851add03d8252cebddbaff59db196548f3bd93d32a::registry::get_oracle_set_price_cap(arg2), arg6);
        };
    }

    public fun set_mmt_oracle<T0, T1>(arg0: &mut 0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::oracle::PriceReceipt<T0>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::oracle::MmtOracle, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg4: &0x454ae856685130db7e5f86851add03d8252cebddbaff59db196548f3bd93d32a::registry::Registry, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::registry::SetPriceCapRegistry, arg7: &0x2::clock::Clock, arg8: bool) {
        0x454ae856685130db7e5f86851add03d8252cebddbaff59db196548f3bd93d32a::version::assert_current_version(0x454ae856685130db7e5f86851add03d8252cebddbaff59db196548f3bd93d32a::registry::version(arg4));
        0x454ae856685130db7e5f86851add03d8252cebddbaff59db196548f3bd93d32a::registry::assert_pyth_price_info_object<T1>(arg4, arg5);
        let (v0, v1, v2) = 0x454ae856685130db7e5f86851add03d8252cebddbaff59db196548f3bd93d32a::pyth_adapter::get_pyth_price<T1>(arg3, arg5, arg4, arg7);
        if (arg8) {
            let v3 = MmtOraclePriceSource{dummy_field: true};
            0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::oracle::set_primary_price_safe<T0, MmtOraclePriceSource>(v3, arg0, arg2, ((0x454ae856685130db7e5f86851add03d8252cebddbaff59db196548f3bd93d32a::mmt_adapter::get_raw_mmt_price<T0, T1>(arg1) * (scale_price_to_formatted_decimals(v0, v1) as u128) / 18446744073709551616) as u64), v2, 0x454ae856685130db7e5f86851add03d8252cebddbaff59db196548f3bd93d32a::registry::get_oracle_set_price_cap(arg4), arg6);
        } else {
            let v4 = MmtOraclePriceSource{dummy_field: false};
            0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::oracle::set_secondary_price_safe<T0, MmtOraclePriceSource>(v4, arg0, arg2, ((0x454ae856685130db7e5f86851add03d8252cebddbaff59db196548f3bd93d32a::mmt_adapter::get_raw_mmt_price<T0, T1>(arg1) * (scale_price_to_formatted_decimals(v0, v1) as u128) / 18446744073709551616) as u64), v2, 0x454ae856685130db7e5f86851add03d8252cebddbaff59db196548f3bd93d32a::registry::get_oracle_set_price_cap(arg4), arg6);
        };
    }

    // decompiled from Move bytecode v6
}

