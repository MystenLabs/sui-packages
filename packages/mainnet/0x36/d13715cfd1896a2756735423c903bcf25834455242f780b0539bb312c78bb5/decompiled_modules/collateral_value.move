module 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::collateral_value {
    public fun collaterals_value_usd_for_borrow(arg0: &0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::obligation::Obligation, arg1: &0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::Market, arg2: &0x5eca23353c3cd5e3a57d5d9e7c90358a770d14c2e1ce831731eb8934bb9c571d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::obligation::collateral_types(arg0);
        let v1 = 0x77431d018d2682972dc7e198b08643848774a7007df97aa227704f87f127d74c::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0x77431d018d2682972dc7e198b08643848774a7007df97aa227704f87f127d74c::fixed_point32_empower::add(v1, 0x77431d018d2682972dc7e198b08643848774a7007df97aa227704f87f127d74c::fixed_point32_empower::mul(0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::value_calculator::usd_value(0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::price::get_price(arg3, v3, arg4), 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::obligation::collateral(arg0, v3), 0x5eca23353c3cd5e3a57d5d9e7c90358a770d14c2e1ce831731eb8934bb9c571d::coin_decimals_registry::decimals(arg2, v3)), 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::risk_model::collateral_factor(0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    public fun collaterals_value_usd_for_liquidation(arg0: &0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::obligation::Obligation, arg1: &0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::Market, arg2: &0x5eca23353c3cd5e3a57d5d9e7c90358a770d14c2e1ce831731eb8934bb9c571d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::obligation::collateral_types(arg0);
        let v1 = 0x77431d018d2682972dc7e198b08643848774a7007df97aa227704f87f127d74c::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0x77431d018d2682972dc7e198b08643848774a7007df97aa227704f87f127d74c::fixed_point32_empower::add(v1, 0x77431d018d2682972dc7e198b08643848774a7007df97aa227704f87f127d74c::fixed_point32_empower::mul(0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::value_calculator::usd_value(0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::price::get_price(arg3, v3, arg4), 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::obligation::collateral(arg0, v3), 0x5eca23353c3cd5e3a57d5d9e7c90358a770d14c2e1ce831731eb8934bb9c571d::coin_decimals_registry::decimals(arg2, v3)), 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::risk_model::liq_factor(0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

