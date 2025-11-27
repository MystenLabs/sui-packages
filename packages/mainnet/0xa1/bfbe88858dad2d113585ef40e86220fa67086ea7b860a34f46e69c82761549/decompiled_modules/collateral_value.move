module 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::collateral_value {
    public fun collaterals_value_usd_for_borrow(arg0: &0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::Obligation, arg1: &0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market::Market, arg2: &0x85f92dbca022a519c6071cc358948a2e8c398fc9aed167cb1f0b0288bf9a1479::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x64d704ec79adb95f308732d510907b6673db75fb3edabb3f7dc1e527094d3143::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::collateral_types(arg0);
        let v1 = 0xb7bf1daa413c2d5357f9d0323234a664a1bbf49c1565a72264035f98c37365cf::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0xb7bf1daa413c2d5357f9d0323234a664a1bbf49c1565a72264035f98c37365cf::fixed_point32_empower::add(v1, 0xb7bf1daa413c2d5357f9d0323234a664a1bbf49c1565a72264035f98c37365cf::fixed_point32_empower::mul(0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::value_calculator::usd_value(0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::price::get_price(arg3, v3, arg4), 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::collateral(arg0, v3), 0x85f92dbca022a519c6071cc358948a2e8c398fc9aed167cb1f0b0288bf9a1479::coin_decimals_registry::decimals(arg2, v3)), 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::risk_model::collateral_factor(0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    public fun collaterals_value_usd_for_liquidation(arg0: &0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::Obligation, arg1: &0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market::Market, arg2: &0x85f92dbca022a519c6071cc358948a2e8c398fc9aed167cb1f0b0288bf9a1479::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x64d704ec79adb95f308732d510907b6673db75fb3edabb3f7dc1e527094d3143::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::collateral_types(arg0);
        let v1 = 0xb7bf1daa413c2d5357f9d0323234a664a1bbf49c1565a72264035f98c37365cf::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0xb7bf1daa413c2d5357f9d0323234a664a1bbf49c1565a72264035f98c37365cf::fixed_point32_empower::add(v1, 0xb7bf1daa413c2d5357f9d0323234a664a1bbf49c1565a72264035f98c37365cf::fixed_point32_empower::mul(0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::value_calculator::usd_value(0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::price::get_price(arg3, v3, arg4), 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::collateral(arg0, v3), 0x85f92dbca022a519c6071cc358948a2e8c398fc9aed167cb1f0b0288bf9a1479::coin_decimals_registry::decimals(arg2, v3)), 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::risk_model::liq_factor(0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

