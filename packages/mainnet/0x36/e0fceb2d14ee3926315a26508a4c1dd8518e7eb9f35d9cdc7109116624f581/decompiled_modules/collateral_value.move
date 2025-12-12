module 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::collateral_value {
    public fun collaterals_value_usd_for_borrow(arg0: &0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::obligation::Obligation, arg1: &0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::market::Market, arg2: &0x2eb052455f68f40bef97c5f858769d45cfe664c4cb7c4db58bc9aab1b1e0abf6::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x2c9820fb02050a7ce492f9ffb0c2332d91a1a4e12ea229e569c95cceab7f702::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::obligation::collateral_types(arg0);
        let v1 = 0xd8fabdb51dd60097fe6c582f62b82404596b1f3a5081a18bbd47118ea1ba863f::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0xd8fabdb51dd60097fe6c582f62b82404596b1f3a5081a18bbd47118ea1ba863f::fixed_point32_empower::add(v1, 0xd8fabdb51dd60097fe6c582f62b82404596b1f3a5081a18bbd47118ea1ba863f::fixed_point32_empower::mul(0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::value_calculator::usd_value(0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::price::get_price(arg3, v3, arg4), 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::obligation::collateral(arg0, v3), 0x2eb052455f68f40bef97c5f858769d45cfe664c4cb7c4db58bc9aab1b1e0abf6::coin_decimals_registry::decimals(arg2, v3)), 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::risk_model::collateral_factor(0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    public fun collaterals_value_usd_for_liquidation(arg0: &0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::obligation::Obligation, arg1: &0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::market::Market, arg2: &0x2eb052455f68f40bef97c5f858769d45cfe664c4cb7c4db58bc9aab1b1e0abf6::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x2c9820fb02050a7ce492f9ffb0c2332d91a1a4e12ea229e569c95cceab7f702::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::obligation::collateral_types(arg0);
        let v1 = 0xd8fabdb51dd60097fe6c582f62b82404596b1f3a5081a18bbd47118ea1ba863f::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0xd8fabdb51dd60097fe6c582f62b82404596b1f3a5081a18bbd47118ea1ba863f::fixed_point32_empower::add(v1, 0xd8fabdb51dd60097fe6c582f62b82404596b1f3a5081a18bbd47118ea1ba863f::fixed_point32_empower::mul(0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::value_calculator::usd_value(0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::price::get_price(arg3, v3, arg4), 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::obligation::collateral(arg0, v3), 0x2eb052455f68f40bef97c5f858769d45cfe664c4cb7c4db58bc9aab1b1e0abf6::coin_decimals_registry::decimals(arg2, v3)), 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::risk_model::liq_factor(0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

