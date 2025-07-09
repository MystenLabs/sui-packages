module 0xcecb154e60687545f6b00b0402c77bd97d9260c6eab1e78b097511a70fb505eb::pyth_price_fetcher {
    fun err_price_identifier_not_matched() {
        abort 0
    }

    public fun fetch_price(arg0: 0x1::ascii::String, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock, arg3: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, arg4: u8, arg5: u64) : 0x1::option::Option<0xcecb154e60687545f6b00b0402c77bd97d9260c6eab1e78b097511a70fb505eb::current_price::CurrentPrice> {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg1, arg2, arg5);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg1);
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v1) != arg3) {
            err_price_identifier_not_matched();
        };
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v2)) {
            return 0x1::option::none<0xcecb154e60687545f6b00b0402c77bd97d9260c6eab1e78b097511a70fb505eb::current_price::CurrentPrice>()
        };
        if (!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v3)) {
            return 0x1::option::none<0xcecb154e60687545f6b00b0402c77bd97d9260c6eab1e78b097511a70fb505eb::current_price::CurrentPrice>()
        };
        let v4 = (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v2) as u8);
        let v5 = if (v4 > arg4) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v3) / 0x1::u64::pow(10, v4 - arg4)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v3) * 0x1::u64::pow(10, arg4 - v4)
        };
        0x1::option::some<0xcecb154e60687545f6b00b0402c77bd97d9260c6eab1e78b097511a70fb505eb::current_price::CurrentPrice>(0xcecb154e60687545f6b00b0402c77bd97d9260c6eab1e78b097511a70fb505eb::current_price::new_current_price(arg0, v5, arg4, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v0) * 1000))
    }

    // decompiled from Move bytecode v6
}

