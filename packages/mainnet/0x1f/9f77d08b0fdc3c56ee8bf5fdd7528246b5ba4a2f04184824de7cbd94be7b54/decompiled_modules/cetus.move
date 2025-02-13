module 0x1f9f77d08b0fdc3c56ee8bf5fdd7528246b5ba4a2f04184824de7cbd94be7b54::cetus {
    public fun flash_swap<T0, T1>(arg0: &mut 0x1f9f77d08b0fdc3c56ee8bf5fdd7528246b5ba4a2f04184824de7cbd94be7b54::token::TokenData<T0>, arg1: &mut 0x1f9f77d08b0fdc3c56ee8bf5fdd7528246b5ba4a2f04184824de7cbd94be7b54::token::TokenData<T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u128, arg5: u128, arg6: &0x2::clock::Clock) : (0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>, bool) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3);
        if (v0 > arg4) {
            let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg3, true, false, 1);
            if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_after_sqrt_price(&v3) > arg4) {
                let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg2, arg3, true, true, 18446744073709551615, arg4, arg6);
                let v7 = v6;
                0x1f9f77d08b0fdc3c56ee8bf5fdd7528246b5ba4a2f04184824de7cbd94be7b54::token::join<T0>(arg0, v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v7));
                0x1f9f77d08b0fdc3c56ee8bf5fdd7528246b5ba4a2f04184824de7cbd94be7b54::token::join<T1>(arg1, v5, 0);
                (0x1::option::some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(v7), true)
            } else {
                (0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(), true)
            }
        } else if (v0 < arg5) {
            let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg3, false, false, 1);
            if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_after_sqrt_price(&v8) < arg5) {
                let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg2, arg3, false, true, 18446744073709551615, arg5, arg6);
                let v12 = v11;
                0x1f9f77d08b0fdc3c56ee8bf5fdd7528246b5ba4a2f04184824de7cbd94be7b54::token::join<T0>(arg0, v9, 0);
                0x1f9f77d08b0fdc3c56ee8bf5fdd7528246b5ba4a2f04184824de7cbd94be7b54::token::join<T1>(arg1, v10, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v12));
                (0x1::option::some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(v12), false)
            } else {
                (0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(), false)
            }
        } else {
            (0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(), true)
        }
    }

    public fun repay_flash_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1f9f77d08b0fdc3c56ee8bf5fdd7528246b5ba4a2f04184824de7cbd94be7b54::token::TokenData<T0>, arg3: &mut 0x1f9f77d08b0fdc3c56ee8bf5fdd7528246b5ba4a2f04184824de7cbd94be7b54::token::TokenData<T1>, arg4: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>, arg5: bool) {
        if (0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(&arg4)) {
            let v0 = 0x1::option::extract<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(&mut arg4);
            if (arg5) {
                0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x1f9f77d08b0fdc3c56ee8bf5fdd7528246b5ba4a2f04184824de7cbd94be7b54::token::pay_debt<T0>(arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v0)), 0x2::balance::zero<T1>(), v0);
            } else {
                0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x1f9f77d08b0fdc3c56ee8bf5fdd7528246b5ba4a2f04184824de7cbd94be7b54::token::pay_debt<T1>(arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v0)), v0);
            };
        };
        0x1::option::destroy_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(arg4);
    }

    public fun handle_initial_balanace<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1f9f77d08b0fdc3c56ee8bf5fdd7528246b5ba4a2f04184824de7cbd94be7b54::token::TokenData<T0>, arg3: &mut 0x1f9f77d08b0fdc3c56ee8bf5fdd7528246b5ba4a2f04184824de7cbd94be7b54::token::TokenData<T1>, arg4: bool, arg5: &0x2::clock::Clock) : (0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>, bool) {
        if (arg4) {
            let v2 = 0x1f9f77d08b0fdc3c56ee8bf5fdd7528246b5ba4a2f04184824de7cbd94be7b54::token::balance_value<T0>(arg2);
            let v3 = 0x1f9f77d08b0fdc3c56ee8bf5fdd7528246b5ba4a2f04184824de7cbd94be7b54::token::debt_value<T0>(arg2);
            if (v2 >= v3) {
                if (v2 == v3) {
                    (0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(), false)
                } else {
                    let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg1, true, true, v2 - v3);
                    if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v4) == 0) {
                        (0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(), false)
                    } else {
                        let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v4), 4295048016, arg5);
                        let v8 = v7;
                        0x1f9f77d08b0fdc3c56ee8bf5fdd7528246b5ba4a2f04184824de7cbd94be7b54::token::join<T0>(arg2, v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v8));
                        0x1f9f77d08b0fdc3c56ee8bf5fdd7528246b5ba4a2f04184824de7cbd94be7b54::token::join<T1>(arg3, v6, 0);
                        (0x1::option::some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(v8), true)
                    }
                }
            } else {
                let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg1, false, false, v3 - v2);
                assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v9) >= v3 - v2, 12);
                let (v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, false, v3 - v2, 79226673515401279992447579055, arg5);
                let v13 = v12;
                0x1f9f77d08b0fdc3c56ee8bf5fdd7528246b5ba4a2f04184824de7cbd94be7b54::token::join<T0>(arg2, v10, 0);
                0x1f9f77d08b0fdc3c56ee8bf5fdd7528246b5ba4a2f04184824de7cbd94be7b54::token::join<T1>(arg3, v11, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v13));
                (0x1::option::some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(v13), false)
            }
        } else {
            let v14 = 0x1f9f77d08b0fdc3c56ee8bf5fdd7528246b5ba4a2f04184824de7cbd94be7b54::token::balance_value<T1>(arg3);
            let v15 = 0x1f9f77d08b0fdc3c56ee8bf5fdd7528246b5ba4a2f04184824de7cbd94be7b54::token::debt_value<T1>(arg3);
            if (v14 >= v15) {
                let (v16, v17) = if (v14 == v15) {
                    (false, 0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>())
                } else {
                    let v18 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg1, false, true, v14 - v15);
                    let (v19, v20) = if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v18) == 0) {
                        (0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(), false)
                    } else {
                        let (v21, v22, v23) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v18), 79226673515401279992447579055, arg5);
                        let v24 = v23;
                        0x1f9f77d08b0fdc3c56ee8bf5fdd7528246b5ba4a2f04184824de7cbd94be7b54::token::join<T0>(arg2, v21, 0);
                        0x1f9f77d08b0fdc3c56ee8bf5fdd7528246b5ba4a2f04184824de7cbd94be7b54::token::join<T1>(arg3, v22, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v24));
                        (0x1::option::some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(v24), false)
                    };
                    (v20, v19)
                };
                (v17, v16)
            } else {
                let v25 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg1, true, false, v15 - v14);
                assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v25) >= v15 - v14, 12);
                let (v26, v27, v28) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, v15 - v14, 4295048016, arg5);
                let v29 = v28;
                0x1f9f77d08b0fdc3c56ee8bf5fdd7528246b5ba4a2f04184824de7cbd94be7b54::token::join<T0>(arg2, v26, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v29));
                0x1f9f77d08b0fdc3c56ee8bf5fdd7528246b5ba4a2f04184824de7cbd94be7b54::token::join<T1>(arg3, v27, 0);
                (0x1::option::some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(v29), true)
            }
        }
    }

    // decompiled from Move bytecode v6
}

