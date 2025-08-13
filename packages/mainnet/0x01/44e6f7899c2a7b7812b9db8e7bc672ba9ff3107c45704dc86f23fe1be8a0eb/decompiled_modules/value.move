module 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::value {
    public fun get_price(arg0: &0xcc35b686b76e638962aa1199ffc50f164f13456b56d95a477d82b4cecd65faf6::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal {
        let v0 = 0xcc35b686b76e638962aa1199ffc50f164f13456b56d95a477d82b4cecd65faf6::x_oracle::prices(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0xcc35b686b76e638962aa1199ffc50f164f13456b56d95a477d82b4cecd65faf6::price_feed::PriceFeed>(v0, arg1), 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::error::oracle_price_not_found_error());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0xcc35b686b76e638962aa1199ffc50f164f13456b56d95a477d82b4cecd65faf6::price_feed::PriceFeed>(v0, arg1);
        let v2 = 0xcc35b686b76e638962aa1199ffc50f164f13456b56d95a477d82b4cecd65faf6::price_feed::value(v1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == 0xcc35b686b76e638962aa1199ffc50f164f13456b56d95a477d82b4cecd65faf6::price_feed::last_updated(v1), 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::error::oracle_stale_price_error());
        assert!(v2 > 0, 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::error::oracle_zero_price_error());
        0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::from_quotient(v2, 0x1::u64::pow(10, 0xcc35b686b76e638962aa1199ffc50f164f13456b56d95a477d82b4cecd65faf6::price_feed::decimals()))
    }

    public fun usd_value(arg0: 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal, arg1: 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal, arg2: u8) : 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal {
        0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::div(0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::mul(arg0, arg1), 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::from(0x1::u64::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

