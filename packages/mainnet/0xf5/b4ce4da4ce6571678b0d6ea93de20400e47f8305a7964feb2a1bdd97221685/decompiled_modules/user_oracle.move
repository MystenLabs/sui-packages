module 0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::user_oracle {
    fun check_price(arg0: &0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::price_feed::PriceFeedComponent, arg1: u64, arg2: &0x2::clock::Clock) : 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal {
        let v0 = 0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::price_feed::value(arg0);
        assert!(v0 > 0, 0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::oracle_error::oracle_zero_price_error());
        assert!(0x2::clock::timestamp_ms(arg2) - 0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::price_feed::update_time(arg0) * 1000 <= arg1, 0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::oracle_error::oracle_stale_price_error());
        0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::from_quotient(v0, 0x1::u64::pow(10, 0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::price_feed::decimals()))
    }

    public fun get_price(arg0: &0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::x_oracle::BaseToken, arg3: &0x2::clock::Clock) : 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal {
        check_price(0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::price_feed::ema(0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::x_oracle::price(arg0, arg1, arg2)), 0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::x_oracle::price_delay_tolerance_ms(arg0), arg3)
    }

    public fun get_price_with_check(arg0: &0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::x_oracle::BaseToken, arg3: &0x2::clock::Clock, arg4: 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal) : 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal {
        let v0 = 0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::x_oracle::price(arg0, arg1, arg2);
        let v1 = check_price(0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::price_feed::ema(v0), 0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::x_oracle::price_delay_tolerance_ms(arg0), arg3);
        let v2 = check_price(0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::price_feed::spot(v0), 0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::x_oracle::price_delay_tolerance_ms(arg0), arg3);
        let v3 = if (0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::gt(v1, v2)) {
            0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::div(0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::sub(v1, v2), v2)
        } else {
            0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::div(0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::sub(v2, v1), v2)
        };
        assert!(0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::le(v3, arg4), 0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::oracle_error::ema_spot_price_too_different());
        v1
    }

    public fun get_spot_price(arg0: &0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::x_oracle::BaseToken, arg3: &0x2::clock::Clock) : 0xe26b5f7e8041c84b3b6040af8526a5e60dd73183dfacbb47e39f7f4148de61d3::float::Decimal {
        check_price(0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::price_feed::spot(0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::x_oracle::price(arg0, arg1, arg2)), 0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::x_oracle::price_delay_tolerance_ms(arg0), arg3)
    }

    public fun refresh_usd_price<T0>(arg0: &mut 0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::x_oracle::XOracle, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) {
        0xf5b4ce4da4ce6571678b0d6ea93de20400e47f8305a7964feb2a1bdd97221685::x_oracle::refresh_usd_price<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

