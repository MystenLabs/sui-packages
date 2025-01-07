module 0x726b2646dfc09d20ae1240bbd99592d15c04113789f98a340b68f929395ae0bf::price_source {
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

    public fun set_k_oracle_price<T0>(arg0: &mut 0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::oracle::PriceReceipt<T0>, arg1: &0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::oracle::KriyaOracle, arg2: &0x726b2646dfc09d20ae1240bbd99592d15c04113789f98a340b68f929395ae0bf::registry::Registry, arg3: bool, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x726b2646dfc09d20ae1240bbd99592d15c04113789f98a340b68f929395ae0bf::version::Version, arg7: &0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::version::Version, arg8: &0x2::clock::Clock) {
        0x726b2646dfc09d20ae1240bbd99592d15c04113789f98a340b68f929395ae0bf::version::assert_current_version(arg6);
        0x726b2646dfc09d20ae1240bbd99592d15c04113789f98a340b68f929395ae0bf::registry::assert_pyth_price_info_object<T0>(arg2, arg5);
        let (v0, v1, v2) = 0x726b2646dfc09d20ae1240bbd99592d15c04113789f98a340b68f929395ae0bf::pyth_adapter::get_pyth_price(arg4, arg5, arg8);
        if (arg3) {
            let v3 = KOraclePriceSource{dummy_field: false};
            0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::oracle::set_primary_price<T0, KOraclePriceSource>(arg7, v3, arg0, arg1, scale_price_to_formatted_decimals(v0, v1), v2);
        } else {
            let v4 = KOraclePriceSource{dummy_field: false};
            0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::oracle::set_secondary_price<T0, KOraclePriceSource>(arg7, v4, arg0, arg1, scale_price_to_formatted_decimals(v0, v1), v2);
        };
    }

    // decompiled from Move bytecode v6
}

