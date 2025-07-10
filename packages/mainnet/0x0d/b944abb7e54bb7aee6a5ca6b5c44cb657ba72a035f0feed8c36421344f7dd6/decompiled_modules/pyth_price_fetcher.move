module 0x5ebb13d14ca82fba3ac7d16e9b4ac9af43cd9aeb42fad39f9e74dfff19a076a4::pyth_price_fetcher {
    fun err_price_identifier_not_matched() {
        abort 0
    }

    public fun fetch_price(arg0: 0x1::ascii::String, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock, arg3: u8, arg4: u64) : 0x1::option::Option<0x5ebb13d14ca82fba3ac7d16e9b4ac9af43cd9aeb42fad39f9e74dfff19a076a4::current_price::CurrentPrice> {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg1, arg2, arg4);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v1), 1111);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v2), 2222);
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v1)) {
            return 0x1::option::none<0x5ebb13d14ca82fba3ac7d16e9b4ac9af43cd9aeb42fad39f9e74dfff19a076a4::current_price::CurrentPrice>()
        };
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v2)) {
            return 0x1::option::none<0x5ebb13d14ca82fba3ac7d16e9b4ac9af43cd9aeb42fad39f9e74dfff19a076a4::current_price::CurrentPrice>()
        };
        let v3 = (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v1) as u8);
        let v4 = if (v3 > arg3) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v2) / 0x1::u64::pow(10, v3 - arg3)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v2) * 0x1::u64::pow(10, arg3 - v3)
        };
        0x1::option::some<0x5ebb13d14ca82fba3ac7d16e9b4ac9af43cd9aeb42fad39f9e74dfff19a076a4::current_price::CurrentPrice>(0x5ebb13d14ca82fba3ac7d16e9b4ac9af43cd9aeb42fad39f9e74dfff19a076a4::current_price::new_current_price(arg0, v4, arg3, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v0) * 1000))
    }

    // decompiled from Move bytecode v6
}

