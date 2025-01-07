module 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::collateral_value {
    public fun collaterals_value_usd_for_borrow(arg0: &0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::obligation::Obligation, arg1: &0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::market::Market, arg2: &0xeeb70882d5ff9c5aacf7e162e467d884b308781feb62d4ceff9224695698be23::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x5426f3642f8bb08fb9fe78d25f543730a30b9a248bcf1bd816c6dd5d650921f2::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::obligation::collateral_types(arg0);
        let v1 = 0x507ca0f5baecdba0244ff1801d9ca7cc957596c349dd797ba675a04be1f2db28::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0x507ca0f5baecdba0244ff1801d9ca7cc957596c349dd797ba675a04be1f2db28::fixed_point32_empower::add(v1, 0x507ca0f5baecdba0244ff1801d9ca7cc957596c349dd797ba675a04be1f2db28::fixed_point32_empower::mul(0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::value_calculator::usd_value(0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::price::get_price(arg3, v3, arg4), 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::obligation::collateral(arg0, v3), 0xeeb70882d5ff9c5aacf7e162e467d884b308781feb62d4ceff9224695698be23::coin_decimals_registry::decimals(arg2, v3)), 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::risk_model::collateral_factor(0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    public fun collaterals_value_usd_for_liquidation(arg0: &0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::obligation::Obligation, arg1: &0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::market::Market, arg2: &0xeeb70882d5ff9c5aacf7e162e467d884b308781feb62d4ceff9224695698be23::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x5426f3642f8bb08fb9fe78d25f543730a30b9a248bcf1bd816c6dd5d650921f2::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::obligation::collateral_types(arg0);
        let v1 = 0x507ca0f5baecdba0244ff1801d9ca7cc957596c349dd797ba675a04be1f2db28::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0x507ca0f5baecdba0244ff1801d9ca7cc957596c349dd797ba675a04be1f2db28::fixed_point32_empower::add(v1, 0x507ca0f5baecdba0244ff1801d9ca7cc957596c349dd797ba675a04be1f2db28::fixed_point32_empower::mul(0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::value_calculator::usd_value(0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::price::get_price(arg3, v3, arg4), 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::obligation::collateral(arg0, v3), 0xeeb70882d5ff9c5aacf7e162e467d884b308781feb62d4ceff9224695698be23::coin_decimals_registry::decimals(arg2, v3)), 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::risk_model::liq_factor(0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

