module 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::oracles {
    public fun get_pyth_price_and_identifier(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &0x2::clock::Clock) : (0x1::option::Option<0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::Decimal>, 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::Decimal, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_feed(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price(v1);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v2);
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v2) * 10 > 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v3)) {
            return (0x1::option::none<0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::Decimal>(), parse_price_to_decimal(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_ema_price(v1)), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price_identifier(v1))
        };
        let v4 = 0x2::clock::timestamp_ms(arg1) / 1000;
        if (v4 > 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v2) && v4 - 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v2) > 60) {
            return (0x1::option::none<0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::Decimal>(), parse_price_to_decimal(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_ema_price(v1)), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price_identifier(v1))
        };
        (0x1::option::some<0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::Decimal>(parse_price_to_decimal(v2)), parse_price_to_decimal(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_ema_price(v1)), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price_identifier(v1))
    }

    fun parse_price_to_decimal(arg0: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price) : 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::Decimal {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&arg0);
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v1)) {
            0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::div(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v0)), 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from(0x2::math::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v1) as u8))))
        } else {
            0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::mul(0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v0)), 0x49892fa5ccc0c91e4675d7abfab9d3bad3cb0655c0b90c082c0125326263dc01::decimal::from(0x2::math::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1) as u8))))
        }
    }

    // decompiled from Move bytecode v6
}

