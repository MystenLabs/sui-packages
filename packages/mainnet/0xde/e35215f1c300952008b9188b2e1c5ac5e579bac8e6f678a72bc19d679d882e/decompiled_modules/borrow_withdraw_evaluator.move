module 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::borrow_withdraw_evaluator {
    public fun available_borrow_amount_in_usd(arg0: &0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::Obligation, arg1: &0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market::Market, arg2: &0xed4cd0afbc14d8961499a2523961e371d72b6a12abdd4a0da2d39cd1ca441472::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x58908fcf6fe6711a482ab9dc4000d5c9f2ab753c34298843c2a96a534f7fae1d::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::collateral_value::collaterals_value_usd_for_borrow(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::debt_value::debts_value_usd(arg0, arg2, arg3, arg4);
        if (0x8a0d9d6a55c999c37f153a7e282ca4438d00e411bd5b92ef0fad87391c78c08d::fixed_point32_empower::gt(v0, v1)) {
            0x8a0d9d6a55c999c37f153a7e282ca4438d00e411bd5b92ef0fad87391c78c08d::fixed_point32_empower::sub(v0, v1)
        } else {
            0x8a0d9d6a55c999c37f153a7e282ca4438d00e411bd5b92ef0fad87391c78c08d::fixed_point32_empower::zero()
        }
    }

    public fun max_borrow_amount<T0>(arg0: &0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::Obligation, arg1: &0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market::Market, arg2: &0xed4cd0afbc14d8961499a2523961e371d72b6a12abdd4a0da2d39cd1ca441472::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x58908fcf6fe6711a482ab9dc4000d5c9f2ab753c34298843c2a96a534f7fae1d::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        if (0x8a0d9d6a55c999c37f153a7e282ca4438d00e411bd5b92ef0fad87391c78c08d::fixed_point32_empower::gt(v0, 0x8a0d9d6a55c999c37f153a7e282ca4438d00e411bd5b92ef0fad87391c78c08d::fixed_point32_empower::zero())) {
            let v2 = 0x1::type_name::get<T0>();
            0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0xed4cd0afbc14d8961499a2523961e371d72b6a12abdd4a0da2d39cd1ca441472::coin_decimals_registry::decimals(arg2, v2)), 0x8a0d9d6a55c999c37f153a7e282ca4438d00e411bd5b92ef0fad87391c78c08d::fixed_point32_empower::div(v0, 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::price::get_price(arg3, v2, arg4)))
        } else {
            0
        }
    }

    public fun max_withdraw_amount<T0>(arg0: &0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::Obligation, arg1: &0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market::Market, arg2: &0xed4cd0afbc14d8961499a2523961e371d72b6a12abdd4a0da2d39cd1ca441472::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x58908fcf6fe6711a482ab9dc4000d5c9f2ab753c34298843c2a96a534f7fae1d::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x1::fixed_point32::is_zero(0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::debt_value::debts_value_usd(arg0, arg2, arg3, arg4))) {
            return 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::collateral(arg0, v0)
        };
        let v1 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        let v2 = 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::risk_model::collateral_factor(0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::market::risk_model(arg1, v0));
        if (0x1::fixed_point32::is_zero(v2)) {
            return if (!0x1::fixed_point32::is_zero(v1)) {
                0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::collateral(arg0, v0)
            } else {
                0
            }
        };
        0x2::math::min(0x1::fixed_point32::divide_u64(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0xed4cd0afbc14d8961499a2523961e371d72b6a12abdd4a0da2d39cd1ca441472::coin_decimals_registry::decimals(arg2, v0)), 0x8a0d9d6a55c999c37f153a7e282ca4438d00e411bd5b92ef0fad87391c78c08d::fixed_point32_empower::div(v1, 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::price::get_price(arg3, v0, arg4))), v2), 0xdee35215f1c300952008b9188b2e1c5ac5e579bac8e6f678a72bc19d679d882e::obligation::collateral(arg0, v0))
    }

    // decompiled from Move bytecode v6
}

