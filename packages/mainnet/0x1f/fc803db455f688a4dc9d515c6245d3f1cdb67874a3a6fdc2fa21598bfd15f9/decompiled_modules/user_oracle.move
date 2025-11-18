module 0x1ffc803db455f688a4dc9d515c6245d3f1cdb67874a3a6fdc2fa21598bfd15f9::user_oracle {
    fun check_price(arg0: &0x1ffc803db455f688a4dc9d515c6245d3f1cdb67874a3a6fdc2fa21598bfd15f9::price_feed::PriceFeedComponent, arg1: u64, arg2: &0x2::clock::Clock) : 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal {
        let v0 = 0x1ffc803db455f688a4dc9d515c6245d3f1cdb67874a3a6fdc2fa21598bfd15f9::price_feed::value(arg0);
        assert!(v0 > 0, 0x1ffc803db455f688a4dc9d515c6245d3f1cdb67874a3a6fdc2fa21598bfd15f9::oracle_error::oracle_zero_price_error());
        assert!(0x2::clock::timestamp_ms(arg2) - 0x1ffc803db455f688a4dc9d515c6245d3f1cdb67874a3a6fdc2fa21598bfd15f9::price_feed::update_time(arg0) * 1000 <= arg1, 0x1ffc803db455f688a4dc9d515c6245d3f1cdb67874a3a6fdc2fa21598bfd15f9::oracle_error::oracle_stale_price_error());
        0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::from_quotient(v0, 0x1::u64::pow(10, 0x1ffc803db455f688a4dc9d515c6245d3f1cdb67874a3a6fdc2fa21598bfd15f9::price_feed::decimals()))
    }

    public fun get_price(arg0: &0x1ffc803db455f688a4dc9d515c6245d3f1cdb67874a3a6fdc2fa21598bfd15f9::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0x1ffc803db455f688a4dc9d515c6245d3f1cdb67874a3a6fdc2fa21598bfd15f9::x_oracle::BaseToken, arg3: &0x2::clock::Clock) : 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal {
        check_price(0x1ffc803db455f688a4dc9d515c6245d3f1cdb67874a3a6fdc2fa21598bfd15f9::price_feed::ema(0x1ffc803db455f688a4dc9d515c6245d3f1cdb67874a3a6fdc2fa21598bfd15f9::x_oracle::price(arg0, arg1, arg2)), 0x1ffc803db455f688a4dc9d515c6245d3f1cdb67874a3a6fdc2fa21598bfd15f9::x_oracle::price_delay_tolerance_ms(arg0), arg3)
    }

    public fun get_price_with_check(arg0: &0x1ffc803db455f688a4dc9d515c6245d3f1cdb67874a3a6fdc2fa21598bfd15f9::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0x1ffc803db455f688a4dc9d515c6245d3f1cdb67874a3a6fdc2fa21598bfd15f9::x_oracle::BaseToken, arg3: &0x2::clock::Clock, arg4: 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal) : 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal {
        let v0 = 0x1ffc803db455f688a4dc9d515c6245d3f1cdb67874a3a6fdc2fa21598bfd15f9::x_oracle::price(arg0, arg1, arg2);
        let v1 = check_price(0x1ffc803db455f688a4dc9d515c6245d3f1cdb67874a3a6fdc2fa21598bfd15f9::price_feed::ema(v0), 0x1ffc803db455f688a4dc9d515c6245d3f1cdb67874a3a6fdc2fa21598bfd15f9::x_oracle::price_delay_tolerance_ms(arg0), arg3);
        let v2 = check_price(0x1ffc803db455f688a4dc9d515c6245d3f1cdb67874a3a6fdc2fa21598bfd15f9::price_feed::spot(v0), 0x1ffc803db455f688a4dc9d515c6245d3f1cdb67874a3a6fdc2fa21598bfd15f9::x_oracle::price_delay_tolerance_ms(arg0), arg3);
        let v3 = if (0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::gt(v1, v2)) {
            0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::div(0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::sub(v1, v2), v2)
        } else {
            0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::div(0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::sub(v2, v1), v2)
        };
        assert!(0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::lt(v3, arg4), 0x1ffc803db455f688a4dc9d515c6245d3f1cdb67874a3a6fdc2fa21598bfd15f9::oracle_error::ema_spot_price_too_different());
        v1
    }

    public fun get_spot_price(arg0: &0x1ffc803db455f688a4dc9d515c6245d3f1cdb67874a3a6fdc2fa21598bfd15f9::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0x1ffc803db455f688a4dc9d515c6245d3f1cdb67874a3a6fdc2fa21598bfd15f9::x_oracle::BaseToken, arg3: &0x2::clock::Clock) : 0x44868dc6a319dd47330602de8c8afdfdeb4ca57af33f1961127ce17f5c5fdd77::float::Decimal {
        check_price(0x1ffc803db455f688a4dc9d515c6245d3f1cdb67874a3a6fdc2fa21598bfd15f9::price_feed::spot(0x1ffc803db455f688a4dc9d515c6245d3f1cdb67874a3a6fdc2fa21598bfd15f9::x_oracle::price(arg0, arg1, arg2)), 0x1ffc803db455f688a4dc9d515c6245d3f1cdb67874a3a6fdc2fa21598bfd15f9::x_oracle::price_delay_tolerance_ms(arg0), arg3)
    }

    public fun refresh_usd_price<T0>(arg0: &mut 0x1ffc803db455f688a4dc9d515c6245d3f1cdb67874a3a6fdc2fa21598bfd15f9::x_oracle::XOracle, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) {
        0x1ffc803db455f688a4dc9d515c6245d3f1cdb67874a3a6fdc2fa21598bfd15f9::x_oracle::refresh_usd_price<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

