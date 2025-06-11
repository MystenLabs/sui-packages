module 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::oracle {
    public(friend) fun get_pyth_price_and_price_id(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &0x2::clock::Clock) : (0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::Decimal, vector<u8>) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v0);
        (parse_price_to_decimal(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg0, arg1, 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::constant::max_age())), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v1))
    }

    fun parse_price_to_decimal(arg0: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price) : 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::Decimal {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&arg0);
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v1)) {
            0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::div(0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::from(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v0)), 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::from(0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v1) as u8))))
        } else {
            0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::mul(0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::from(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v0)), 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::from(0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1) as u8))))
        }
    }

    // decompiled from Move bytecode v6
}

