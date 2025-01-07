module 0x705754caff9afdf5762cbd22052c9b339b31803069ccf31d0ad3d4d76a95c7b0::price_source {
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

    public fun set_k_oracle_price<T0>(arg0: &mut 0xf3078e28dff51c6350156d5ae21142df934af4fe0c6e17df797ec702e2eabb89::oracle::PriceReceipt<T0>, arg1: &0xf3078e28dff51c6350156d5ae21142df934af4fe0c6e17df797ec702e2eabb89::oracle::KriyaOracle, arg2: &0x705754caff9afdf5762cbd22052c9b339b31803069ccf31d0ad3d4d76a95c7b0::registry::Registry, arg3: bool, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x705754caff9afdf5762cbd22052c9b339b31803069ccf31d0ad3d4d76a95c7b0::version::Version, arg7: &0xf3078e28dff51c6350156d5ae21142df934af4fe0c6e17df797ec702e2eabb89::version::Version, arg8: &0x2::clock::Clock) {
        0x705754caff9afdf5762cbd22052c9b339b31803069ccf31d0ad3d4d76a95c7b0::version::assert_current_version(arg6);
        0x705754caff9afdf5762cbd22052c9b339b31803069ccf31d0ad3d4d76a95c7b0::registry::assert_pyth_price_info_object<T0>(arg2, arg5);
        let (v0, v1, v2) = 0x705754caff9afdf5762cbd22052c9b339b31803069ccf31d0ad3d4d76a95c7b0::pyth_adapter::get_pyth_price(arg4, arg5, arg8);
        if (arg3) {
            let v3 = KOraclePriceSource{dummy_field: false};
            0xf3078e28dff51c6350156d5ae21142df934af4fe0c6e17df797ec702e2eabb89::oracle::set_primary_price<T0, KOraclePriceSource>(arg7, v3, arg0, arg1, scale_price_to_formatted_decimals(v0, v1), v2);
        } else {
            let v4 = KOraclePriceSource{dummy_field: false};
            0xf3078e28dff51c6350156d5ae21142df934af4fe0c6e17df797ec702e2eabb89::oracle::set_secondary_price<T0, KOraclePriceSource>(arg7, v4, arg0, arg1, scale_price_to_formatted_decimals(v0, v1), v2);
        };
    }

    // decompiled from Move bytecode v6
}

