module 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::borrow_withdraw_evaluator {
    public fun available_borrow_amount_in_usd(arg0: &0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::obligation::Obligation, arg1: &0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::market::Market, arg2: &0xeeb70882d5ff9c5aacf7e162e467d884b308781feb62d4ceff9224695698be23::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x5426f3642f8bb08fb9fe78d25f543730a30b9a248bcf1bd816c6dd5d650921f2::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::collateral_value::collaterals_value_usd_for_borrow(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4);
        if (0x507ca0f5baecdba0244ff1801d9ca7cc957596c349dd797ba675a04be1f2db28::fixed_point32_empower::gt(v0, v1)) {
            0x507ca0f5baecdba0244ff1801d9ca7cc957596c349dd797ba675a04be1f2db28::fixed_point32_empower::sub(v0, v1)
        } else {
            0x507ca0f5baecdba0244ff1801d9ca7cc957596c349dd797ba675a04be1f2db28::fixed_point32_empower::zero()
        }
    }

    public fun max_borrow_amount<T0>(arg0: &0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::obligation::Obligation, arg1: &0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::market::Market, arg2: &0xeeb70882d5ff9c5aacf7e162e467d884b308781feb62d4ceff9224695698be23::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x5426f3642f8bb08fb9fe78d25f543730a30b9a248bcf1bd816c6dd5d650921f2::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        if (0x507ca0f5baecdba0244ff1801d9ca7cc957596c349dd797ba675a04be1f2db28::fixed_point32_empower::gt(v0, 0x507ca0f5baecdba0244ff1801d9ca7cc957596c349dd797ba675a04be1f2db28::fixed_point32_empower::zero())) {
            let v2 = 0x1::type_name::get<T0>();
            0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0xeeb70882d5ff9c5aacf7e162e467d884b308781feb62d4ceff9224695698be23::coin_decimals_registry::decimals(arg2, v2)), 0x507ca0f5baecdba0244ff1801d9ca7cc957596c349dd797ba675a04be1f2db28::fixed_point32_empower::div(v0, 0x507ca0f5baecdba0244ff1801d9ca7cc957596c349dd797ba675a04be1f2db28::fixed_point32_empower::mul(0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::price::get_price(arg3, v2, arg4), 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::interest_model::borrow_weight(0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::market::interest_model(arg1, v2)))))
        } else {
            0
        }
    }

    public fun max_withdraw_amount<T0>(arg0: &0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::obligation::Obligation, arg1: &0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::market::Market, arg2: &0xeeb70882d5ff9c5aacf7e162e467d884b308781feb62d4ceff9224695698be23::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x5426f3642f8bb08fb9fe78d25f543730a30b9a248bcf1bd816c6dd5d650921f2::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x1::fixed_point32::is_zero(0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4))) {
            return 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::obligation::collateral(arg0, v0)
        };
        0x2::math::min(0x1::fixed_point32::divide_u64(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0xeeb70882d5ff9c5aacf7e162e467d884b308781feb62d4ceff9224695698be23::coin_decimals_registry::decimals(arg2, v0)), 0x507ca0f5baecdba0244ff1801d9ca7cc957596c349dd797ba675a04be1f2db28::fixed_point32_empower::div(available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4), 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::price::get_price(arg3, v0, arg4))), 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::risk_model::collateral_factor(0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::market::risk_model(arg1, v0))), 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::obligation::collateral(arg0, v0))
    }

    // decompiled from Move bytecode v6
}

