module 0xb37650a5c5da54fed9b782724e0db31d0099ec404883451c0c393206a8ef83cf::pyth_price_fetcher {
    fun err_price_identifier_not_matched() {
        abort 0
    }

    public fun fetch_price<T0>(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &0x2::clock::Clock, arg2: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, arg3: u8, arg4: u64) : 0x1::option::Option<0xb37650a5c5da54fed9b782724e0db31d0099ec404883451c0c393206a8ef83cf::current_price::CurrentPrice<T0>> {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg0, arg1, arg4);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v1) != arg2) {
            err_price_identifier_not_matched();
        };
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v2)) {
            return 0x1::option::none<0xb37650a5c5da54fed9b782724e0db31d0099ec404883451c0c393206a8ef83cf::current_price::CurrentPrice<T0>>()
        };
        if (!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v3)) {
            return 0x1::option::none<0xb37650a5c5da54fed9b782724e0db31d0099ec404883451c0c393206a8ef83cf::current_price::CurrentPrice<T0>>()
        };
        let v4 = (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v2) as u8);
        let v5 = if (v4 > arg3) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v3) / 0x1::u64::pow(10, v4 - arg3)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v3) * 0x1::u64::pow(10, arg3 - v4)
        };
        0x1::option::some<0xb37650a5c5da54fed9b782724e0db31d0099ec404883451c0c393206a8ef83cf::current_price::CurrentPrice<T0>>(0xb37650a5c5da54fed9b782724e0db31d0099ec404883451c0c393206a8ef83cf::current_price::new_current_price<T0>(v5, arg3, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v0) * 1000))
    }

    // decompiled from Move bytecode v6
}

