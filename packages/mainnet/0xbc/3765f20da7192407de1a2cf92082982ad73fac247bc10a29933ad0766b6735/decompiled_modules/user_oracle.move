module 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::user_oracle {
    fun check_price(arg0: &0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::price_feed::PriceFeedComponent, arg1: u64, arg2: &0x2::clock::Clock) : 0xf1f85598c7f7af12ccaff5ad1dafa065867c37f8dba7eadd190e42bf1123bf2f::float::Decimal {
        let v0 = 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::price_feed::value(arg0);
        assert!(v0 > 0, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::oracle_error::oracle_zero_price_error());
        assert!(0x2::clock::timestamp_ms(arg2) - 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::price_feed::update_time(arg0) * 1000 <= arg1, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::oracle_error::oracle_stale_price_error());
        0xf1f85598c7f7af12ccaff5ad1dafa065867c37f8dba7eadd190e42bf1123bf2f::float::from_quotient(v0, 0x1::u64::pow(10, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::price_feed::decimals()))
    }

    public fun get_price(arg0: &0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::BaseToken, arg3: &0x2::clock::Clock) : 0xf1f85598c7f7af12ccaff5ad1dafa065867c37f8dba7eadd190e42bf1123bf2f::float::Decimal {
        0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::ensure_version_matches(arg0);
        check_price(0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::price_feed::ema(0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::price(arg0, arg1, arg2)), 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::price_delay_tolerance_ms(arg0), arg3)
    }

    public fun get_price_with_check(arg0: &0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::BaseToken, arg3: &0x2::clock::Clock, arg4: 0xf1f85598c7f7af12ccaff5ad1dafa065867c37f8dba7eadd190e42bf1123bf2f::float::Decimal) : 0xf1f85598c7f7af12ccaff5ad1dafa065867c37f8dba7eadd190e42bf1123bf2f::float::Decimal {
        0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::ensure_version_matches(arg0);
        let v0 = 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::price(arg0, arg1, arg2);
        let v1 = check_price(0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::price_feed::ema(v0), 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::price_delay_tolerance_ms(arg0), arg3);
        let v2 = check_price(0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::price_feed::spot(v0), 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::price_delay_tolerance_ms(arg0), arg3);
        let v3 = if (0xf1f85598c7f7af12ccaff5ad1dafa065867c37f8dba7eadd190e42bf1123bf2f::float::gt(v1, v2)) {
            0xf1f85598c7f7af12ccaff5ad1dafa065867c37f8dba7eadd190e42bf1123bf2f::float::div(0xf1f85598c7f7af12ccaff5ad1dafa065867c37f8dba7eadd190e42bf1123bf2f::float::sub(v1, v2), v2)
        } else {
            0xf1f85598c7f7af12ccaff5ad1dafa065867c37f8dba7eadd190e42bf1123bf2f::float::div(0xf1f85598c7f7af12ccaff5ad1dafa065867c37f8dba7eadd190e42bf1123bf2f::float::sub(v2, v1), v2)
        };
        assert!(0xf1f85598c7f7af12ccaff5ad1dafa065867c37f8dba7eadd190e42bf1123bf2f::float::le(v3, arg4), 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::oracle_error::ema_spot_price_too_different());
        v1
    }

    public fun get_spot_price(arg0: &0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::BaseToken, arg3: &0x2::clock::Clock) : 0xf1f85598c7f7af12ccaff5ad1dafa065867c37f8dba7eadd190e42bf1123bf2f::float::Decimal {
        0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::ensure_version_matches(arg0);
        check_price(0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::price_feed::spot(0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::price(arg0, arg1, arg2)), 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::price_delay_tolerance_ms(arg0), arg3)
    }

    public fun get_spot_price_with_check(arg0: &0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::BaseToken, arg3: &0x2::clock::Clock, arg4: 0xf1f85598c7f7af12ccaff5ad1dafa065867c37f8dba7eadd190e42bf1123bf2f::float::Decimal) : 0xf1f85598c7f7af12ccaff5ad1dafa065867c37f8dba7eadd190e42bf1123bf2f::float::Decimal {
        0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::ensure_version_matches(arg0);
        let v0 = 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::price(arg0, arg1, arg2);
        let v1 = check_price(0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::price_feed::ema(v0), 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::price_delay_tolerance_ms(arg0), arg3);
        let v2 = check_price(0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::price_feed::spot(v0), 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::price_delay_tolerance_ms(arg0), arg3);
        let v3 = if (0xf1f85598c7f7af12ccaff5ad1dafa065867c37f8dba7eadd190e42bf1123bf2f::float::gt(v1, v2)) {
            0xf1f85598c7f7af12ccaff5ad1dafa065867c37f8dba7eadd190e42bf1123bf2f::float::div(0xf1f85598c7f7af12ccaff5ad1dafa065867c37f8dba7eadd190e42bf1123bf2f::float::sub(v1, v2), v1)
        } else {
            0xf1f85598c7f7af12ccaff5ad1dafa065867c37f8dba7eadd190e42bf1123bf2f::float::div(0xf1f85598c7f7af12ccaff5ad1dafa065867c37f8dba7eadd190e42bf1123bf2f::float::sub(v2, v1), v1)
        };
        assert!(0xf1f85598c7f7af12ccaff5ad1dafa065867c37f8dba7eadd190e42bf1123bf2f::float::le(v3, arg4), 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::oracle_error::ema_spot_price_too_different());
        v2
    }

    public fun refresh_usd_price<T0>(arg0: &mut 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::XOracle, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) {
        0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::ensure_version_matches(arg0);
        0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::refresh_usd_price<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

