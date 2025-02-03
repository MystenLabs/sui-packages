module 0x9e30efa44fc125b7b704dab2ca3536a7d83228f00b0d1415569eed60455b9c06::price {
    public fun get_price(arg0: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::prices(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::price_feed::PriceFeed>(v0, arg1), 0x9e30efa44fc125b7b704dab2ca3536a7d83228f00b0d1415569eed60455b9c06::error::oracle_price_not_found_error());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::price_feed::PriceFeed>(v0, arg1);
        let v2 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::price_feed::value(v1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::price_feed::last_updated(v1), 0x9e30efa44fc125b7b704dab2ca3536a7d83228f00b0d1415569eed60455b9c06::error::oracle_stale_price_error());
        assert!(v2 > 0, 0x9e30efa44fc125b7b704dab2ca3536a7d83228f00b0d1415569eed60455b9c06::error::oracle_zero_price_error());
        0x1::fixed_point32::create_from_rational(v2, 0x2::math::pow(10, 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::price_feed::decimals()))
    }

    // decompiled from Move bytecode v6
}

