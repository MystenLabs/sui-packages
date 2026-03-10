module 0x76213a95c66676f89a51c8adcec5a9a732974eebd6f8edb30f1563c91830c951::bluefin_only {
    public fun liquidate_c2d<T0, T1, T2>(arg0: &0x76213a95c66676f89a51c8adcec5a9a732974eebd6f8edb30f1563c91830c951::liquidator::Liquidator, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg3: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::ProtocolApp, arg4: &mut 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market::Market<T0>, arg5: 0x2::object::ID, arg6: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0xf4b6a35a90a54d9758c06cf304ef93534fc37746ab0eff62bcae6bf272e50e83::x_oracle::XOracle, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x76213a95c66676f89a51c8adcec5a9a732974eebd6f8edb30f1563c91830c951::liquidator::ensure_caller_whitelisted(arg0, 0x2::tx_context::sender(arg10));
        let (v0, v1) = liquidate_with_bluefin_c2d<T0, T1, T2>(0x76213a95c66676f89a51c8adcec5a9a732974eebd6f8edb30f1563c91830c951::liquidator::borrow_package_caller_cap(arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        0x76213a95c66676f89a51c8adcec5a9a732974eebd6f8edb30f1563c91830c951::liquidator::transfer_to_recipient<T2>(arg0, v0);
        0x76213a95c66676f89a51c8adcec5a9a732974eebd6f8edb30f1563c91830c951::liquidator::transfer_to_recipient<T1>(arg0, v1);
    }

    public fun liquidate_d2c<T0, T1, T2>(arg0: &0x76213a95c66676f89a51c8adcec5a9a732974eebd6f8edb30f1563c91830c951::liquidator::Liquidator, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg3: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::ProtocolApp, arg4: &mut 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market::Market<T0>, arg5: 0x2::object::ID, arg6: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0xf4b6a35a90a54d9758c06cf304ef93534fc37746ab0eff62bcae6bf272e50e83::x_oracle::XOracle, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x76213a95c66676f89a51c8adcec5a9a732974eebd6f8edb30f1563c91830c951::liquidator::ensure_caller_whitelisted(arg0, 0x2::tx_context::sender(arg10));
        let (v0, v1) = liquidate_with_bluefin_d2c<T0, T1, T2>(0x76213a95c66676f89a51c8adcec5a9a732974eebd6f8edb30f1563c91830c951::liquidator::borrow_package_caller_cap(arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        0x76213a95c66676f89a51c8adcec5a9a732974eebd6f8edb30f1563c91830c951::liquidator::transfer_to_recipient<T2>(arg0, v0);
        0x76213a95c66676f89a51c8adcec5a9a732974eebd6f8edb30f1563c91830c951::liquidator::transfer_to_recipient<T1>(arg0, v1);
    }

    fun liquidate_with_bluefin_c2d<T0, T1, T2>(arg0: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::PackageCallerCap, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg3: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::ProtocolApp, arg4: &mut 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market::Market<T0>, arg5: 0x2::object::ID, arg6: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0xf4b6a35a90a54d9758c06cf304ef93534fc37746ab0eff62bcae6bf272e50e83::x_oracle::XOracle, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T1>(arg9, arg1, arg2, true, false, arg8, 4295048017);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v0);
        let (v4, v5) = 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::liquidate::liquidate_as_coin<T0, T1, T2>(arg3, arg0, arg5, arg4, 0x2::coin::from_balance<T1>(v1, arg10), arg6, arg7, arg9, arg10);
        let v6 = v4;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T1>(arg1, arg2, 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut v6, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T1>(&v3), arg10)), 0x2::balance::zero<T1>(), v3);
        (v6, v5)
    }

    fun liquidate_with_bluefin_d2c<T0, T1, T2>(arg0: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::PackageCallerCap, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg3: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::ProtocolApp, arg4: &mut 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market::Market<T0>, arg5: 0x2::object::ID, arg6: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0xf4b6a35a90a54d9758c06cf304ef93534fc37746ab0eff62bcae6bf272e50e83::x_oracle::XOracle, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T2>(arg9, arg1, arg2, false, false, arg8, 79226673515401279992447579054);
        let v3 = v2;
        0x2::balance::destroy_zero<T2>(v1);
        let (v4, v5) = 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::liquidate::liquidate_as_coin<T0, T1, T2>(arg3, arg0, arg5, arg4, 0x2::coin::from_balance<T1>(v0, arg10), arg6, arg7, arg9, arg10);
        let v6 = v4;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T2>(arg1, arg2, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut v6, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T2>(&v3), arg10)), v3);
        (v6, v5)
    }

    // decompiled from Move bytecode v6
}

