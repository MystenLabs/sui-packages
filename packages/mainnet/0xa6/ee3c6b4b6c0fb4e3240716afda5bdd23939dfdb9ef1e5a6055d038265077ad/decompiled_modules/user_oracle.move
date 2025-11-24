module 0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::user_oracle {
    fun check_price(arg0: &0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::price_feed::PriceFeedComponent, arg1: u64, arg2: &0x2::clock::Clock) : 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal {
        let v0 = 0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::price_feed::value(arg0);
        assert!(v0 > 0, 0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::oracle_error::oracle_zero_price_error());
        assert!(0x2::clock::timestamp_ms(arg2) - 0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::price_feed::update_time(arg0) * 1000 <= arg1, 0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::oracle_error::oracle_stale_price_error());
        0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::from_quotient(v0, 0x1::u64::pow(10, 0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::price_feed::decimals()))
    }

    public fun get_price(arg0: &0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::x_oracle::BaseToken, arg3: &0x2::clock::Clock) : 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal {
        check_price(0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::price_feed::ema(0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::x_oracle::price(arg0, arg1, arg2)), 0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::x_oracle::price_delay_tolerance_ms(arg0), arg3)
    }

    public fun get_price_with_check(arg0: &0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::x_oracle::BaseToken, arg3: &0x2::clock::Clock, arg4: 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal) : 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal {
        let v0 = 0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::x_oracle::price(arg0, arg1, arg2);
        let v1 = check_price(0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::price_feed::ema(v0), 0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::x_oracle::price_delay_tolerance_ms(arg0), arg3);
        let v2 = check_price(0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::price_feed::spot(v0), 0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::x_oracle::price_delay_tolerance_ms(arg0), arg3);
        let v3 = if (0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::gt(v1, v2)) {
            0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::div(0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::sub(v1, v2), v2)
        } else {
            0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::div(0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::sub(v2, v1), v2)
        };
        assert!(0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::lt(v3, arg4), 0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::oracle_error::ema_spot_price_too_different());
        v1
    }

    public fun get_spot_price(arg0: &0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::x_oracle::BaseToken, arg3: &0x2::clock::Clock) : 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal {
        check_price(0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::price_feed::spot(0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::x_oracle::price(arg0, arg1, arg2)), 0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::x_oracle::price_delay_tolerance_ms(arg0), arg3)
    }

    public fun refresh_usd_price<T0>(arg0: &mut 0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::x_oracle::XOracle, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) {
        0xa6ee3c6b4b6c0fb4e3240716afda5bdd23939dfdb9ef1e5a6055d038265077ad::x_oracle::refresh_usd_price<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

