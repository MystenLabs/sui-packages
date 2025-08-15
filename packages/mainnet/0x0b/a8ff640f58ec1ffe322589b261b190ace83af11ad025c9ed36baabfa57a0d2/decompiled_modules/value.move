module 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::value {
    public fun get_price(arg0: &0x8df1d001c6cb220f28cf2ba330ed7ea9febaac2d797329e2196133eb02bec894::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal {
        let v0 = 0x8df1d001c6cb220f28cf2ba330ed7ea9febaac2d797329e2196133eb02bec894::x_oracle::prices(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x8df1d001c6cb220f28cf2ba330ed7ea9febaac2d797329e2196133eb02bec894::price_feed::PriceFeed>(v0, arg1), 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::error::oracle_price_not_found_error());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0x8df1d001c6cb220f28cf2ba330ed7ea9febaac2d797329e2196133eb02bec894::price_feed::PriceFeed>(v0, arg1);
        let v2 = 0x8df1d001c6cb220f28cf2ba330ed7ea9febaac2d797329e2196133eb02bec894::price_feed::value(v1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == 0x8df1d001c6cb220f28cf2ba330ed7ea9febaac2d797329e2196133eb02bec894::price_feed::last_updated(v1), 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::error::oracle_stale_price_error());
        assert!(v2 > 0, 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::error::oracle_zero_price_error());
        0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::from_quotient(v2, 0x1::u64::pow(10, 0x8df1d001c6cb220f28cf2ba330ed7ea9febaac2d797329e2196133eb02bec894::price_feed::decimals()))
    }

    public fun usd_value(arg0: 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal, arg1: 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal, arg2: u8) : 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal {
        0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::div(0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::mul(arg0, arg1), 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::from(0x1::u64::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

