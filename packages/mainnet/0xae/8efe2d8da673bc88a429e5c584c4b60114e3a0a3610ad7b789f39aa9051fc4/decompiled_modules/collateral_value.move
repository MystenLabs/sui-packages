module 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::collateral_value {
    public fun collaterals_value_usd_for_borrow(arg0: &0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::Obligation, arg1: &0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::Market, arg2: &0x2dc52442a27e2f2b361663c00ab56ce6da272a8f1427a1c15bf77429f8399f0a::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xa5e8e2f789e62771d342ec92fd6597f8f5b3c68193f1ac46f4c4b12cd8b4a63f::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::collateral_types(arg0);
        let v1 = 0x16576d795808741f31be9f519cacea3779c999f585ed291c4d301b99f5eaf1cd::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0x16576d795808741f31be9f519cacea3779c999f585ed291c4d301b99f5eaf1cd::fixed_point32_empower::add(v1, 0x16576d795808741f31be9f519cacea3779c999f585ed291c4d301b99f5eaf1cd::fixed_point32_empower::mul(0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::value_calculator::usd_value(0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::price::get_price(arg3, v3, arg4), 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::collateral(arg0, v3), 0x2dc52442a27e2f2b361663c00ab56ce6da272a8f1427a1c15bf77429f8399f0a::coin_decimals_registry::decimals(arg2, v3)), 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::risk_model::collateral_factor(0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    public fun collaterals_value_usd_for_liquidation(arg0: &0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::Obligation, arg1: &0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::Market, arg2: &0x2dc52442a27e2f2b361663c00ab56ce6da272a8f1427a1c15bf77429f8399f0a::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xa5e8e2f789e62771d342ec92fd6597f8f5b3c68193f1ac46f4c4b12cd8b4a63f::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::collateral_types(arg0);
        let v1 = 0x16576d795808741f31be9f519cacea3779c999f585ed291c4d301b99f5eaf1cd::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0x16576d795808741f31be9f519cacea3779c999f585ed291c4d301b99f5eaf1cd::fixed_point32_empower::add(v1, 0x16576d795808741f31be9f519cacea3779c999f585ed291c4d301b99f5eaf1cd::fixed_point32_empower::mul(0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::value_calculator::usd_value(0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::price::get_price(arg3, v3, arg4), 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::collateral(arg0, v3), 0x2dc52442a27e2f2b361663c00ab56ce6da272a8f1427a1c15bf77429f8399f0a::coin_decimals_registry::decimals(arg2, v3)), 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::risk_model::liq_factor(0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

