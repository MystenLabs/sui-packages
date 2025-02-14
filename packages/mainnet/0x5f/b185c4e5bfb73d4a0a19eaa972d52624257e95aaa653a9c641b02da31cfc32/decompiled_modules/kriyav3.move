module 0x5fb185c4e5bfb73d4a0a19eaa972d52624257e95aaa653a9c641b02da31cfc32::kriyav3 {
    public fun flash_swap<T0, T1>(arg0: &mut 0x5fb185c4e5bfb73d4a0a19eaa972d52624257e95aaa653a9c641b02da31cfc32::token::TokenData<T0>, arg1: &mut 0x5fb185c4e5bfb73d4a0a19eaa972d52624257e95aaa653a9c641b02da31cfc32::token::TokenData<T1>, arg2: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg3: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg4: u128, arg5: u128, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : (0x1::option::Option<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::FlashSwapReceipt>, bool) {
        let v0 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg3);
        if (v0 > arg4) {
            let v3 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::compute_swap_result<T0, T1>(arg3, true, true, arg4, 18446744073709551615);
            if (0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::get_state_amount_calculated(&v3) > 0) {
                let (v4, v5, v6) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg3, true, true, 18446744073709551615, arg4, arg6, arg2, arg7);
                let v7 = v6;
                let (v8, v9) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::swap_receipt_debts(&v7);
                0x5fb185c4e5bfb73d4a0a19eaa972d52624257e95aaa653a9c641b02da31cfc32::token::join<T0>(arg0, v4, v8);
                0x5fb185c4e5bfb73d4a0a19eaa972d52624257e95aaa653a9c641b02da31cfc32::token::join<T1>(arg1, v5, v9);
                (0x1::option::some<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::FlashSwapReceipt>(v7), true)
            } else {
                (0x1::option::none<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::FlashSwapReceipt>(), true)
            }
        } else if (v0 < arg5) {
            let v10 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::compute_swap_result<T0, T1>(arg3, false, true, arg5, 18446744073709551615);
            if (0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::get_state_amount_calculated(&v10) > 0) {
                let (v11, v12, v13) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg3, false, true, 18446744073709551615, arg5, arg6, arg2, arg7);
                let v14 = v13;
                let (v15, v16) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::swap_receipt_debts(&v14);
                0x5fb185c4e5bfb73d4a0a19eaa972d52624257e95aaa653a9c641b02da31cfc32::token::join<T0>(arg0, v11, v15);
                0x5fb185c4e5bfb73d4a0a19eaa972d52624257e95aaa653a9c641b02da31cfc32::token::join<T1>(arg1, v12, v16);
                (0x1::option::some<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::FlashSwapReceipt>(v14), false)
            } else {
                (0x1::option::none<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::FlashSwapReceipt>(), false)
            }
        } else {
            (0x1::option::none<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::FlashSwapReceipt>(), true)
        }
    }

    public fun handle_initial_balanace<T0, T1>(arg0: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &mut 0x5fb185c4e5bfb73d4a0a19eaa972d52624257e95aaa653a9c641b02da31cfc32::token::TokenData<T0>, arg3: &mut 0x5fb185c4e5bfb73d4a0a19eaa972d52624257e95aaa653a9c641b02da31cfc32::token::TokenData<T1>, arg4: bool, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : (0x1::option::Option<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::FlashSwapReceipt>, bool) {
        if (arg4) {
            let v2 = 0x5fb185c4e5bfb73d4a0a19eaa972d52624257e95aaa653a9c641b02da31cfc32::token::balance_value<T0>(arg2);
            let v3 = 0x5fb185c4e5bfb73d4a0a19eaa972d52624257e95aaa653a9c641b02da31cfc32::token::debt_value<T0>(arg2);
            if (v2 >= v3) {
                if (v2 == v3) {
                    (0x1::option::none<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::FlashSwapReceipt>(), false)
                } else {
                    let v4 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::compute_swap_result<T0, T1>(arg1, true, true, 4295048026, v2 - v3);
                    if (0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::get_state_amount_calculated(&v4) == 0) {
                        (0x1::option::none<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::FlashSwapReceipt>(), false)
                    } else {
                        let (v5, v6, v7) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg1, true, true, v2 - v3, 4295048026, arg5, arg0, arg6);
                        let v8 = v7;
                        let (v9, v10) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::swap_receipt_debts(&v8);
                        0x5fb185c4e5bfb73d4a0a19eaa972d52624257e95aaa653a9c641b02da31cfc32::token::join<T0>(arg2, v5, v9);
                        0x5fb185c4e5bfb73d4a0a19eaa972d52624257e95aaa653a9c641b02da31cfc32::token::join<T1>(arg3, v6, v10);
                        (0x1::option::some<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::FlashSwapReceipt>(v8), true)
                    }
                }
            } else {
                let v11 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::compute_swap_result<T0, T1>(arg1, false, false, 79226673515401279992447579045, v3 - v2);
                assert!(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::get_state_amount_calculated(&v11) >= v3 - v2, 12);
                let (v12, v13, v14) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg1, false, false, v3 - v2, 79226673515401279992447579045, arg5, arg0, arg6);
                let v15 = v14;
                let (v16, v17) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::swap_receipt_debts(&v15);
                0x5fb185c4e5bfb73d4a0a19eaa972d52624257e95aaa653a9c641b02da31cfc32::token::join<T0>(arg2, v12, v16);
                0x5fb185c4e5bfb73d4a0a19eaa972d52624257e95aaa653a9c641b02da31cfc32::token::join<T1>(arg3, v13, v17);
                (0x1::option::some<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::FlashSwapReceipt>(v15), false)
            }
        } else {
            let v18 = 0x5fb185c4e5bfb73d4a0a19eaa972d52624257e95aaa653a9c641b02da31cfc32::token::balance_value<T1>(arg3);
            let v19 = 0x5fb185c4e5bfb73d4a0a19eaa972d52624257e95aaa653a9c641b02da31cfc32::token::debt_value<T1>(arg3);
            if (v18 >= v19) {
                let (v20, v21) = if (v18 == v19) {
                    (false, 0x1::option::none<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::FlashSwapReceipt>())
                } else {
                    let v22 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::compute_swap_result<T0, T1>(arg1, false, true, 79226673515401279992447579045, v18 - v19);
                    let (v23, v24) = if (0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::get_state_amount_calculated(&v22) == 0) {
                        (0x1::option::none<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::FlashSwapReceipt>(), false)
                    } else {
                        let (v25, v26, v27) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg1, false, true, v18 - v19, 79226673515401279992447579045, arg5, arg0, arg6);
                        let v28 = v27;
                        let (v29, v30) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::swap_receipt_debts(&v28);
                        0x5fb185c4e5bfb73d4a0a19eaa972d52624257e95aaa653a9c641b02da31cfc32::token::join<T0>(arg2, v25, v29);
                        0x5fb185c4e5bfb73d4a0a19eaa972d52624257e95aaa653a9c641b02da31cfc32::token::join<T1>(arg3, v26, v30);
                        (0x1::option::some<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::FlashSwapReceipt>(v28), false)
                    };
                    (v24, v23)
                };
                (v21, v20)
            } else {
                let v31 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::compute_swap_result<T0, T1>(arg1, true, false, 4295048026, v19 - v18);
                assert!(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::get_state_amount_calculated(&v31) >= v19 - v18, 12);
                let (v32, v33, v34) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg1, true, false, v19 - v18, 4295048026, arg5, arg0, arg6);
                let v35 = v34;
                let (v36, v37) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::swap_receipt_debts(&v35);
                0x5fb185c4e5bfb73d4a0a19eaa972d52624257e95aaa653a9c641b02da31cfc32::token::join<T0>(arg2, v32, v36);
                0x5fb185c4e5bfb73d4a0a19eaa972d52624257e95aaa653a9c641b02da31cfc32::token::join<T1>(arg3, v33, v37);
                (0x1::option::some<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::FlashSwapReceipt>(v35), true)
            }
        }
    }

    public fun repay_flash_swap<T0, T1>(arg0: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &mut 0x5fb185c4e5bfb73d4a0a19eaa972d52624257e95aaa653a9c641b02da31cfc32::token::TokenData<T0>, arg3: &mut 0x5fb185c4e5bfb73d4a0a19eaa972d52624257e95aaa653a9c641b02da31cfc32::token::TokenData<T1>, arg4: 0x1::option::Option<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::FlashSwapReceipt>, arg5: bool, arg6: &0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::FlashSwapReceipt>(&arg4)) {
            let v0 = 0x1::option::extract<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::FlashSwapReceipt>(&mut arg4);
            let (v1, v2) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::swap_receipt_debts(&v0);
            0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg1, v0, 0x5fb185c4e5bfb73d4a0a19eaa972d52624257e95aaa653a9c641b02da31cfc32::token::pay_debt<T0>(arg2, v1), 0x5fb185c4e5bfb73d4a0a19eaa972d52624257e95aaa653a9c641b02da31cfc32::token::pay_debt<T1>(arg3, v2), arg0, arg6);
        };
        0x1::option::destroy_none<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::FlashSwapReceipt>(arg4);
    }

    // decompiled from Move bytecode v6
}

