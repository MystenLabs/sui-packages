module 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::user_oracle {
    fun check_price(arg0: &0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::price_feed::PriceFeedComponent) : 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal {
        let v0 = 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::price_feed::value(arg0);
        assert!(v0 > 0, 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::oracle_error::oracle_zero_price_error());
        0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::from_quotient(v0, 0x1::u64::pow(10, 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::price_feed::decimals()))
    }

    public fun get_price(arg0: &0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::BaseToken, arg3: &0x2::clock::Clock) : 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal {
        0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::ensure_version_matches(arg0);
        assert!(arg2 == 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::usd(), 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::oracle_error::base_token_not_supported());
        let v0 = 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::get_usd_price(arg0, arg1, arg3);
        check_price(0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::price_feed::ema(&v0))
    }

    public fun get_price_with_check(arg0: &0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::BaseToken, arg3: &0x2::clock::Clock, arg4: 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal) : 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal {
        0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::ensure_version_matches(arg0);
        assert!(arg2 == 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::usd(), 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::oracle_error::base_token_not_supported());
        let v0 = 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::get_usd_price(arg0, arg1, arg3);
        let v1 = check_price(0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::price_feed::ema(&v0));
        let v2 = check_price(0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::price_feed::spot(&v0));
        let v3 = if (0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::gt(v1, v2)) {
            0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::div(0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::sub(v1, v2), v2)
        } else {
            0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::div(0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::sub(v2, v1), v2)
        };
        assert!(0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::le(v3, arg4), 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::oracle_error::ema_spot_price_too_different());
        v1
    }

    public fun get_spot_price(arg0: &0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::BaseToken, arg3: &0x2::clock::Clock) : 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal {
        0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::ensure_version_matches(arg0);
        assert!(arg2 == 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::usd(), 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::oracle_error::base_token_not_supported());
        let v0 = 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::get_usd_price(arg0, arg1, arg3);
        check_price(0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::price_feed::spot(&v0))
    }

    public fun get_spot_price_with_check(arg0: &0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::BaseToken, arg3: &0x2::clock::Clock, arg4: 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal) : 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal {
        0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::ensure_version_matches(arg0);
        assert!(arg2 == 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::usd(), 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::oracle_error::base_token_not_supported());
        let v0 = 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::get_usd_price(arg0, arg1, arg3);
        let v1 = check_price(0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::price_feed::ema(&v0));
        let v2 = check_price(0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::price_feed::spot(&v0));
        let v3 = if (0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::gt(v1, v2)) {
            0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::div(0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::sub(v1, v2), v1)
        } else {
            0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::div(0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::sub(v2, v1), v1)
        };
        assert!(0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::le(v3, arg4), 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::oracle_error::ema_spot_price_too_different());
        v2
    }

    public fun refresh_usd_price<T0>(arg0: &mut 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) {
        abort 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::oracle_error::deprecated()
    }

    // decompiled from Move bytecode v7
}

