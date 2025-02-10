module 0xb4df14320339f9ef92d1e300e520fe05e4a7e4ecce78daad7c525b65b86316ec::bluefin {
    public fun flash_swap<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: u128, arg3: u128, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>, bool, u64, u64) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg1);
        if (v0 > arg2) {
            let v7 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg1, true, true, 18446744073709551615, arg2);
            if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v7) > 0) {
                let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg0, arg1, true, true, 18446744073709551615, arg2);
                let v11 = v10;
                (v8, v9, 0x1::option::some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(v11), true, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v11), 0)
            } else {
                (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>(), 0x1::option::none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(), true, 0, 0)
            }
        } else if (v0 < arg3) {
            let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg1, false, true, 18446744073709551615, arg3);
            let (v13, v14, v15, v16, v17, v18) = if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v12) > 0) {
                let (v19, v20, v21) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg4, arg0, arg1, false, true, 18446744073709551615, arg3);
                let v22 = v21;
                (false, 0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v22), v19, v20, 0x1::option::some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(v22))
            } else {
                (false, 0, 0, 0x2::balance::zero<T0>(), 0x2::balance::zero<T1>(), 0x1::option::none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>())
            };
            (v16, v17, v18, v13, v14, v15)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>(), 0x1::option::none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(), true, 0, 0)
        }
    }

    public fun repay_flash_swap<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x2::balance::Balance<T0>, arg3: &mut 0x2::balance::Balance<T1>, arg4: 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>, arg5: bool) {
        if (0x1::option::is_some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(&arg4)) {
            let v0 = 0x1::option::extract<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(&mut arg4);
            if (arg5) {
                0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(arg2, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v0)), 0x2::balance::zero<T1>(), v0);
            } else {
                0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(arg3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v0)), v0);
            };
        };
        0x1::option::destroy_none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(arg4);
    }

    public fun handle_initial_balanace<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x2::balance::Balance<T0>, arg3: &mut 0x2::balance::Balance<T1>, arg4: bool, arg5: u64, arg6: &0x2::clock::Clock) : (0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>, bool) {
        if (arg4) {
            let v2 = 0x2::balance::value<T0>(arg2);
            if (v2 >= arg5) {
                if (v2 == arg5) {
                    (0x1::option::none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(), false)
                } else {
                    let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg1, true, true, v2 - arg5, 4295048016);
                    if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v3) == 0) {
                        (0x1::option::none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(), false)
                    } else {
                        let (v4, v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg6, arg0, arg1, true, true, v2 - arg5, 4295048016);
                        0x2::balance::join<T0>(arg2, v4);
                        0x2::balance::join<T1>(arg3, v5);
                        (0x1::option::some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(v6), true)
                    }
                }
            } else {
                let (v7, v8, v9) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg6, arg0, arg1, false, false, arg5 - v2, 79226673515401279992447579055);
                0x2::balance::join<T0>(arg2, v7);
                0x2::balance::join<T1>(arg3, v8);
                (0x1::option::some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(v9), false)
            }
        } else {
            let v10 = 0x2::balance::value<T1>(arg3);
            if (v10 >= arg5) {
                let (v11, v12) = if (v10 == arg5) {
                    (false, 0x1::option::none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>())
                } else {
                    let v13 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg1, false, true, v10 - arg5, 79226673515401279992447579055);
                    let (v14, v15) = if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v13) == 0) {
                        (0x1::option::none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(), false)
                    } else {
                        let (v16, v17, v18) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg6, arg0, arg1, false, true, v10 - arg5, 79226673515401279992447579055);
                        0x2::balance::join<T0>(arg2, v16);
                        0x2::balance::join<T1>(arg3, v17);
                        (0x1::option::some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(v18), false)
                    };
                    (v15, v14)
                };
                (v12, v11)
            } else {
                let (v19, v20, v21) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg6, arg0, arg1, true, false, arg5 - v10, 4295048016);
                0x2::balance::join<T0>(arg2, v19);
                0x2::balance::join<T1>(arg3, v20);
                (0x1::option::some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(v21), true)
            }
        }
    }

    // decompiled from Move bytecode v6
}

