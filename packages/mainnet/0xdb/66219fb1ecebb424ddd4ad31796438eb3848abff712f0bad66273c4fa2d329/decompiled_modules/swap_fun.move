module 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::swap_fun {
    public(friend) fun bluefin<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::Vault<T0>, arg3: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::Vault<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) {
        let (v0, v1) = if (arg4) {
            (0x2::balance::split<T0>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<T0>(arg2), arg6), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<T1>(arg3), arg6))
        };
        let v2 = if (arg4) {
            4295048016 + 1
        } else {
            79226673515401279992447579055 - 1
        };
        let (v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg8, arg1, arg0, v0, v1, arg4, arg5, arg6, arg7, v2);
        0x2::balance::join<T0>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<T0>(arg2), v3);
        0x2::balance::join<T1>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<T1>(arg3), v4);
    }

    public(friend) fun bluefin_flash_swap<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::Vault<T0>, arg3: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::Vault<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) {
        let v0 = if (arg4) {
            4295048016 + 1
        } else {
            79226673515401279992447579055 - 1
        };
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg8, arg1, arg0, arg4, arg5, arg6, v0);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let v7 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v4);
        if (arg5) {
            assert!(v7 <= arg6, 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::error::invalid_pay_amount());
            let v8 = if (arg4) {
                0x2::balance::value<T1>(&v5)
            } else {
                0x2::balance::value<T0>(&v6)
            };
            assert!(v8 >= arg7, 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::error::slippage_too_little_output());
        } else {
            assert!(v7 <= arg7, 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::error::slippage_too_much_input());
        };
        let (v9, v10) = if (arg4) {
            (0x2::balance::zero<T1>(), 0x2::balance::split<T0>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<T0>(arg2), v7))
        } else {
            (0x2::balance::split<T1>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<T1>(arg3), v7), 0x2::balance::zero<T0>())
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg0, v10, v9, v4);
        0x2::balance::join<T0>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<T0>(arg2), v6);
        0x2::balance::join<T1>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<T1>(arg3), v5);
    }

    public(friend) fun cetus<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::Vault<T0>, arg3: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::Vault<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) {
        let v0 = if (arg4) {
            4295048016 + 1
        } else {
            79226673515401279992447579055 - 1
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg0, arg4, arg5, arg6, v0, arg8);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4);
        if (arg5) {
            assert!(v7 <= arg6, 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::error::invalid_pay_amount());
            let v8 = if (arg4) {
                0x2::balance::value<T1>(&v5)
            } else {
                0x2::balance::value<T0>(&v6)
            };
            assert!(v8 >= arg7, 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::error::slippage_too_little_output());
        } else {
            assert!(v7 <= arg7, 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::error::slippage_too_much_input());
        };
        let (v9, v10) = if (arg4) {
            (0x2::balance::split<T0>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<T0>(arg2), v7), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<T1>(arg3), v7))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg0, v9, v10, v4);
        0x2::balance::join<T0>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<T0>(arg2), v6);
        0x2::balance::join<T1>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<T1>(arg3), v5);
    }

    public(friend) fun deepbook<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::Vault<T0>, arg2: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::Vault<T1>, arg3: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::Vault<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        if (arg5) {
            let v0 = if (arg4) {
                let (_, _, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg0, arg6, arg8);
                0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3), v3), arg9)
            } else {
                0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg9)
            };
            let (v4, v5, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<T0>(arg1), arg6), arg9), v0, 0, arg8, arg9);
            let v7 = v5;
            let v8 = v4;
            let v9 = arg6 - 0x2::coin::value<T0>(&v8);
            assert!(v9 > 0, 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::error::insufficient_liquidity());
            assert!((0x2::coin::value<T1>(&v7) as u128) * (arg6 as u128) >= (arg7 as u128) * (v9 as u128), 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::error::slippage_too_little_output());
            0x2::balance::join<T0>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<T0>(arg1), 0x2::coin::into_balance<T0>(v8));
            0x2::balance::join<T1>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<T1>(arg2), 0x2::coin::into_balance<T1>(v7));
            if (arg4) {
                0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3), 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v6));
            } else {
                0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v6);
            };
        } else {
            let v10 = if (arg4) {
                let (_, _, v13) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T0, T1>(arg0, arg6, arg8);
                0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3), v13), arg9)
            } else {
                0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg9)
            };
            let (v14, v15, v16) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<T1>(arg2), arg6), arg9), v10, 0, arg8, arg9);
            let v17 = v15;
            let v18 = v14;
            let v19 = arg6 - 0x2::coin::value<T1>(&v17);
            assert!(v19 > 0, 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::error::insufficient_liquidity());
            assert!((0x2::coin::value<T0>(&v18) as u128) * (arg6 as u128) >= (arg7 as u128) * (v19 as u128), 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::error::slippage_too_little_output());
            0x2::balance::join<T0>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<T0>(arg1), 0x2::coin::into_balance<T0>(v18));
            0x2::balance::join<T1>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<T1>(arg2), 0x2::coin::into_balance<T1>(v17));
            if (arg4) {
                0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3), 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v16));
            } else {
                0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v16);
            };
        };
    }

    public(friend) fun mmt<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::Vault<T0>, arg3: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::Vault<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        let v0 = if (arg4) {
            4295048016 + 1
        } else {
            79226673515401279992447579055 - 1
        };
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, arg4, arg5, arg6, v0, arg8, arg1, arg9);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let (v7, v8) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v4);
        let v9 = if (arg4) {
            v7
        } else {
            v8
        };
        if (arg5) {
            assert!(v9 <= arg6, 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::error::invalid_pay_amount());
            let v10 = if (arg4) {
                0x2::balance::value<T1>(&v5)
            } else {
                0x2::balance::value<T0>(&v6)
            };
            assert!(v10 >= arg7, 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::error::slippage_too_little_output());
        } else {
            assert!(v9 <= arg7, 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::error::slippage_too_much_input());
        };
        let (v11, v12) = if (arg4) {
            (0x2::balance::split<T0>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<T0>(arg2), v9), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<T1>(arg3), v9))
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v4, v11, v12, arg1, arg9);
        0x2::balance::join<T0>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<T0>(arg2), v6);
        0x2::balance::join<T1>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<T1>(arg3), v5);
    }

    public(friend) fun turbos<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::Vault<T0>, arg3: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::Vault<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg4) {
            4295048016 + 1
        } else {
            79226673515401279992447579055 - 1
        };
        let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg9), arg4, (arg6 as u128), arg5, v0, arg8, arg1, arg9);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let (_, _, v9) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<T0, T1>(&v4);
        if (arg5) {
            assert!(v9 <= arg6, 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::error::invalid_pay_amount());
            let v10 = if (arg4) {
                0x2::coin::value<T1>(&v5)
            } else {
                0x2::coin::value<T0>(&v6)
            };
            assert!(v10 >= arg7, 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::error::slippage_too_little_output());
        } else {
            assert!(v9 <= arg7, 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::error::slippage_too_much_input());
        };
        let (v11, v12) = if (arg4) {
            (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<T0>(arg2), v9), arg9), 0x2::coin::zero<T1>(arg9))
        } else {
            (0x2::coin::zero<T0>(arg9), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<T1>(arg3), v9), arg9))
        };
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, v11, v12, v4, arg1);
        0x2::balance::join<T0>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<T0>(arg2), 0x2::coin::into_balance<T0>(v6));
        0x2::balance::join<T1>(0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::borrow_balance_mut<T1>(arg3), 0x2::coin::into_balance<T1>(v5));
    }

    // decompiled from Move bytecode v6
}

