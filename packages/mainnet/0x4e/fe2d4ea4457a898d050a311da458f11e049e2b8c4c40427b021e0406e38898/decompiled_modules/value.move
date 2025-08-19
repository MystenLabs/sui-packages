module 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::value {
    public fun get_price(arg0: &0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal {
        let v0 = 0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::x_oracle::prices(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::price_feed::PriceFeed>(v0, arg1), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::error::oracle_price_not_found_error());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::price_feed::PriceFeed>(v0, arg1);
        let v2 = 0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::price_feed::value(v1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == 0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::price_feed::last_updated(v1), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::error::oracle_stale_price_error());
        assert!(v2 > 0, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::error::oracle_zero_price_error());
        0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::from_quotient(v2, 0x1::u64::pow(10, 0x988609a6772a8ce45037fa78bdc1eda593c5872c16dd883002c8aa4939a2a7bb::price_feed::decimals()))
    }

    public fun usd_value(arg0: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal, arg1: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal, arg2: u8) : 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal {
        0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::div(0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::mul(arg0, arg1), 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::from(0x1::u64::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

