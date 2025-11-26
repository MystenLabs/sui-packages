module 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::borrow_withdraw_evaluator {
    public fun available_borrow_amount_in_usd(arg0: &0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::Obligation, arg1: &0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market::Market, arg2: &0x177afe2b7c818730b4980df53cc683be7393d20cada006b02152d92210983a74::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x7fdc2bc8e78c3e133728c75e54fe5587b868ad59f849d8c7611147cc0394f305::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::collateral_value::collaterals_value_usd_for_borrow(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::debt_value::debts_value_usd(arg0, arg2, arg3, arg4);
        if (0x47aee540b4cf13763b58341097db066dc43dfa0574cd74729b64694f097a4d5d::fixed_point32_empower::gt(v0, v1)) {
            0x47aee540b4cf13763b58341097db066dc43dfa0574cd74729b64694f097a4d5d::fixed_point32_empower::sub(v0, v1)
        } else {
            0x47aee540b4cf13763b58341097db066dc43dfa0574cd74729b64694f097a4d5d::fixed_point32_empower::zero()
        }
    }

    public fun max_borrow_amount<T0>(arg0: &0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::Obligation, arg1: &0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market::Market, arg2: &0x177afe2b7c818730b4980df53cc683be7393d20cada006b02152d92210983a74::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x7fdc2bc8e78c3e133728c75e54fe5587b868ad59f849d8c7611147cc0394f305::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        if (0x47aee540b4cf13763b58341097db066dc43dfa0574cd74729b64694f097a4d5d::fixed_point32_empower::gt(v0, 0x47aee540b4cf13763b58341097db066dc43dfa0574cd74729b64694f097a4d5d::fixed_point32_empower::zero())) {
            let v2 = 0x1::type_name::get<T0>();
            0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x177afe2b7c818730b4980df53cc683be7393d20cada006b02152d92210983a74::coin_decimals_registry::decimals(arg2, v2)), 0x47aee540b4cf13763b58341097db066dc43dfa0574cd74729b64694f097a4d5d::fixed_point32_empower::div(v0, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::price::get_price(arg3, v2, arg4)))
        } else {
            0
        }
    }

    public fun max_withdraw_amount<T0>(arg0: &0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::Obligation, arg1: &0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market::Market, arg2: &0x177afe2b7c818730b4980df53cc683be7393d20cada006b02152d92210983a74::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x7fdc2bc8e78c3e133728c75e54fe5587b868ad59f849d8c7611147cc0394f305::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x1::fixed_point32::is_zero(0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::debt_value::debts_value_usd(arg0, arg2, arg3, arg4))) {
            return 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::collateral(arg0, v0)
        };
        let v1 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        let v2 = 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::risk_model::collateral_factor(0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market::risk_model(arg1, v0));
        if (0x1::fixed_point32::is_zero(v2)) {
            return if (!0x1::fixed_point32::is_zero(v1)) {
                0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::collateral(arg0, v0)
            } else {
                0
            }
        };
        0x2::math::min(0x1::fixed_point32::divide_u64(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x177afe2b7c818730b4980df53cc683be7393d20cada006b02152d92210983a74::coin_decimals_registry::decimals(arg2, v0)), 0x47aee540b4cf13763b58341097db066dc43dfa0574cd74729b64694f097a4d5d::fixed_point32_empower::div(v1, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::price::get_price(arg3, v0, arg4))), v2), 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::obligation::collateral(arg0, v0))
    }

    // decompiled from Move bytecode v6
}

