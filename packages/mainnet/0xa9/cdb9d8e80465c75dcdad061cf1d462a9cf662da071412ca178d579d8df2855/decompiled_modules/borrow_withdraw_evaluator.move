module 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::borrow_withdraw_evaluator {
    public fun available_borrow_amount_in_usd(arg0: &0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::obligation::Obligation, arg1: &0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::market::Market, arg2: &0x71ec9ebe7278265b5e556938f4ec2355244423796875ff6a1a5bc53df97f0ab9::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x3658f5650dd8943ee6de53465a6d1cdc58e015348e8650ff5e69ee8201350a45::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::collateral_value::collaterals_value_usd_for_borrow(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4);
        if (0x9beb7cc33769103b080632ce0487b0906d58cfabbec06107221ecbf60a9f959d::fixed_point32_empower::gt(v0, v1)) {
            0x9beb7cc33769103b080632ce0487b0906d58cfabbec06107221ecbf60a9f959d::fixed_point32_empower::sub(v0, v1)
        } else {
            0x9beb7cc33769103b080632ce0487b0906d58cfabbec06107221ecbf60a9f959d::fixed_point32_empower::zero()
        }
    }

    public fun max_borrow_amount<T0>(arg0: &0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::obligation::Obligation, arg1: &0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::market::Market, arg2: &0x71ec9ebe7278265b5e556938f4ec2355244423796875ff6a1a5bc53df97f0ab9::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x3658f5650dd8943ee6de53465a6d1cdc58e015348e8650ff5e69ee8201350a45::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        if (0x9beb7cc33769103b080632ce0487b0906d58cfabbec06107221ecbf60a9f959d::fixed_point32_empower::gt(v0, 0x9beb7cc33769103b080632ce0487b0906d58cfabbec06107221ecbf60a9f959d::fixed_point32_empower::zero())) {
            let v2 = 0x1::type_name::get<T0>();
            0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x71ec9ebe7278265b5e556938f4ec2355244423796875ff6a1a5bc53df97f0ab9::coin_decimals_registry::decimals(arg2, v2)), 0x9beb7cc33769103b080632ce0487b0906d58cfabbec06107221ecbf60a9f959d::fixed_point32_empower::div(v0, 0x9beb7cc33769103b080632ce0487b0906d58cfabbec06107221ecbf60a9f959d::fixed_point32_empower::mul(0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::price::get_price(arg3, v2, arg4), 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::interest_model::borrow_weight(0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::market::interest_model(arg1, v2)))))
        } else {
            0
        }
    }

    public fun max_withdraw_amount<T0>(arg0: &0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::obligation::Obligation, arg1: &0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::market::Market, arg2: &0x71ec9ebe7278265b5e556938f4ec2355244423796875ff6a1a5bc53df97f0ab9::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x3658f5650dd8943ee6de53465a6d1cdc58e015348e8650ff5e69ee8201350a45::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x1::fixed_point32::is_zero(0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4))) {
            return 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::obligation::collateral(arg0, v0)
        };
        0x2::math::min(0x1::fixed_point32::divide_u64(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x71ec9ebe7278265b5e556938f4ec2355244423796875ff6a1a5bc53df97f0ab9::coin_decimals_registry::decimals(arg2, v0)), 0x9beb7cc33769103b080632ce0487b0906d58cfabbec06107221ecbf60a9f959d::fixed_point32_empower::div(available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4), 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::price::get_price(arg3, v0, arg4))), 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::risk_model::collateral_factor(0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::market::risk_model(arg1, v0))), 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::obligation::collateral(arg0, v0))
    }

    // decompiled from Move bytecode v6
}

