module 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::price_feed {
    public fun get_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: u64, arg2: &0x2::clock::Clock) : (u64, u64, bool) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg0, arg2, arg1);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        (i64_to_u64(&v1), i64_to_u64(&v2), is_negative(&v3))
    }

    public fun get_value_by_usd<T0>(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: u64, arg2: u64, arg3: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::Asset<T0>, arg4: &0x2::clock::Clock) : u128 {
        let (v0, v1, v2) = get_price(arg0, 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::max_price_age_seconds<T0>(arg3), arg4);
        if (v2) {
            (v0 as u128) * (arg2 as u128) * (0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::power(10, arg1) as u128) / (0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::power(10, (0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::decimals<T0>(arg3) as u64)) as u128) / (0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::power(10, v1) as u128)
        } else {
            (v0 as u128) * (arg2 as u128) * (0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::power(10, arg1) as u128) / (0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::power(10, (0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::decimals<T0>(arg3) as u64)) as u128) * (0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::power(10, v1) as u128)
        }
    }

    public fun i64_to_u64(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64) : u64 {
        if (!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(arg0)) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(arg0)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(arg0)
        }
    }

    public fun is_negative(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64) : bool {
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(arg0)
    }

    public fun is_valid_price_info_object<T0>(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::Asset<T0>) : bool {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v0);
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::vector_to_hex_char(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v1)) == 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::price_feed_id<T0>(arg1)
    }

    // decompiled from Move bytecode v6
}

