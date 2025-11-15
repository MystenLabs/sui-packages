module 0xb6922c5a41a144916e91c4591af2dca6666f74c53366701e397a4155537e6e5a::price_query {
    public fun get_price_u64<T0>(arg0: &0xa3104a763777016472649d6ef6dc9111f6b7c3ee34acf6bd52896833ab48017f::x_oracle::XOracle, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0xa3104a763777016472649d6ef6dc9111f6b7c3ee34acf6bd52896833ab48017f::x_oracle::prices(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0xa3104a763777016472649d6ef6dc9111f6b7c3ee34acf6bd52896833ab48017f::price_feed::PriceFeed>(v0, v1), 0);
        let v2 = 0x2::table::borrow<0x1::type_name::TypeName, 0xa3104a763777016472649d6ef6dc9111f6b7c3ee34acf6bd52896833ab48017f::price_feed::PriceFeed>(v0, v1);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 == 0xa3104a763777016472649d6ef6dc9111f6b7c3ee34acf6bd52896833ab48017f::price_feed::last_updated(v2), 1);
        0xa3104a763777016472649d6ef6dc9111f6b7c3ee34acf6bd52896833ab48017f::price_feed::value(v2)
    }

    public fun get_price_u64_unchecked<T0>(arg0: &0xa3104a763777016472649d6ef6dc9111f6b7c3ee34acf6bd52896833ab48017f::x_oracle::XOracle) : (u64, u64) {
        let v0 = 0xa3104a763777016472649d6ef6dc9111f6b7c3ee34acf6bd52896833ab48017f::x_oracle::prices(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0xa3104a763777016472649d6ef6dc9111f6b7c3ee34acf6bd52896833ab48017f::price_feed::PriceFeed>(v0, v1), 0);
        let v2 = 0x2::table::borrow<0x1::type_name::TypeName, 0xa3104a763777016472649d6ef6dc9111f6b7c3ee34acf6bd52896833ab48017f::price_feed::PriceFeed>(v0, v1);
        (0xa3104a763777016472649d6ef6dc9111f6b7c3ee34acf6bd52896833ab48017f::price_feed::value(v2), 0xa3104a763777016472649d6ef6dc9111f6b7c3ee34acf6bd52896833ab48017f::price_feed::last_updated(v2))
    }

    // decompiled from Move bytecode v6
}

