module 0xedc40d3bdd1f19cfab757cff37d645eae4b8c52b0e38bc4e45c7c84310db098c::price_query {
    public fun get_price_u64<T0>(arg0: &0xa672673d45ce659ff4e5fbca19d2e757a4822d95bbb064e5c98c05e04880b70f::x_oracle::XOracle, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0xa672673d45ce659ff4e5fbca19d2e757a4822d95bbb064e5c98c05e04880b70f::x_oracle::prices(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0xa672673d45ce659ff4e5fbca19d2e757a4822d95bbb064e5c98c05e04880b70f::price_feed::PriceFeed>(v0, v1), 0);
        let v2 = 0x2::table::borrow<0x1::type_name::TypeName, 0xa672673d45ce659ff4e5fbca19d2e757a4822d95bbb064e5c98c05e04880b70f::price_feed::PriceFeed>(v0, v1);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 == 0xa672673d45ce659ff4e5fbca19d2e757a4822d95bbb064e5c98c05e04880b70f::price_feed::last_updated(v2), 1);
        0xa672673d45ce659ff4e5fbca19d2e757a4822d95bbb064e5c98c05e04880b70f::price_feed::value(v2)
    }

    // decompiled from Move bytecode v6
}

