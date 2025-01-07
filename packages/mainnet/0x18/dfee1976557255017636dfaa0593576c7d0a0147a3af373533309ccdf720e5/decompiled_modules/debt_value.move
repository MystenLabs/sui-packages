module 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::debt_value {
    public fun debts_value_usd(arg0: &0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::obligation::Obligation, arg1: &0x51500a3b1c18cff738fd098ddba703947c45f7fb08e2507138af74a4806944c8::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x1b2edca7df0bb72e230fa1771e059bf20bd525a36a8653c61929ab6d9febb144::x_oracle::XOracle, arg3: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::obligation::debt_types(arg0);
        let v1 = 0x7178fcff170574d00d61bb9eee6f030bd35f71a54f33bc84bf16553ab2d575c1::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            let (v4, _) = 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::obligation::debt(arg0, v3);
            v1 = 0x7178fcff170574d00d61bb9eee6f030bd35f71a54f33bc84bf16553ab2d575c1::fixed_point32_empower::add(v1, 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::value_calculator::usd_value(0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::price::get_price(arg2, v3, arg3), v4, 0x51500a3b1c18cff738fd098ddba703947c45f7fb08e2507138af74a4806944c8::coin_decimals_registry::decimals(arg1, v3)));
            v2 = v2 + 1;
        };
        v1
    }

    public fun debts_value_usd_with_weight(arg0: &0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::obligation::Obligation, arg1: &0x51500a3b1c18cff738fd098ddba703947c45f7fb08e2507138af74a4806944c8::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::Market, arg3: &0x1b2edca7df0bb72e230fa1771e059bf20bd525a36a8653c61929ab6d9febb144::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::obligation::debt_types(arg0);
        let v1 = 0x7178fcff170574d00d61bb9eee6f030bd35f71a54f33bc84bf16553ab2d575c1::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            let (v4, _) = 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::obligation::debt(arg0, v3);
            v1 = 0x7178fcff170574d00d61bb9eee6f030bd35f71a54f33bc84bf16553ab2d575c1::fixed_point32_empower::add(v1, 0x7178fcff170574d00d61bb9eee6f030bd35f71a54f33bc84bf16553ab2d575c1::fixed_point32_empower::mul(0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::value_calculator::usd_value(0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::price::get_price(arg3, v3, arg4), v4, 0x51500a3b1c18cff738fd098ddba703947c45f7fb08e2507138af74a4806944c8::coin_decimals_registry::decimals(arg1, v3)), 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::interest_model::borrow_weight(0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::market::interest_model(arg2, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

