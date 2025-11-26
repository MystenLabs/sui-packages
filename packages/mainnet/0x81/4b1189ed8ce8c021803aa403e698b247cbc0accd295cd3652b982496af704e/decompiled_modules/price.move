module 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::price {
    public fun get_price(arg0: &0x901a0eda69c69f5ed9ccd6e94b01e2a4d3e36c88f0b5c0da90978a2a92979007::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x901a0eda69c69f5ed9ccd6e94b01e2a4d3e36c88f0b5c0da90978a2a92979007::x_oracle::prices(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x901a0eda69c69f5ed9ccd6e94b01e2a4d3e36c88f0b5c0da90978a2a92979007::price_feed::PriceFeed>(v0, arg1), 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::error::oracle_price_not_found_error());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0x901a0eda69c69f5ed9ccd6e94b01e2a4d3e36c88f0b5c0da90978a2a92979007::price_feed::PriceFeed>(v0, arg1);
        let v2 = 0x901a0eda69c69f5ed9ccd6e94b01e2a4d3e36c88f0b5c0da90978a2a92979007::price_feed::value(v1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == 0x901a0eda69c69f5ed9ccd6e94b01e2a4d3e36c88f0b5c0da90978a2a92979007::price_feed::last_updated(v1), 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::error::oracle_stale_price_error());
        assert!(v2 > 0, 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::error::oracle_zero_price_error());
        0x1::fixed_point32::create_from_rational(v2, 0x2::math::pow(10, 0x901a0eda69c69f5ed9ccd6e94b01e2a4d3e36c88f0b5c0da90978a2a92979007::price_feed::decimals()))
    }

    // decompiled from Move bytecode v6
}

