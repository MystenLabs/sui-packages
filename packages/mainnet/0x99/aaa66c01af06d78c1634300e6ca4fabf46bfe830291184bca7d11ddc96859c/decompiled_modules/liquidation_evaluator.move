module 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::liquidation_evaluator {
    fun calc_liq_exchange_rate<T0, T1>(arg0: &0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::market::Market, arg1: &0xd68eb3aafa85228a532500ca1ca45af097cb3b941dbdf297e68b1f01e0cdd95e::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x6987906fbf965e4ac549e774e22714cbab402fd934330702727e2efb1b2aa98e::x_oracle::XOracle, arg3: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x1::type_name::get<T0>();
        0x4832f08c0e5834edb73c8bfd2e5bae8af0be925d63e2e95df8434c2a5d7fd625::fixed_point32_empower::div(0x4832f08c0e5834edb73c8bfd2e5bae8af0be925d63e2e95df8434c2a5d7fd625::fixed_point32_empower::mul(0x1::fixed_point32::create_from_rational(0x2::math::pow(10, 0xd68eb3aafa85228a532500ca1ca45af097cb3b941dbdf297e68b1f01e0cdd95e::coin_decimals_registry::decimals(arg1, v0)), 0x2::math::pow(10, 0xd68eb3aafa85228a532500ca1ca45af097cb3b941dbdf297e68b1f01e0cdd95e::coin_decimals_registry::decimals(arg1, v1))), 0x4832f08c0e5834edb73c8bfd2e5bae8af0be925d63e2e95df8434c2a5d7fd625::fixed_point32_empower::div(0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::price::get_price(arg2, v1, arg3), 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::price::get_price(arg2, v0, arg3))), 0x4832f08c0e5834edb73c8bfd2e5bae8af0be925d63e2e95df8434c2a5d7fd625::fixed_point32_empower::sub(0x4832f08c0e5834edb73c8bfd2e5bae8af0be925d63e2e95df8434c2a5d7fd625::fixed_point32_empower::from_u64(1), 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::risk_model::liq_discount(0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::market::risk_model(arg0, v0))))
    }

    public fun liquidation_amounts<T0, T1>(arg0: &0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::obligation::Obligation, arg1: &0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::market::Market, arg2: &0xd68eb3aafa85228a532500ca1ca45af097cb3b941dbdf297e68b1f01e0cdd95e::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: &0x6987906fbf965e4ac549e774e22714cbab402fd934330702727e2efb1b2aa98e::x_oracle::XOracle, arg5: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1) = max_liquidation_amounts<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        let (v2, v3) = if (arg3 >= v0) {
            (v0, v1)
        } else {
            (arg3, 0x1::fixed_point32::multiply_u64(arg3, calc_liq_exchange_rate<T0, T1>(arg1, arg2, arg4, arg5)))
        };
        let v4 = 0x1::fixed_point32::multiply_u64(v2, 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::risk_model::liq_revenue_factor(0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::market::risk_model(arg1, 0x1::type_name::get<T1>())));
        (v2 - v4, v4, v3)
    }

    public fun max_liquidation_amounts<T0, T1>(arg0: &0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::obligation::Obligation, arg1: &0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::market::Market, arg2: &0xd68eb3aafa85228a532500ca1ca45af097cb3b941dbdf297e68b1f01e0cdd95e::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x6987906fbf965e4ac549e774e22714cbab402fd934330702727e2efb1b2aa98e::x_oracle::XOracle, arg4: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x1::type_name::get<T0>();
        let (_, _) = 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::obligation::debt(arg0, v0);
        let v3 = 0x1::type_name::get<T1>();
        let v4 = 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::market::risk_model(arg1, v3);
        let v5 = 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::risk_model::liq_factor(v4);
        let v6 = 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4);
        let v7 = 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4);
        assert!(0x4832f08c0e5834edb73c8bfd2e5bae8af0be925d63e2e95df8434c2a5d7fd625::fixed_point32_empower::gt(v7, v6), 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::error::unable_to_liquidate_error());
        let v8 = 0x2::math::min(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0xd68eb3aafa85228a532500ca1ca45af097cb3b941dbdf297e68b1f01e0cdd95e::coin_decimals_registry::decimals(arg2, v3)), 0x4832f08c0e5834edb73c8bfd2e5bae8af0be925d63e2e95df8434c2a5d7fd625::fixed_point32_empower::div(0x4832f08c0e5834edb73c8bfd2e5bae8af0be925d63e2e95df8434c2a5d7fd625::fixed_point32_empower::div(0x4832f08c0e5834edb73c8bfd2e5bae8af0be925d63e2e95df8434c2a5d7fd625::fixed_point32_empower::sub(v7, v6), 0x4832f08c0e5834edb73c8bfd2e5bae8af0be925d63e2e95df8434c2a5d7fd625::fixed_point32_empower::sub(0x4832f08c0e5834edb73c8bfd2e5bae8af0be925d63e2e95df8434c2a5d7fd625::fixed_point32_empower::mul(0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::interest_model::borrow_weight(0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::market::interest_model(arg1, v0)), 0x4832f08c0e5834edb73c8bfd2e5bae8af0be925d63e2e95df8434c2a5d7fd625::fixed_point32_empower::sub(0x4832f08c0e5834edb73c8bfd2e5bae8af0be925d63e2e95df8434c2a5d7fd625::fixed_point32_empower::from_u64(1), 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::risk_model::liq_penalty(v4))), v5)), 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::price::get_price(arg3, v3, arg4))), 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::obligation::collateral(arg0, v3));
        let v9 = calc_liq_exchange_rate<T0, T1>(arg1, arg2, arg3, arg4);
        let v10 = 0x1::fixed_point32::divide_u64(v8, v9);
        let (v11, _) = 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::obligation::debt(arg0, v0);
        if (v10 <= v11) {
            (v10, v8)
        } else {
            (v11, 0x1::fixed_point32::multiply_u64(v11, v9))
        }
    }

    // decompiled from Move bytecode v6
}

