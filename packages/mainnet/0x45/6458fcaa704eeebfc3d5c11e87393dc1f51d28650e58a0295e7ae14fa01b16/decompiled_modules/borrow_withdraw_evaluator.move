module 0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::borrow_withdraw_evaluator {
    public fun available_borrow_amount_in_usd(arg0: &0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::obligation::Obligation, arg1: &0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::market::Market, arg2: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xe2785270b2e6179e68204dd5901a43f9a0e1c566baf656cad705d45a419c4d3a::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::collateral_value::collaterals_value_usd_for_borrow(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4);
        if (0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::gt(v0, v1)) {
            0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::sub(v0, v1)
        } else {
            0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::zero()
        }
    }

    public fun max_borrow_amount<T0>(arg0: &0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::obligation::Obligation, arg1: &0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::market::Market, arg2: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xe2785270b2e6179e68204dd5901a43f9a0e1c566baf656cad705d45a419c4d3a::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        if (0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::gt(v0, 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::zero())) {
            let v2 = 0x1::type_name::get<T0>();
            0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg2, v2)), 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::div(v0, 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::mul(0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::price::get_price(arg3, v2, arg4), 0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::interest_model::borrow_weight(0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::market::interest_model(arg1, v2)))))
        } else {
            0
        }
    }

    public fun max_withdraw_amount<T0>(arg0: &0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::obligation::Obligation, arg1: &0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::market::Market, arg2: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xe2785270b2e6179e68204dd5901a43f9a0e1c566baf656cad705d45a419c4d3a::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x1::fixed_point32::is_zero(0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4))) {
            return 0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::obligation::collateral(arg0, v0)
        };
        let v1 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        let v2 = 0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::obligation::e_mode_category(arg0);
        let v3 = 0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::market::uid(arg1);
        let v4 = if (v2 > 0 && 0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::e_mode::has_category(v3, v2)) {
            let v5 = 0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::e_mode::get_category(v3, v2);
            if (0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::e_mode::is_collateral_in_category(v5, v0)) {
                0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::e_mode::collateral_factor(v5)
            } else {
                0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::risk_model::collateral_factor(0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::market::risk_model(arg1, v0))
            }
        } else {
            0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::risk_model::collateral_factor(0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::market::risk_model(arg1, v0))
        };
        if (0x1::fixed_point32::is_zero(v4)) {
            return if (!0x1::fixed_point32::is_zero(v1)) {
                0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::obligation::collateral(arg0, v0)
            } else {
                0
            }
        };
        0x2::math::min(0x1::fixed_point32::divide_u64(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg2, v0)), 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::div(v1, 0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::price::get_price(arg3, v0, arg4))), v4), 0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::obligation::collateral(arg0, v0))
    }

    // decompiled from Move bytecode v7
}

