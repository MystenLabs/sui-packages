module 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::liquidation_evaluator {
    fun calc_liq_exchange_rate<T0, T1>(arg0: &0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::Market, arg1: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0xe2785270b2e6179e68204dd5901a43f9a0e1c566baf656cad705d45a419c4d3a::x_oracle::XOracle, arg3: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x1::type_name::get<T0>();
        0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::div(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::mul(0x1::fixed_point32::create_from_rational(0x2::math::pow(10, 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg1, v0)), 0x2::math::pow(10, 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg1, v1))), 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::div(0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::price::get_price(arg2, v1, arg3), 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::price::get_price(arg2, v0, arg3))), 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::sub(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::from_u64(1), 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::risk_model::liq_discount(0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::risk_model(arg0, v0))))
    }

    public fun calculate_liquidation_amounts<T0, T1>(arg0: &0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::Obligation, arg1: &0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::Market, arg2: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xe2785270b2e6179e68204dd5901a43f9a0e1c566baf656cad705d45a419c4d3a::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: u64) : (u64, u64, u64) {
        let v0 = 0x2::math::min(arg5, max_repay_amount<T0>(arg0, arg1, arg2, arg3, arg4));
        assert!(v0 > 0, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::error::unable_to_liquidate_error());
        let (v1, v2) = debt_to_collateral_amount<T0, T1>(arg1, arg2, arg3, v0, arg4);
        let v3 = 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::collateral(arg0, 0x1::type_name::get<T1>());
        let v4 = v1 + v2;
        let (v5, v6, v7) = if (v4 > v3) {
            let v8 = 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(v3, v1, v4);
            (0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(v0, v3, v4), v8, v3 - v8)
        } else {
            (v0, v1, v2)
        };
        assert!(v6 > 0, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::error::unable_to_liquidate_error());
        assert!(v5 > 0, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::error::unable_to_liquidate_error());
        (v5, v6, v7)
    }

    public fun debt_to_collateral_amount<T0, T1>(arg0: &0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::Market, arg1: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0xe2785270b2e6179e68204dd5901a43f9a0e1c566baf656cad705d45a419c4d3a::x_oracle::XOracle, arg3: u64, arg4: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::risk_model(arg0, v0);
        let v3 = 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::mul(0x1::fixed_point32::create_from_rational(0x2::math::pow(10, 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg1, v0)), 0x2::math::pow(10, 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg1, v1))), 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::div(0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::price::get_price(arg2, v1, arg4), 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::price::get_price(arg2, v0, arg4)));
        (0x1::fixed_point32::multiply_u64(arg3, 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::mul(v3, 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::add(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::from_u64(1), 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::risk_model::liq_discount(v2)))), 0x1::fixed_point32::multiply_u64(arg3, 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::mul(v3, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::risk_model::liq_revenue_factor(v2))))
    }

    public fun liquidation_amounts<T0, T1>(arg0: &0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::Obligation, arg1: &0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::Market, arg2: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: &0xe2785270b2e6179e68204dd5901a43f9a0e1c566baf656cad705d45a419c4d3a::x_oracle::XOracle, arg5: &0x2::clock::Clock) : (u64, u64, u64) {
        abort 0
    }

    public fun max_liquidation_amounts<T0, T1>(arg0: &0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::Obligation, arg1: &0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::Market, arg2: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xe2785270b2e6179e68204dd5901a43f9a0e1c566baf656cad705d45a419c4d3a::x_oracle::XOracle, arg4: &0x2::clock::Clock) : (u64, u64) {
        abort 0
    }

    public fun max_repay_amount<T0>(arg0: &0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::Obligation, arg1: &0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market::Market, arg2: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xe2785270b2e6179e68204dd5901a43f9a0e1c566baf656cad705d45a419c4d3a::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (!0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::gt(0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4), 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4))) {
            return 0
        };
        let (v1, _) = 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::debt(arg0, v0);
        let v3 = 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::debt_value::debts_value_usd(arg0, arg2, arg3, arg4);
        if (!0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::gt(v3, 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::from_u64(10))) {
            return v1
        };
        0x2::math::min(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(0x1::fixed_point32::get_raw_value(v3), 0x2::math::pow(10, 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg2, v0)), 5 * 0x1::fixed_point32::get_raw_value(0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::price::get_price(arg3, v0, arg4))), v1)
    }

    // decompiled from Move bytecode v6
}

