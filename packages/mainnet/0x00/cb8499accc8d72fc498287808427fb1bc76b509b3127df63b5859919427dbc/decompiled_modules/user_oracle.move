module 0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::user_oracle {
    fun check_price(arg0: &0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::price_feed::PriceFeedComponent, arg1: u64, arg2: &0x2::clock::Clock) : 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::Decimal {
        let v0 = 0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::price_feed::value(arg0);
        assert!(v0 > 0, 0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::oracle_error::oracle_zero_price_error());
        assert!(0x2::clock::timestamp_ms(arg2) - 0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::price_feed::update_time(arg0) * 1000 <= arg1, 0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::oracle_error::oracle_stale_price_error());
        0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::from_quotient(v0, 0x1::u64::pow(10, 0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::price_feed::decimals()))
    }

    public fun get_price(arg0: &0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::x_oracle::BaseToken, arg3: &0x2::clock::Clock) : 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::Decimal {
        0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::x_oracle::ensure_version_matches(arg0);
        check_price(0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::price_feed::ema(0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::x_oracle::price(arg0, arg1, arg2)), 0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::x_oracle::price_delay_tolerance_ms(arg0), arg3)
    }

    public fun get_price_with_check(arg0: &0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::x_oracle::BaseToken, arg3: &0x2::clock::Clock, arg4: 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::Decimal) : 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::Decimal {
        0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::x_oracle::ensure_version_matches(arg0);
        let v0 = 0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::x_oracle::price(arg0, arg1, arg2);
        let v1 = check_price(0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::price_feed::ema(v0), 0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::x_oracle::price_delay_tolerance_ms(arg0), arg3);
        let v2 = check_price(0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::price_feed::spot(v0), 0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::x_oracle::price_delay_tolerance_ms(arg0), arg3);
        let v3 = if (0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::gt(v1, v2)) {
            0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::div(0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::sub(v1, v2), v2)
        } else {
            0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::div(0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::sub(v2, v1), v2)
        };
        assert!(0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::le(v3, arg4), 0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::oracle_error::ema_spot_price_too_different());
        v1
    }

    public fun get_spot_price(arg0: &0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::x_oracle::BaseToken, arg3: &0x2::clock::Clock) : 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::Decimal {
        0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::x_oracle::ensure_version_matches(arg0);
        check_price(0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::price_feed::spot(0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::x_oracle::price(arg0, arg1, arg2)), 0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::x_oracle::price_delay_tolerance_ms(arg0), arg3)
    }

    public fun get_spot_price_with_check(arg0: &0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::x_oracle::BaseToken, arg3: &0x2::clock::Clock, arg4: 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::Decimal) : 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::Decimal {
        0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::x_oracle::ensure_version_matches(arg0);
        let v0 = 0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::x_oracle::price(arg0, arg1, arg2);
        let v1 = check_price(0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::price_feed::ema(v0), 0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::x_oracle::price_delay_tolerance_ms(arg0), arg3);
        let v2 = check_price(0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::price_feed::spot(v0), 0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::x_oracle::price_delay_tolerance_ms(arg0), arg3);
        let v3 = if (0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::gt(v1, v2)) {
            0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::div(0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::sub(v1, v2), v1)
        } else {
            0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::div(0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::sub(v2, v1), v1)
        };
        assert!(0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::le(v3, arg4), 0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::oracle_error::ema_spot_price_too_different());
        v2
    }

    public fun refresh_usd_price<T0>(arg0: &mut 0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::x_oracle::XOracle, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) {
        0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::x_oracle::ensure_version_matches(arg0);
        0xcb8499accc8d72fc498287808427fb1bc76b509b3127df63b5859919427dbc::x_oracle::refresh_usd_price<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

