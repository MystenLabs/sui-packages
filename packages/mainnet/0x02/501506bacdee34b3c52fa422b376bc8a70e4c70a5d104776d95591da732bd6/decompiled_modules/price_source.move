module 0x2501506bacdee34b3c52fa422b376bc8a70e4c70a5d104776d95591da732bd6::price_source {
    struct KOraclePriceSource has drop {
        dummy_field: bool,
    }

    fun scale_price_to_formatted_decimals(arg0: u64, arg1: u8) : u64 {
        if (arg1 < 9) {
            arg0 * 0x1::u64::pow(10, 9 - arg1)
        } else {
            arg0 / 0x1::u64::pow(10, arg1 - 9)
        }
    }

    public fun set_k_oracle_price<T0>(arg0: &mut 0x7903ed759a2e2749ecdb64a8f100b0a547185f2ef7ea286048aa1f174c8a8b9a::oracle::PriceReceipt<T0>, arg1: &0x7903ed759a2e2749ecdb64a8f100b0a547185f2ef7ea286048aa1f174c8a8b9a::oracle::KriyaOracle, arg2: &0x2501506bacdee34b3c52fa422b376bc8a70e4c70a5d104776d95591da732bd6::registry::Registry, arg3: bool, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x2::clock::Clock) {
        0x2501506bacdee34b3c52fa422b376bc8a70e4c70a5d104776d95591da732bd6::version::assert_current_version(0x2501506bacdee34b3c52fa422b376bc8a70e4c70a5d104776d95591da732bd6::registry::version(arg2));
        0x2501506bacdee34b3c52fa422b376bc8a70e4c70a5d104776d95591da732bd6::registry::assert_pyth_price_info_object<T0>(arg2, arg5);
        let (_, v1) = 0x2501506bacdee34b3c52fa422b376bc8a70e4c70a5d104776d95591da732bd6::registry::get_config<T0>(arg2);
        let (v2, v3, v4) = 0x2501506bacdee34b3c52fa422b376bc8a70e4c70a5d104776d95591da732bd6::pyth_adapter::get_pyth_price(arg4, arg5, v1, arg6);
        if (arg3) {
            let v5 = KOraclePriceSource{dummy_field: false};
            0x7903ed759a2e2749ecdb64a8f100b0a547185f2ef7ea286048aa1f174c8a8b9a::oracle::set_primary_price<T0, KOraclePriceSource>(v5, arg0, arg1, scale_price_to_formatted_decimals(v2, v3), v4);
        } else {
            let v6 = KOraclePriceSource{dummy_field: false};
            0x7903ed759a2e2749ecdb64a8f100b0a547185f2ef7ea286048aa1f174c8a8b9a::oracle::set_secondary_price<T0, KOraclePriceSource>(v6, arg0, arg1, scale_price_to_formatted_decimals(v2, v3), v4);
        };
    }

    // decompiled from Move bytecode v6
}

