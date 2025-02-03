module 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::liquidation_evaluator {
    fun calc_liq_exchange_rate<T0, T1>(arg0: &0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::Market, arg1: &0x51500a3b1c18cff738fd098ddba703947c45f7fb08e2507138af74a4806944c8::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x1b2edca7df0bb72e230fa1771e059bf20bd525a36a8653c61929ab6d9febb144::x_oracle::XOracle, arg3: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x1::type_name::get<T0>();
        0x7178fcff170574d00d61bb9eee6f030bd35f71a54f33bc84bf16553ab2d575c1::fixed_point32_empower::div(0x7178fcff170574d00d61bb9eee6f030bd35f71a54f33bc84bf16553ab2d575c1::fixed_point32_empower::mul(0x1::fixed_point32::create_from_rational(0x2::math::pow(10, 0x51500a3b1c18cff738fd098ddba703947c45f7fb08e2507138af74a4806944c8::coin_decimals_registry::decimals(arg1, v0)), 0x2::math::pow(10, 0x51500a3b1c18cff738fd098ddba703947c45f7fb08e2507138af74a4806944c8::coin_decimals_registry::decimals(arg1, v1))), 0x7178fcff170574d00d61bb9eee6f030bd35f71a54f33bc84bf16553ab2d575c1::fixed_point32_empower::div(0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::price::get_price(arg2, v1, arg3), 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::price::get_price(arg2, v0, arg3))), 0x7178fcff170574d00d61bb9eee6f030bd35f71a54f33bc84bf16553ab2d575c1::fixed_point32_empower::sub(0x7178fcff170574d00d61bb9eee6f030bd35f71a54f33bc84bf16553ab2d575c1::fixed_point32_empower::from_u64(1), 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::risk_model::liq_discount(0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::risk_model(arg0, v0))))
    }

    public fun liquidation_amounts<T0, T1>(arg0: &0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::obligation::Obligation, arg1: &0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::Market, arg2: &0x51500a3b1c18cff738fd098ddba703947c45f7fb08e2507138af74a4806944c8::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: &0x1b2edca7df0bb72e230fa1771e059bf20bd525a36a8653c61929ab6d9febb144::x_oracle::XOracle, arg5: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1) = max_liquidation_amounts<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        let (v2, v3) = if (arg3 >= v0) {
            (v0, v1)
        } else {
            (arg3, 0x1::fixed_point32::multiply_u64(arg3, calc_liq_exchange_rate<T0, T1>(arg1, arg2, arg4, arg5)))
        };
        let v4 = 0x1::fixed_point32::multiply_u64(v2, 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::risk_model::liq_revenue_factor(0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::risk_model(arg1, 0x1::type_name::get<T1>())));
        (v2 - v4, v4, v3)
    }

    public fun max_liquidation_amounts<T0, T1>(arg0: &0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::obligation::Obligation, arg1: &0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::Market, arg2: &0x51500a3b1c18cff738fd098ddba703947c45f7fb08e2507138af74a4806944c8::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x1b2edca7df0bb72e230fa1771e059bf20bd525a36a8653c61929ab6d9febb144::x_oracle::XOracle, arg4: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::risk_model(arg1, v1);
        let v3 = 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::risk_model::liq_factor(v2);
        let v4 = 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4);
        let v5 = 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4);
        assert!(0x7178fcff170574d00d61bb9eee6f030bd35f71a54f33bc84bf16553ab2d575c1::fixed_point32_empower::gt(v5, v4), 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::error::unable_to_liquidate_error());
        let v6 = 0x2::math::min(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x51500a3b1c18cff738fd098ddba703947c45f7fb08e2507138af74a4806944c8::coin_decimals_registry::decimals(arg2, v1)), 0x7178fcff170574d00d61bb9eee6f030bd35f71a54f33bc84bf16553ab2d575c1::fixed_point32_empower::div(0x7178fcff170574d00d61bb9eee6f030bd35f71a54f33bc84bf16553ab2d575c1::fixed_point32_empower::div(0x7178fcff170574d00d61bb9eee6f030bd35f71a54f33bc84bf16553ab2d575c1::fixed_point32_empower::sub(v5, v4), 0x7178fcff170574d00d61bb9eee6f030bd35f71a54f33bc84bf16553ab2d575c1::fixed_point32_empower::sub(0x7178fcff170574d00d61bb9eee6f030bd35f71a54f33bc84bf16553ab2d575c1::fixed_point32_empower::mul(0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::interest_model::borrow_weight(0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::interest_model(arg1, v0)), 0x7178fcff170574d00d61bb9eee6f030bd35f71a54f33bc84bf16553ab2d575c1::fixed_point32_empower::sub(0x7178fcff170574d00d61bb9eee6f030bd35f71a54f33bc84bf16553ab2d575c1::fixed_point32_empower::from_u64(1), 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::risk_model::liq_penalty(v2))), v3)), 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::price::get_price(arg3, v1, arg4))), 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::obligation::collateral(arg0, v1));
        let v7 = calc_liq_exchange_rate<T0, T1>(arg1, arg2, arg3, arg4);
        let v8 = 0x1::fixed_point32::divide_u64(v6, v7);
        let (v9, _) = 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::obligation::debt(arg0, v0);
        if (v8 <= v9) {
            (v8, v6)
        } else {
            (v9, 0x1::fixed_point32::multiply_u64(v9, v7))
        }
    }

    // decompiled from Move bytecode v6
}

