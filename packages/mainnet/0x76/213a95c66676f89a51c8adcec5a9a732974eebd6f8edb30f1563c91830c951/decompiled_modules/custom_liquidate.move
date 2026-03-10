module 0x76213a95c66676f89a51c8adcec5a9a732974eebd6f8edb30f1563c91830c951::custom_liquidate {
    struct CustomLiquidateReceipt<phantom T0> {
        min_collateral_profit: u64,
    }

    public fun custom_liquidate<T0, T1, T2>(arg0: &0x76213a95c66676f89a51c8adcec5a9a732974eebd6f8edb30f1563c91830c951::liquidator::Liquidator, arg1: 0x2::coin::Coin<T2>, arg2: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::ProtocolApp, arg3: 0x2::object::ID, arg4: &mut 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market::Market<T0>, arg5: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0xf4b6a35a90a54d9758c06cf304ef93534fc37746ab0eff62bcae6bf272e50e83::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, CustomLiquidateReceipt<T1>) {
        0x76213a95c66676f89a51c8adcec5a9a732974eebd6f8edb30f1563c91830c951::liquidator::ensure_caller_whitelisted(arg0, 0x2::tx_context::sender(arg8));
        let (v0, v1) = 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::liquidate::liquidate_as_coin<T0, T2, T1>(arg2, 0x76213a95c66676f89a51c8adcec5a9a732974eebd6f8edb30f1563c91830c951::liquidator::borrow_package_caller_cap(arg0), arg3, arg4, arg1, arg5, arg6, arg7, arg8);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::floor(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::div(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::mul_u64(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::div_u64(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::mul_u64(0xf4b6a35a90a54d9758c06cf304ef93534fc37746ab0eff62bcae6bf272e50e83::user_oracle::get_price(arg6, 0x1::type_name::with_defining_ids<T2>(), 0xf4b6a35a90a54d9758c06cf304ef93534fc37746ab0eff62bcae6bf272e50e83::x_oracle::usd(), arg7), 0x2::coin::value<T2>(&arg1) - 0x2::coin::value<T2>(&v2)), 0x1::u64::pow(10, 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::coin_decimals_registry::decimals(arg5, 0x1::type_name::with_defining_ids<T2>()))), 0x1::u64::pow(10, 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::coin_decimals_registry::decimals(arg5, 0x1::type_name::with_defining_ids<T1>()))), 0xf4b6a35a90a54d9758c06cf304ef93534fc37746ab0eff62bcae6bf272e50e83::user_oracle::get_price(arg6, 0x1::type_name::with_defining_ids<T1>(), 0xf4b6a35a90a54d9758c06cf304ef93534fc37746ab0eff62bcae6bf272e50e83::x_oracle::usd(), arg7)));
        assert!(0x2::coin::value<T1>(&v3) >= v4, 0x76213a95c66676f89a51c8adcec5a9a732974eebd6f8edb30f1563c91830c951::error::insufficient_collateral());
        let v5 = CustomLiquidateReceipt<T1>{min_collateral_profit: (0x2::coin::value<T1>(&v3) - v4) * ((10000 - 0x76213a95c66676f89a51c8adcec5a9a732974eebd6f8edb30f1563c91830c951::liquidator::slippage_tolerance(arg0)) as u64) / (10000 as u64)};
        (v3, v2, v5)
    }

    public fun min_collateral_profit<T0>(arg0: &CustomLiquidateReceipt<T0>) : u64 {
        arg0.min_collateral_profit
    }

    public fun verify_custom_liquidate<T0>(arg0: &0x76213a95c66676f89a51c8adcec5a9a732974eebd6f8edb30f1563c91830c951::liquidator::Liquidator, arg1: CustomLiquidateReceipt<T0>, arg2: 0x2::coin::Coin<T0>) {
        let CustomLiquidateReceipt { min_collateral_profit: v0 } = arg1;
        assert!(0x2::coin::value<T0>(&arg2) >= v0, 0x76213a95c66676f89a51c8adcec5a9a732974eebd6f8edb30f1563c91830c951::error::profit_below_minimum());
        0x76213a95c66676f89a51c8adcec5a9a732974eebd6f8edb30f1563c91830c951::liquidator::transfer_to_recipient<T0>(arg0, arg2);
    }

    // decompiled from Move bytecode v6
}

