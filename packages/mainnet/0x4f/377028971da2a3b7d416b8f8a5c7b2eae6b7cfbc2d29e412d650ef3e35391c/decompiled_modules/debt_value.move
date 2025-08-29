module 0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::debt_value {
    public fun debts_value_usd(arg0: &0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::obligation::Obligation, arg1: &0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::x_oracle::XOracle, arg3: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::obligation::debt_types(arg0);
        let v1 = 0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            let (v4, _) = 0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::obligation::debt(arg0, v3);
            v1 = 0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::fixed_point32_empower::add(v1, 0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::value_calculator::usd_value(0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::price::get_price(arg2, v3, arg3), v4, 0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::coin_decimals_registry::decimals(arg1, v3)));
            v2 = v2 + 1;
        };
        v1
    }

    public fun debts_value_usd_with_weight(arg0: &0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::obligation::Obligation, arg1: &0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::market::Market, arg3: &0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::obligation::debt_types(arg0);
        let v1 = 0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            let (v4, _) = 0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::obligation::debt(arg0, v3);
            v1 = 0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::fixed_point32_empower::add(v1, 0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::fixed_point32_empower::mul(0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::value_calculator::usd_value(0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::price::get_price(arg3, v3, arg4), v4, 0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::coin_decimals_registry::decimals(arg1, v3)), 0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::interest_model::borrow_weight(0x4f377028971da2a3b7d416b8f8a5c7b2eae6b7cfbc2d29e412d650ef3e35391c::market::interest_model(arg2, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

