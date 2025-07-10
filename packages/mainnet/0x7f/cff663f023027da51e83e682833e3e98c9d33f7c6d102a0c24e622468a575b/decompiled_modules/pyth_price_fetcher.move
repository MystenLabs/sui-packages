module 0x7fcff663f023027da51e83e682833e3e98c9d33f7c6d102a0c24e622468a575b::pyth_price_fetcher {
    fun err_price_identifier_not_matched() {
        abort 0
    }

    public fun fetch_price(arg0: 0x1::ascii::String, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: 0x1::ascii::String, arg3: &0x2::clock::Clock, arg4: u8, arg5: u64) : 0x1::option::Option<0x7fcff663f023027da51e83e682833e3e98c9d33f7c6d102a0c24e622468a575b::current_price::CurrentPrice> {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg1, arg3, arg5);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg1);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v1);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2);
        if (&v3 != 0x1::ascii::as_bytes(&arg2)) {
            err_price_identifier_not_matched();
        };
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v4)) {
            return 0x1::option::none<0x7fcff663f023027da51e83e682833e3e98c9d33f7c6d102a0c24e622468a575b::current_price::CurrentPrice>()
        };
        if (!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v5)) {
            return 0x1::option::none<0x7fcff663f023027da51e83e682833e3e98c9d33f7c6d102a0c24e622468a575b::current_price::CurrentPrice>()
        };
        let v6 = (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v4) as u8);
        let v7 = if (v6 > arg4) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v5) / 0x1::u64::pow(10, v6 - arg4)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v5) * 0x1::u64::pow(10, arg4 - v6)
        };
        0x1::option::some<0x7fcff663f023027da51e83e682833e3e98c9d33f7c6d102a0c24e622468a575b::current_price::CurrentPrice>(0x7fcff663f023027da51e83e682833e3e98c9d33f7c6d102a0c24e622468a575b::current_price::new_current_price(arg0, v7, arg4, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v0) * 1000))
    }

    // decompiled from Move bytecode v6
}

