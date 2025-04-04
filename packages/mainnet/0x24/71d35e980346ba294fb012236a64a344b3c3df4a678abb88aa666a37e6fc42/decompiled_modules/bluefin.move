module 0x2471d35e980346ba294fb012236a64a344b3c3df4a678abb88aa666a37e6fc42::bluefin {
    public fun flash_swap<T0, T1>(arg0: &mut 0x2471d35e980346ba294fb012236a64a344b3c3df4a678abb88aa666a37e6fc42::token::TokenData<T0>, arg1: &mut 0x2471d35e980346ba294fb012236a64a344b3c3df4a678abb88aa666a37e6fc42::token::TokenData<T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: u128, arg5: u128, arg6: &0x2::clock::Clock) : (0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>, bool) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg3);
        if (v0 > arg4) {
            let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg3, true, true, 18446744073709551615, arg4);
            if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v3) > 0) {
                let (v4, v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg6, arg2, arg3, true, true, 18446744073709551615, arg4);
                let v7 = v6;
                0x2471d35e980346ba294fb012236a64a344b3c3df4a678abb88aa666a37e6fc42::token::join<T0>(arg0, v4, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v7));
                0x2471d35e980346ba294fb012236a64a344b3c3df4a678abb88aa666a37e6fc42::token::join<T1>(arg1, v5, 0);
                (0x1::option::some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(v7), true)
            } else {
                (0x1::option::none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(), true)
            }
        } else if (v0 < arg5) {
            let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg3, false, true, 18446744073709551615, arg5);
            if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v8) > 0) {
                let (v9, v10, v11) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg6, arg2, arg3, false, true, 18446744073709551615, arg5);
                let v12 = v11;
                0x2471d35e980346ba294fb012236a64a344b3c3df4a678abb88aa666a37e6fc42::token::join<T0>(arg0, v9, 0);
                0x2471d35e980346ba294fb012236a64a344b3c3df4a678abb88aa666a37e6fc42::token::join<T1>(arg1, v10, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v12));
                (0x1::option::some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(v12), false)
            } else {
                (0x1::option::none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(), false)
            }
        } else {
            (0x1::option::none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(), true)
        }
    }

    public fun handle_initial_balanace<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x2471d35e980346ba294fb012236a64a344b3c3df4a678abb88aa666a37e6fc42::token::TokenData<T0>, arg3: &mut 0x2471d35e980346ba294fb012236a64a344b3c3df4a678abb88aa666a37e6fc42::token::TokenData<T1>, arg4: bool, arg5: &0x2::clock::Clock) : (0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>, bool) {
        if (arg4) {
            let v2 = 0x2471d35e980346ba294fb012236a64a344b3c3df4a678abb88aa666a37e6fc42::token::balance_value<T0>(arg2);
            let v3 = 0x2471d35e980346ba294fb012236a64a344b3c3df4a678abb88aa666a37e6fc42::token::debt_value<T0>(arg2);
            if (v2 >= v3) {
                if (v2 == v3) {
                    (0x1::option::none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(), false)
                } else {
                    let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg1, true, true, v2 - v3, 4295048026);
                    if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v4) == 0) {
                        (0x1::option::none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(), false)
                    } else {
                        let (v5, v6, v7) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg5, arg0, arg1, true, true, v2 - v3, 4295048026);
                        let v8 = v7;
                        0x2471d35e980346ba294fb012236a64a344b3c3df4a678abb88aa666a37e6fc42::token::join<T0>(arg2, v5, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v8));
                        0x2471d35e980346ba294fb012236a64a344b3c3df4a678abb88aa666a37e6fc42::token::join<T1>(arg3, v6, 0);
                        (0x1::option::some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(v8), true)
                    }
                }
            } else {
                let v9 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg1, false, false, v3 - v2, 4295048026);
                assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v9) >= v3 - v2, 12);
                let (v10, v11, v12) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg5, arg0, arg1, false, false, v3 - v2, 79226673515401279992447579045);
                let v13 = v12;
                0x2471d35e980346ba294fb012236a64a344b3c3df4a678abb88aa666a37e6fc42::token::join<T0>(arg2, v10, 0);
                0x2471d35e980346ba294fb012236a64a344b3c3df4a678abb88aa666a37e6fc42::token::join<T1>(arg3, v11, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v13));
                (0x1::option::some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(v13), false)
            }
        } else {
            let v14 = 0x2471d35e980346ba294fb012236a64a344b3c3df4a678abb88aa666a37e6fc42::token::balance_value<T1>(arg3);
            let v15 = 0x2471d35e980346ba294fb012236a64a344b3c3df4a678abb88aa666a37e6fc42::token::debt_value<T1>(arg3);
            if (v14 >= v15) {
                let (v16, v17) = if (v14 == v15) {
                    (false, 0x1::option::none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>())
                } else {
                    let v18 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg1, false, true, v14 - v15, 79226673515401279992447579045);
                    let (v19, v20) = if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v18) == 0) {
                        (0x1::option::none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(), false)
                    } else {
                        let (v21, v22, v23) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg5, arg0, arg1, false, true, v14 - v15, 79226673515401279992447579045);
                        let v24 = v23;
                        0x2471d35e980346ba294fb012236a64a344b3c3df4a678abb88aa666a37e6fc42::token::join<T0>(arg2, v21, 0);
                        0x2471d35e980346ba294fb012236a64a344b3c3df4a678abb88aa666a37e6fc42::token::join<T1>(arg3, v22, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v24));
                        (0x1::option::some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(v24), false)
                    };
                    (v20, v19)
                };
                (v17, v16)
            } else {
                let v25 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg1, true, false, v15 - v14, 4295048026);
                assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v25) >= v15 - v14, 12);
                let (v26, v27, v28) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg5, arg0, arg1, true, false, v15 - v14, 4295048026);
                let v29 = v28;
                0x2471d35e980346ba294fb012236a64a344b3c3df4a678abb88aa666a37e6fc42::token::join<T0>(arg2, v26, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v29));
                0x2471d35e980346ba294fb012236a64a344b3c3df4a678abb88aa666a37e6fc42::token::join<T1>(arg3, v27, 0);
                (0x1::option::some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(v29), true)
            }
        }
    }

    public fun repay_flash_swap<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x2471d35e980346ba294fb012236a64a344b3c3df4a678abb88aa666a37e6fc42::token::TokenData<T0>, arg3: &mut 0x2471d35e980346ba294fb012236a64a344b3c3df4a678abb88aa666a37e6fc42::token::TokenData<T1>, arg4: 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>, arg5: bool) {
        if (0x1::option::is_some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(&arg4)) {
            let v0 = 0x1::option::extract<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(&mut arg4);
            if (arg5) {
                0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2471d35e980346ba294fb012236a64a344b3c3df4a678abb88aa666a37e6fc42::token::pay_debt<T0>(arg2, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v0)), 0x2::balance::zero<T1>(), v0);
            } else {
                0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2471d35e980346ba294fb012236a64a344b3c3df4a678abb88aa666a37e6fc42::token::pay_debt<T1>(arg3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v0)), v0);
            };
        };
        0x1::option::destroy_none<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, T1>>(arg4);
    }

    // decompiled from Move bytecode v6
}

