module 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::exotic_kernels {
    public fun deepbook_cetus_bluefin_base_funded_v1<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T3>, arg7: u64, arg8: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, u64, u64, u64, u64, u64) {
        let v0 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::flash_loan_base<T1, T0>(arg1, arg7, arg17);
        let (v1, v2, v3, v4, v5, v6) = route_deepbook_cetus_bluefin<T1, T2, T3>(arg0, arg2, arg3, arg4, arg5, arg6, 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::take_all_balance_a<T1, T1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(&mut v0), arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg16, arg17);
        let v7 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::repay_loan_base_guarded_v2<T1, T0>(arg1, v1, v0, arg15, arg17);
        (v7, v2, v3, v4, v5, v6, 0x2::balance::value<T1>(&v7))
    }

    public fun deepbook_cetus_bluefin_quote_funded_v1<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T3>, arg7: u64, arg8: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, u64, u64, u64, u64, u64) {
        let v0 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::flash_loan_quote<T0, T1>(arg1, arg7, arg17);
        let (v1, v2, v3, v4, v5, v6) = route_deepbook_cetus_bluefin<T1, T2, T3>(arg0, arg2, arg3, arg4, arg5, arg6, 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::take_all_balance_a<T1, T1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(&mut v0), arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg16, arg17);
        let v7 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::repay_loan_quote_guarded_v2<T0, T1>(arg1, v1, v0, arg15, arg17);
        (v7, v2, v3, v4, v5, v6, 0x2::balance::value<T1>(&v7))
    }

    fun route_deepbook_cetus_bluefin<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg6: 0x2::balance::Balance<T0>, arg7: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, u64, u64, u64, u64) {
        let (v0, v1, v2, v3, v4) = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::deepbook_base_to_quote_guarded_v5<T0, T1>(arg0, arg1, arg6, arg7, arg8, arg9, arg10, arg14, arg15);
        let v5 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::swap_cetus_a_b<T1, T2>(arg0, arg2, arg3, v0, arg15);
        let v6 = 0x2::balance::value<T2>(&v5);
        assert!(v6 >= arg11, 300);
        let v7 = 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::router::bf_b<T0, T2>(arg0, arg4, arg5, v5, arg15);
        assert!(0x2::balance::value<T0>(&v7) >= arg12, 301);
        0x2::balance::join<T0>(&mut v7, v1);
        let v8 = 0x2::balance::value<T0>(&v7);
        assert!(v8 >= arg13, 302);
        (v7, v2, v3, v4, v6, v8)
    }

    // decompiled from Move bytecode v7
}

