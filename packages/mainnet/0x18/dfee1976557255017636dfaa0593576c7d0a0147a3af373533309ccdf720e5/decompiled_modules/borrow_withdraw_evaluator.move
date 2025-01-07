module 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::borrow_withdraw_evaluator {
    public fun available_borrow_amount_in_usd(arg0: &0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::obligation::Obligation, arg1: &0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::Market, arg2: &0x51500a3b1c18cff738fd098ddba703947c45f7fb08e2507138af74a4806944c8::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x1b2edca7df0bb72e230fa1771e059bf20bd525a36a8653c61929ab6d9febb144::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::collateral_value::collaterals_value_usd_for_borrow(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4);
        if (0x7178fcff170574d00d61bb9eee6f030bd35f71a54f33bc84bf16553ab2d575c1::fixed_point32_empower::gt(v0, v1)) {
            0x7178fcff170574d00d61bb9eee6f030bd35f71a54f33bc84bf16553ab2d575c1::fixed_point32_empower::sub(v0, v1)
        } else {
            0x7178fcff170574d00d61bb9eee6f030bd35f71a54f33bc84bf16553ab2d575c1::fixed_point32_empower::zero()
        }
    }

    public fun max_borrow_amount<T0>(arg0: &0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::obligation::Obligation, arg1: &0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::Market, arg2: &0x51500a3b1c18cff738fd098ddba703947c45f7fb08e2507138af74a4806944c8::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x1b2edca7df0bb72e230fa1771e059bf20bd525a36a8653c61929ab6d9febb144::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        if (0x7178fcff170574d00d61bb9eee6f030bd35f71a54f33bc84bf16553ab2d575c1::fixed_point32_empower::gt(v0, 0x7178fcff170574d00d61bb9eee6f030bd35f71a54f33bc84bf16553ab2d575c1::fixed_point32_empower::zero())) {
            let v2 = 0x1::type_name::get<T0>();
            0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x51500a3b1c18cff738fd098ddba703947c45f7fb08e2507138af74a4806944c8::coin_decimals_registry::decimals(arg2, v2)), 0x7178fcff170574d00d61bb9eee6f030bd35f71a54f33bc84bf16553ab2d575c1::fixed_point32_empower::div(v0, 0x7178fcff170574d00d61bb9eee6f030bd35f71a54f33bc84bf16553ab2d575c1::fixed_point32_empower::mul(0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::price::get_price(arg3, v2, arg4), 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::interest_model::borrow_weight(0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::interest_model(arg1, v2)))))
        } else {
            0
        }
    }

    public fun max_withdraw_amount<T0>(arg0: &0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::obligation::Obligation, arg1: &0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::Market, arg2: &0x51500a3b1c18cff738fd098ddba703947c45f7fb08e2507138af74a4806944c8::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x1b2edca7df0bb72e230fa1771e059bf20bd525a36a8653c61929ab6d9febb144::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x1::fixed_point32::is_zero(0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4))) {
            return 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::obligation::collateral(arg0, v0)
        };
        let v1 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        let v2 = 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::risk_model::collateral_factor(0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::risk_model(arg1, v0));
        if (0x1::fixed_point32::is_zero(v2)) {
            return if (!0x1::fixed_point32::is_zero(v1)) {
                0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::obligation::collateral(arg0, v0)
            } else {
                0
            }
        };
        0x2::math::min(0x1::fixed_point32::divide_u64(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x51500a3b1c18cff738fd098ddba703947c45f7fb08e2507138af74a4806944c8::coin_decimals_registry::decimals(arg2, v0)), 0x7178fcff170574d00d61bb9eee6f030bd35f71a54f33bc84bf16553ab2d575c1::fixed_point32_empower::div(v1, 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::price::get_price(arg3, v0, arg4))), v2), 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::obligation::collateral(arg0, v0))
    }

    // decompiled from Move bytecode v6
}

