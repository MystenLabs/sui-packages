module 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::liquidation_evaluator {
    fun calc_liq_exchange_rate<T0, T1>(arg0: &0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::market::Market, arg1: &0x71ec9ebe7278265b5e556938f4ec2355244423796875ff6a1a5bc53df97f0ab9::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x3658f5650dd8943ee6de53465a6d1cdc58e015348e8650ff5e69ee8201350a45::x_oracle::XOracle, arg3: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x1::type_name::get<T0>();
        0x9beb7cc33769103b080632ce0487b0906d58cfabbec06107221ecbf60a9f959d::fixed_point32_empower::div(0x9beb7cc33769103b080632ce0487b0906d58cfabbec06107221ecbf60a9f959d::fixed_point32_empower::mul(0x1::fixed_point32::create_from_rational(0x2::math::pow(10, 0x71ec9ebe7278265b5e556938f4ec2355244423796875ff6a1a5bc53df97f0ab9::coin_decimals_registry::decimals(arg1, v0)), 0x2::math::pow(10, 0x71ec9ebe7278265b5e556938f4ec2355244423796875ff6a1a5bc53df97f0ab9::coin_decimals_registry::decimals(arg1, v1))), 0x9beb7cc33769103b080632ce0487b0906d58cfabbec06107221ecbf60a9f959d::fixed_point32_empower::div(0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::price::get_price(arg2, v1, arg3), 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::price::get_price(arg2, v0, arg3))), 0x9beb7cc33769103b080632ce0487b0906d58cfabbec06107221ecbf60a9f959d::fixed_point32_empower::sub(0x9beb7cc33769103b080632ce0487b0906d58cfabbec06107221ecbf60a9f959d::fixed_point32_empower::from_u64(1), 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::risk_model::liq_discount(0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::market::risk_model(arg0, v0))))
    }

    public fun liquidation_amounts<T0, T1>(arg0: &0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::obligation::Obligation, arg1: &0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::market::Market, arg2: &0x71ec9ebe7278265b5e556938f4ec2355244423796875ff6a1a5bc53df97f0ab9::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: &0x3658f5650dd8943ee6de53465a6d1cdc58e015348e8650ff5e69ee8201350a45::x_oracle::XOracle, arg5: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1) = max_liquidation_amounts<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        let (v2, v3) = if (arg3 >= v0) {
            (v0, v1)
        } else {
            (arg3, 0x1::fixed_point32::multiply_u64(arg3, calc_liq_exchange_rate<T0, T1>(arg1, arg2, arg4, arg5)))
        };
        let v4 = 0x1::fixed_point32::multiply_u64(v2, 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::risk_model::liq_revenue_factor(0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::market::risk_model(arg1, 0x1::type_name::get<T1>())));
        (v2 - v4, v4, v3)
    }

    public fun max_liquidation_amounts<T0, T1>(arg0: &0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::obligation::Obligation, arg1: &0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::market::Market, arg2: &0x71ec9ebe7278265b5e556938f4ec2355244423796875ff6a1a5bc53df97f0ab9::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x3658f5650dd8943ee6de53465a6d1cdc58e015348e8650ff5e69ee8201350a45::x_oracle::XOracle, arg4: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x1::type_name::get<T0>();
        let (_, _) = 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::obligation::debt(arg0, v0);
        let v3 = 0x1::type_name::get<T1>();
        let v4 = 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::market::risk_model(arg1, v3);
        let v5 = 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::risk_model::liq_factor(v4);
        let v6 = 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4);
        let v7 = 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4);
        assert!(0x9beb7cc33769103b080632ce0487b0906d58cfabbec06107221ecbf60a9f959d::fixed_point32_empower::gt(v7, v6), 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::error::unable_to_liquidate_error());
        let v8 = 0x2::math::min(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x71ec9ebe7278265b5e556938f4ec2355244423796875ff6a1a5bc53df97f0ab9::coin_decimals_registry::decimals(arg2, v3)), 0x9beb7cc33769103b080632ce0487b0906d58cfabbec06107221ecbf60a9f959d::fixed_point32_empower::div(0x9beb7cc33769103b080632ce0487b0906d58cfabbec06107221ecbf60a9f959d::fixed_point32_empower::div(0x9beb7cc33769103b080632ce0487b0906d58cfabbec06107221ecbf60a9f959d::fixed_point32_empower::sub(v7, v6), 0x9beb7cc33769103b080632ce0487b0906d58cfabbec06107221ecbf60a9f959d::fixed_point32_empower::sub(0x9beb7cc33769103b080632ce0487b0906d58cfabbec06107221ecbf60a9f959d::fixed_point32_empower::mul(0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::interest_model::borrow_weight(0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::market::interest_model(arg1, v0)), 0x9beb7cc33769103b080632ce0487b0906d58cfabbec06107221ecbf60a9f959d::fixed_point32_empower::sub(0x9beb7cc33769103b080632ce0487b0906d58cfabbec06107221ecbf60a9f959d::fixed_point32_empower::from_u64(1), 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::risk_model::liq_penalty(v4))), v5)), 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::price::get_price(arg3, v3, arg4))), 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::obligation::collateral(arg0, v3));
        let v9 = calc_liq_exchange_rate<T0, T1>(arg1, arg2, arg3, arg4);
        let v10 = 0x1::fixed_point32::divide_u64(v8, v9);
        let (v11, _) = 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::obligation::debt(arg0, v0);
        if (v10 <= v11) {
            (v10, v8)
        } else {
            (v11, 0x1::fixed_point32::multiply_u64(v11, v9))
        }
    }

    // decompiled from Move bytecode v6
}

