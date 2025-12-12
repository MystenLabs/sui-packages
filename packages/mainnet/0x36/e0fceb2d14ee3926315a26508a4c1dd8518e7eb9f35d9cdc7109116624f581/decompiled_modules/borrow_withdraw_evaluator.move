module 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::borrow_withdraw_evaluator {
    public fun available_borrow_amount_in_usd(arg0: &0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::obligation::Obligation, arg1: &0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::market::Market, arg2: &0x2eb052455f68f40bef97c5f858769d45cfe664c4cb7c4db58bc9aab1b1e0abf6::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x2c9820fb02050a7ce492f9ffb0c2332d91a1a4e12ea229e569c95cceab7f702::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::collateral_value::collaterals_value_usd_for_borrow(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::debt_value::debts_value_usd(arg0, arg2, arg3, arg4);
        if (0xd8fabdb51dd60097fe6c582f62b82404596b1f3a5081a18bbd47118ea1ba863f::fixed_point32_empower::gt(v0, v1)) {
            0xd8fabdb51dd60097fe6c582f62b82404596b1f3a5081a18bbd47118ea1ba863f::fixed_point32_empower::sub(v0, v1)
        } else {
            0xd8fabdb51dd60097fe6c582f62b82404596b1f3a5081a18bbd47118ea1ba863f::fixed_point32_empower::zero()
        }
    }

    public fun max_borrow_amount<T0>(arg0: &0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::obligation::Obligation, arg1: &0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::market::Market, arg2: &0x2eb052455f68f40bef97c5f858769d45cfe664c4cb7c4db58bc9aab1b1e0abf6::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x2c9820fb02050a7ce492f9ffb0c2332d91a1a4e12ea229e569c95cceab7f702::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        if (0xd8fabdb51dd60097fe6c582f62b82404596b1f3a5081a18bbd47118ea1ba863f::fixed_point32_empower::gt(v0, 0xd8fabdb51dd60097fe6c582f62b82404596b1f3a5081a18bbd47118ea1ba863f::fixed_point32_empower::zero())) {
            let v2 = 0x1::type_name::get<T0>();
            0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x2eb052455f68f40bef97c5f858769d45cfe664c4cb7c4db58bc9aab1b1e0abf6::coin_decimals_registry::decimals(arg2, v2)), 0xd8fabdb51dd60097fe6c582f62b82404596b1f3a5081a18bbd47118ea1ba863f::fixed_point32_empower::div(v0, 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::price::get_price(arg3, v2, arg4)))
        } else {
            0
        }
    }

    public fun max_withdraw_amount<T0>(arg0: &0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::obligation::Obligation, arg1: &0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::market::Market, arg2: &0x2eb052455f68f40bef97c5f858769d45cfe664c4cb7c4db58bc9aab1b1e0abf6::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x2c9820fb02050a7ce492f9ffb0c2332d91a1a4e12ea229e569c95cceab7f702::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x1::fixed_point32::is_zero(0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::debt_value::debts_value_usd(arg0, arg2, arg3, arg4))) {
            return 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::obligation::collateral(arg0, v0)
        };
        let v1 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        let v2 = 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::risk_model::collateral_factor(0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::market::risk_model(arg1, v0));
        if (0x1::fixed_point32::is_zero(v2)) {
            return if (!0x1::fixed_point32::is_zero(v1)) {
                0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::obligation::collateral(arg0, v0)
            } else {
                0
            }
        };
        0x2::math::min(0x1::fixed_point32::divide_u64(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x2eb052455f68f40bef97c5f858769d45cfe664c4cb7c4db58bc9aab1b1e0abf6::coin_decimals_registry::decimals(arg2, v0)), 0xd8fabdb51dd60097fe6c582f62b82404596b1f3a5081a18bbd47118ea1ba863f::fixed_point32_empower::div(v1, 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::price::get_price(arg3, v0, arg4))), v2), 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::obligation::collateral(arg0, v0))
    }

    // decompiled from Move bytecode v6
}

