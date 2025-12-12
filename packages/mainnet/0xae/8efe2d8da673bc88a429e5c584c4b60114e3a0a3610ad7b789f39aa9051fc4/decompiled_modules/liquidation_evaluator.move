module 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::liquidation_evaluator {
    fun calc_liq_exchange_rate<T0, T1>(arg0: &0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::Market, arg1: &0x2dc52442a27e2f2b361663c00ab56ce6da272a8f1427a1c15bf77429f8399f0a::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0xa5e8e2f789e62771d342ec92fd6597f8f5b3c68193f1ac46f4c4b12cd8b4a63f::x_oracle::XOracle, arg3: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x1::type_name::get<T0>();
        0x16576d795808741f31be9f519cacea3779c999f585ed291c4d301b99f5eaf1cd::fixed_point32_empower::div(0x16576d795808741f31be9f519cacea3779c999f585ed291c4d301b99f5eaf1cd::fixed_point32_empower::mul(0x1::fixed_point32::create_from_rational(0x2::math::pow(10, 0x2dc52442a27e2f2b361663c00ab56ce6da272a8f1427a1c15bf77429f8399f0a::coin_decimals_registry::decimals(arg1, v0)), 0x2::math::pow(10, 0x2dc52442a27e2f2b361663c00ab56ce6da272a8f1427a1c15bf77429f8399f0a::coin_decimals_registry::decimals(arg1, v1))), 0x16576d795808741f31be9f519cacea3779c999f585ed291c4d301b99f5eaf1cd::fixed_point32_empower::div(0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::price::get_price(arg2, v1, arg3), 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::price::get_price(arg2, v0, arg3))), 0x16576d795808741f31be9f519cacea3779c999f585ed291c4d301b99f5eaf1cd::fixed_point32_empower::sub(0x16576d795808741f31be9f519cacea3779c999f585ed291c4d301b99f5eaf1cd::fixed_point32_empower::from_u64(1), 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::risk_model::liq_discount(0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::risk_model(arg0, v0))))
    }

    public fun liquidation_amounts<T0, T1>(arg0: &0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::Obligation, arg1: &0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::Market, arg2: &0x2dc52442a27e2f2b361663c00ab56ce6da272a8f1427a1c15bf77429f8399f0a::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: &0xa5e8e2f789e62771d342ec92fd6597f8f5b3c68193f1ac46f4c4b12cd8b4a63f::x_oracle::XOracle, arg5: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1) = max_liquidation_amounts<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        if (v1 == 0) {
            return (0, 0, 0)
        };
        let (v2, v3) = if (arg3 >= v0) {
            (v0, v1)
        } else {
            (arg3, 0x1::fixed_point32::multiply_u64(arg3, calc_liq_exchange_rate<T0, T1>(arg1, arg2, arg4, arg5)))
        };
        let v4 = 0x1::fixed_point32::multiply_u64(v2, 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::risk_model::liq_revenue_factor(0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::risk_model(arg1, 0x1::type_name::get<T1>())));
        (v2 - v4, v4, v3)
    }

    public fun max_liquidation_amounts<T0, T1>(arg0: &0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::Obligation, arg1: &0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::Market, arg2: &0x2dc52442a27e2f2b361663c00ab56ce6da272a8f1427a1c15bf77429f8399f0a::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xa5e8e2f789e62771d342ec92fd6597f8f5b3c68193f1ac46f4c4b12cd8b4a63f::x_oracle::XOracle, arg4: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::risk_model(arg1, v0);
        let v2 = 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::risk_model::liq_factor(v1);
        let v3 = 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4);
        let v4 = 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::debt_value::debts_value_usd(arg0, arg2, arg3, arg4);
        if (!0x16576d795808741f31be9f519cacea3779c999f585ed291c4d301b99f5eaf1cd::fixed_point32_empower::gt(v4, v3)) {
            return (0, 0)
        };
        let v5 = 0x2::math::min(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x2dc52442a27e2f2b361663c00ab56ce6da272a8f1427a1c15bf77429f8399f0a::coin_decimals_registry::decimals(arg2, v0)), 0x16576d795808741f31be9f519cacea3779c999f585ed291c4d301b99f5eaf1cd::fixed_point32_empower::div(0x16576d795808741f31be9f519cacea3779c999f585ed291c4d301b99f5eaf1cd::fixed_point32_empower::div(0x16576d795808741f31be9f519cacea3779c999f585ed291c4d301b99f5eaf1cd::fixed_point32_empower::sub(v4, v3), 0x16576d795808741f31be9f519cacea3779c999f585ed291c4d301b99f5eaf1cd::fixed_point32_empower::sub(0x16576d795808741f31be9f519cacea3779c999f585ed291c4d301b99f5eaf1cd::fixed_point32_empower::sub(0x16576d795808741f31be9f519cacea3779c999f585ed291c4d301b99f5eaf1cd::fixed_point32_empower::from_u64(1), 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::risk_model::liq_penalty(v1)), v2)), 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::price::get_price(arg3, v0, arg4))), 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::collateral(arg0, v0));
        let v6 = calc_liq_exchange_rate<T0, T1>(arg1, arg2, arg3, arg4);
        let v7 = 0x1::fixed_point32::divide_u64(v5, v6);
        let (v8, _, _) = 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::obligation::debt(arg0, 0x1::type_name::get<T0>());
        if (v7 <= v8) {
            (v7, v5)
        } else {
            (v8, 0x1::fixed_point32::multiply_u64(v8, v6))
        }
    }

    // decompiled from Move bytecode v6
}

