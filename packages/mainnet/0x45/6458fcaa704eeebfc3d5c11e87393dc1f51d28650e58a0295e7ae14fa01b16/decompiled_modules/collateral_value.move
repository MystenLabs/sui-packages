module 0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::collateral_value {
    public fun collaterals_value_usd_for_borrow(arg0: &0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::obligation::Obligation, arg1: &0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::market::Market, arg2: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xe2785270b2e6179e68204dd5901a43f9a0e1c566baf656cad705d45a419c4d3a::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::obligation::collateral_types(arg0);
        let v1 = 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::zero();
        let v2 = preload_e_mode_category(arg0, arg1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v3);
            let v5 = if (0x1::option::is_some<0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::e_mode::EModeCategory>(&v2) && 0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::e_mode::is_collateral_in_category(0x1::option::borrow<0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::e_mode::EModeCategory>(&v2), v4)) {
                0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::e_mode::collateral_factor(0x1::option::borrow<0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::e_mode::EModeCategory>(&v2))
            } else {
                0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::risk_model::collateral_factor(0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::market::risk_model(arg1, v4))
            };
            v1 = 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::add(v1, 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::mul(0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::value_calculator::usd_value(0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::price::get_price(arg3, v4, arg4), 0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::obligation::collateral(arg0, v4), 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg2, v4)), v5));
            v3 = v3 + 1;
        };
        v1
    }

    public fun collaterals_value_usd_for_liquidation(arg0: &0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::obligation::Obligation, arg1: &0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::market::Market, arg2: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xe2785270b2e6179e68204dd5901a43f9a0e1c566baf656cad705d45a419c4d3a::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::obligation::collateral_types(arg0);
        let v1 = 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::zero();
        let v2 = preload_e_mode_category(arg0, arg1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v3);
            let v5 = if (0x1::option::is_some<0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::e_mode::EModeCategory>(&v2) && 0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::e_mode::is_collateral_in_category(0x1::option::borrow<0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::e_mode::EModeCategory>(&v2), v4)) {
                0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::e_mode::liquidation_factor(0x1::option::borrow<0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::e_mode::EModeCategory>(&v2))
            } else {
                0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::risk_model::liq_factor(0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::market::risk_model(arg1, v4))
            };
            v1 = 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::add(v1, 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::mul(0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::value_calculator::usd_value(0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::price::get_price(arg3, v4, arg4), 0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::obligation::collateral(arg0, v4), 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg2, v4)), v5));
            v3 = v3 + 1;
        };
        v1
    }

    fun preload_e_mode_category(arg0: &0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::obligation::Obligation, arg1: &0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::market::Market) : 0x1::option::Option<0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::e_mode::EModeCategory> {
        let v0 = 0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::obligation::e_mode_category(arg0);
        if (v0 > 0 && 0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::e_mode::has_category(0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::market::uid(arg1), v0)) {
            0x1::option::some<0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::e_mode::EModeCategory>(*0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::e_mode::get_category(0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::market::uid(arg1), v0))
        } else {
            0x1::option::none<0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::e_mode::EModeCategory>()
        }
    }

    // decompiled from Move bytecode v7
}

