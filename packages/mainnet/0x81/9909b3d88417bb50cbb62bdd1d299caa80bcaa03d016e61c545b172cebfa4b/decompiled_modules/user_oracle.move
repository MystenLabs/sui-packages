module 0x819909b3d88417bb50cbb62bdd1d299caa80bcaa03d016e61c545b172cebfa4b::user_oracle {
    fun check_price(arg0: &0x819909b3d88417bb50cbb62bdd1d299caa80bcaa03d016e61c545b172cebfa4b::price_feed::PriceFeedComponent, arg1: u64, arg2: &0x2::clock::Clock) : 0x620f11cbcf6d9dd8b0e77a6a06d413bd15eb0682501e554959b804d0a3626b6e::float::Decimal {
        let v0 = 0x819909b3d88417bb50cbb62bdd1d299caa80bcaa03d016e61c545b172cebfa4b::price_feed::value(arg0);
        assert!(v0 > 0, 0x819909b3d88417bb50cbb62bdd1d299caa80bcaa03d016e61c545b172cebfa4b::oracle_error::oracle_zero_price_error());
        assert!(0x2::clock::timestamp_ms(arg2) - 0x819909b3d88417bb50cbb62bdd1d299caa80bcaa03d016e61c545b172cebfa4b::price_feed::update_time(arg0) * 1000 <= arg1, 0x819909b3d88417bb50cbb62bdd1d299caa80bcaa03d016e61c545b172cebfa4b::oracle_error::oracle_stale_price_error());
        0x620f11cbcf6d9dd8b0e77a6a06d413bd15eb0682501e554959b804d0a3626b6e::float::from_quotient(v0, 0x1::u64::pow(10, 0x819909b3d88417bb50cbb62bdd1d299caa80bcaa03d016e61c545b172cebfa4b::price_feed::decimals()))
    }

    public fun get_price(arg0: &0x819909b3d88417bb50cbb62bdd1d299caa80bcaa03d016e61c545b172cebfa4b::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0x819909b3d88417bb50cbb62bdd1d299caa80bcaa03d016e61c545b172cebfa4b::x_oracle::BaseToken, arg3: &0x2::clock::Clock) : 0x620f11cbcf6d9dd8b0e77a6a06d413bd15eb0682501e554959b804d0a3626b6e::float::Decimal {
        check_price(0x819909b3d88417bb50cbb62bdd1d299caa80bcaa03d016e61c545b172cebfa4b::price_feed::ema(0x819909b3d88417bb50cbb62bdd1d299caa80bcaa03d016e61c545b172cebfa4b::x_oracle::price(arg0, arg1, arg2)), 0x819909b3d88417bb50cbb62bdd1d299caa80bcaa03d016e61c545b172cebfa4b::x_oracle::price_delay_tolerance_ms(arg0), arg3)
    }

    public fun get_price_with_check(arg0: &0x819909b3d88417bb50cbb62bdd1d299caa80bcaa03d016e61c545b172cebfa4b::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0x819909b3d88417bb50cbb62bdd1d299caa80bcaa03d016e61c545b172cebfa4b::x_oracle::BaseToken, arg3: &0x2::clock::Clock, arg4: 0x620f11cbcf6d9dd8b0e77a6a06d413bd15eb0682501e554959b804d0a3626b6e::float::Decimal) : 0x620f11cbcf6d9dd8b0e77a6a06d413bd15eb0682501e554959b804d0a3626b6e::float::Decimal {
        let v0 = 0x819909b3d88417bb50cbb62bdd1d299caa80bcaa03d016e61c545b172cebfa4b::x_oracle::price(arg0, arg1, arg2);
        let v1 = check_price(0x819909b3d88417bb50cbb62bdd1d299caa80bcaa03d016e61c545b172cebfa4b::price_feed::ema(v0), 0x819909b3d88417bb50cbb62bdd1d299caa80bcaa03d016e61c545b172cebfa4b::x_oracle::price_delay_tolerance_ms(arg0), arg3);
        let v2 = check_price(0x819909b3d88417bb50cbb62bdd1d299caa80bcaa03d016e61c545b172cebfa4b::price_feed::spot(v0), 0x819909b3d88417bb50cbb62bdd1d299caa80bcaa03d016e61c545b172cebfa4b::x_oracle::price_delay_tolerance_ms(arg0), arg3);
        let v3 = if (0x620f11cbcf6d9dd8b0e77a6a06d413bd15eb0682501e554959b804d0a3626b6e::float::gt(v1, v2)) {
            0x620f11cbcf6d9dd8b0e77a6a06d413bd15eb0682501e554959b804d0a3626b6e::float::div(0x620f11cbcf6d9dd8b0e77a6a06d413bd15eb0682501e554959b804d0a3626b6e::float::sub(v1, v2), v2)
        } else {
            0x620f11cbcf6d9dd8b0e77a6a06d413bd15eb0682501e554959b804d0a3626b6e::float::div(0x620f11cbcf6d9dd8b0e77a6a06d413bd15eb0682501e554959b804d0a3626b6e::float::sub(v2, v1), v2)
        };
        assert!(0x620f11cbcf6d9dd8b0e77a6a06d413bd15eb0682501e554959b804d0a3626b6e::float::le(v3, arg4), 0x819909b3d88417bb50cbb62bdd1d299caa80bcaa03d016e61c545b172cebfa4b::oracle_error::ema_spot_price_too_different());
        v1
    }

    public fun get_spot_price(arg0: &0x819909b3d88417bb50cbb62bdd1d299caa80bcaa03d016e61c545b172cebfa4b::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0x819909b3d88417bb50cbb62bdd1d299caa80bcaa03d016e61c545b172cebfa4b::x_oracle::BaseToken, arg3: &0x2::clock::Clock) : 0x620f11cbcf6d9dd8b0e77a6a06d413bd15eb0682501e554959b804d0a3626b6e::float::Decimal {
        check_price(0x819909b3d88417bb50cbb62bdd1d299caa80bcaa03d016e61c545b172cebfa4b::price_feed::spot(0x819909b3d88417bb50cbb62bdd1d299caa80bcaa03d016e61c545b172cebfa4b::x_oracle::price(arg0, arg1, arg2)), 0x819909b3d88417bb50cbb62bdd1d299caa80bcaa03d016e61c545b172cebfa4b::x_oracle::price_delay_tolerance_ms(arg0), arg3)
    }

    public fun refresh_usd_price<T0>(arg0: &mut 0x819909b3d88417bb50cbb62bdd1d299caa80bcaa03d016e61c545b172cebfa4b::x_oracle::XOracle, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) {
        0x819909b3d88417bb50cbb62bdd1d299caa80bcaa03d016e61c545b172cebfa4b::x_oracle::refresh_usd_price<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

