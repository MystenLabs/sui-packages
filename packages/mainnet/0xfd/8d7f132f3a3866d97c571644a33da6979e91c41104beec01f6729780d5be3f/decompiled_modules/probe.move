module 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::probe {
    public fun probe_bluefin_deepbook<T0>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T0>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        if (!0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::live(0x2::clock::timestamp_ms(arg8), arg7)) {
            return
        };
        0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::floors(arg5, arg5);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<0x2::sui::SUI, T0>(arg2, arg8);
        let (v1, v2, v3) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::screen(0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::clmm_price(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<0x2::sui::SUI, T0>(arg1), false), (v0 as u128), (v0 as u128), arg6);
        if (!v1 && !v2) {
            return
        };
        let (_, v5, _, v7) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::book_grid<0x2::sui::SUI, T0>(arg2, v0);
        let (_, v9, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::vault_balances<0x2::sui::SUI, T0>(arg2);
        let v11 = if (arg4 > v9) {
            v9
        } else {
            arg4
        };
        let v12 = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::search::new(arg3, v11, arg3, v11, v2, v1, !v3, v5, v5, v7, v7);
        loop {
            let (v13, v14, v15) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::search::next(&mut v12);
            if (!v13) {
                break
            };
            let v16 = if (v14) {
                let (v17, _) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::book<0x2::sui::SUI, T0>(arg2, false, 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::bluefin<0x2::sui::SUI, T0>(arg1, false, v15), arg8);
                v17
            } else {
                let (v19, v20) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::book<0x2::sui::SUI, T0>(arg2, true, v15, arg8);
                0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::cap((0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::bluefin<0x2::sui::SUI, T0>(arg1, true, v19) as u256) + (v20 as u256))
            };
            0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::search::record(&mut v12, v14, v15, v16, arg5);
        };
        let (v21, v22, v23) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::search::result(&v12, !v3);
        if (v22 == 0) {
            return
        };
        let (v24, v25) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<0x2::sui::SUI, T0>(arg2, v22, arg9);
        let v26 = if (v21) {
            let (v27, v28) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::execute::bluefin_buy<0x2::sui::SUI, T0>(arg0, arg1, 0x2::coin::into_balance<T0>(v24), arg8);
            let (v29, v30) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::execute::book_sell<0x2::sui::SUI, T0>(arg2, v27, arg8, arg9);
            let v31 = v29;
            0x2::balance::join<T0>(&mut v31, v28);
            0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::payout<0x2::sui::SUI>(v30, arg9);
            v31
        } else {
            let (v32, v33) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::execute::book_buy<0x2::sui::SUI, T0>(arg2, 0x2::coin::into_balance<T0>(v24), arg8, arg9);
            let (v34, v35) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::execute::bluefin_sell<0x2::sui::SUI, T0>(arg0, arg1, v32, arg8);
            let v36 = v34;
            0x2::balance::join<T0>(&mut v36, v33);
            0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::payout<0x2::sui::SUI>(v35, arg9);
            v36
        };
        let v37 = v26;
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<0x2::sui::SUI, T0>(arg2, 0x2::coin::from_balance<T0>(0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::repayment<T0>(&mut v37, v22, arg5), arg9), v25);
        0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::finish<T0>(6, v21, v22, v37, v23, arg9);
    }

    public fun probe_cetus_bluefin_flip<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T0>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        if (!0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::live(0x2::clock::timestamp_ms(arg12), arg11)) {
            return
        };
        0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::floors(arg8, arg9);
        if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_pause<T0, 0x2::sui::SUI>(arg1)) {
            return
        };
        let v0 = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::clmm_price(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, 0x2::sui::SUI>(arg1), true);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<0x2::sui::SUI, T0>(arg3);
        if (v0 == 0 || 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::clmm_price(v1, false) == 0) {
            return
        };
        let (v2, v3) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::gap::flip(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, 0x2::sui::SUI>(arg1), v1, arg10);
        let v4 = v2 && v3 || arg10 == 0 && v0 > 0;
        let v5 = v2 && !v3 || arg10 == 0 && v0 > 0;
        if (!v4 && !v5) {
            return
        };
        let v6 = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::search::new(arg4, arg5, arg6, arg7, v4, v5, v3, 1, 1, 1, 1);
        loop {
            let (v7, v8, v9) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::search::next(&mut v6);
            if (!v7) {
                break
            };
            let v10 = if (v8) {
                arg8
            } else {
                arg9
            };
            0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::search::record(&mut v6, v8, v9, 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::bluefin<0x2::sui::SUI, T0>(arg3, !v8, 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::cetus<T0, 0x2::sui::SUI>(arg1, !v8, v9)), v10);
        };
        let (v11, v12, v13) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::search::result(&v6, v3);
        if (v12 == 0) {
            return
        };
        if (v11) {
            let (v14, v15, v16) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, false, true, v12, 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::limit(false), arg12);
            let v17 = v16;
            0x2::balance::destroy_zero<0x2::sui::SUI>(v15);
            let v18 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v17);
            let (v19, v20) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::execute::bluefin_buy<0x2::sui::SUI, T0>(arg2, arg3, v14, arg12);
            let v21 = v19;
            0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::payout<T0>(v20, arg13);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T0>(), 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::repayment<0x2::sui::SUI>(&mut v21, v18, arg8), v17);
            0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::finish<0x2::sui::SUI>(3, v11, v18, v21, v13, arg13);
        } else {
            let (v22, v23, v24) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, true, true, v12, 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::limit(true), arg12);
            let v25 = v24;
            0x2::balance::destroy_zero<T0>(v22);
            let v26 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v25);
            let (v27, v28) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::execute::bluefin_sell<0x2::sui::SUI, T0>(arg2, arg3, v23, arg12);
            let v29 = v27;
            0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::payout<0x2::sui::SUI>(v28, arg13);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::repayment<T0>(&mut v29, v26, arg9), 0x2::balance::zero<0x2::sui::SUI>(), v25);
            0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::finish<T0>(3, v11, v26, v29, v13, arg13);
        };
    }

    public fun probe_cetus_bolt_flip<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<0x2::sui::SUI>, arg3: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        if (!0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::live(0x2::clock::timestamp_ms(arg12), arg11)) {
            return
        };
        0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::floors(arg8, arg9);
        if (!0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::bolt_live<0x2::sui::SUI, T0>(arg3, arg12) || !0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::bolt_live<T0, 0x2::sui::SUI>(arg3, arg12)) {
            return
        };
        if (!0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::bolt_available<0x2::sui::SUI, T0>(arg2)) {
            return
        };
        if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_pause<T0, 0x2::sui::SUI>(arg1)) {
            return
        };
        let (v0, v1) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::bolt_prices<0x2::sui::SUI, T0>(arg3, arg12);
        let (v2, v3, v4) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::screen(0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::clmm_price(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, 0x2::sui::SUI>(arg1), true), v0, v1, arg10);
        if (!v2 && !v3) {
            return
        };
        let v5 = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::search::new(arg4, arg5, arg6, arg7, v2, v3, v4, 1, 1, 1, 1);
        let v6 = false;
        loop {
            let (v7, v8, v9) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::search::next(&mut v5);
            if (!v7) {
                break
            };
            let v10 = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::cetus<T0, 0x2::sui::SUI>(arg1, !v8, v9);
            let (v11, v12) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::bolt_out<0x2::sui::SUI, T0>(arg2, arg3, v8, v10, arg12);
            let v13 = if (!v6) {
                if (v12 > 0) {
                    v10 > 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v13) {
                0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::search::boundary(&mut v5, v8, 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::debt_boundary(v9, v10, v12));
                v6 = true;
            };
            let v14 = if (v8) {
                arg8
            } else {
                arg9
            };
            0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::search::record(&mut v5, v8, v9, v11, v14);
        };
        let (v15, v16, v17) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::search::result(&v5, v4);
        if (v16 == 0) {
            return
        };
        if (v15) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, false, true, v16, 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::limit(false), arg12);
            let v21 = v20;
            0x2::balance::destroy_zero<0x2::sui::SUI>(v19);
            let v22 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v21);
            let (v23, v24) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::execute::bolt_buy<0x2::sui::SUI, T0>(arg2, arg3, v18, arg12, arg13);
            let v25 = v23;
            0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::payout<T0>(v24, arg13);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T0>(), 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::repayment<0x2::sui::SUI>(&mut v25, v22, arg8), v21);
            0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::finish<0x2::sui::SUI>(4, v15, v22, v25, v17, arg13);
        } else {
            let (v26, v27, v28) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, true, true, v16, 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::limit(true), arg12);
            let v29 = v28;
            0x2::balance::destroy_zero<T0>(v26);
            let v30 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v29);
            let (v31, v32) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::execute::bolt_sell<0x2::sui::SUI, T0>(arg2, arg3, v27, arg12, arg13);
            let v33 = v31;
            0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::payout<0x2::sui::SUI>(v32, arg13);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::repayment<T0>(&mut v33, v30, arg9), 0x2::balance::zero<0x2::sui::SUI>(), v29);
            0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::finish<T0>(4, v15, v30, v33, v17, arg13);
        };
    }

    public fun probe_cetus_deepbook_flip<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        if (!0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::live(0x2::clock::timestamp_ms(arg11), arg10)) {
            return
        };
        0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::floors(arg7, arg8);
        if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_pause<T0, 0x2::sui::SUI>(arg1)) {
            return
        };
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<0x2::sui::SUI, T0>(arg2, arg11);
        let (v1, v2, v3) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::screen(0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::clmm_price(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, 0x2::sui::SUI>(arg1), true), (v0 as u128), (v0 as u128), arg9);
        let (v4, v5, v6, v7) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::book_grid<0x2::sui::SUI, T0>(arg2, v0);
        if (!v1 && !v2) {
            return
        };
        let v8 = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::search::new(arg3, arg4, arg5, arg6, v1, v2, v3, v4, v5, v6, v7);
        loop {
            let (v9, v10, v11) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::search::next(&mut v8);
            if (!v9) {
                break
            };
            let (v12, _) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::book<0x2::sui::SUI, T0>(arg2, v10, 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::cetus<T0, 0x2::sui::SUI>(arg1, !v10, v11), arg11);
            let v14 = if (v10) {
                arg7
            } else {
                arg8
            };
            0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::search::record(&mut v8, v10, v11, v12, v14);
        };
        let (v15, v16, v17) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::search::result(&v8, v3);
        if (v16 == 0) {
            return
        };
        if (v15) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, false, true, v16, 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::limit(false), arg11);
            let v21 = v20;
            0x2::balance::destroy_zero<0x2::sui::SUI>(v19);
            let v22 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v21);
            let (v23, v24) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::execute::book_buy<0x2::sui::SUI, T0>(arg2, v18, arg11, arg12);
            let v25 = v23;
            0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::payout<T0>(v24, arg12);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T0>(), 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::repayment<0x2::sui::SUI>(&mut v25, v22, arg7), v21);
            0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::finish<0x2::sui::SUI>(1, v15, v22, v25, v17, arg12);
        } else {
            let (v26, v27, v28) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, true, true, v16, 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::limit(true), arg11);
            let v29 = v28;
            0x2::balance::destroy_zero<T0>(v26);
            let v30 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v29);
            let (v31, v32) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::execute::book_sell<0x2::sui::SUI, T0>(arg2, v27, arg11, arg12);
            let v33 = v31;
            0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::payout<0x2::sui::SUI>(v32, arg12);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::repayment<T0>(&mut v33, v30, arg8), 0x2::balance::zero<0x2::sui::SUI>(), v29);
            0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::finish<T0>(1, v15, v30, v33, v17, arg12);
        };
    }

    public fun probe_cetus_turbos_flip<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, T0, T1>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        if (!0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::live(0x2::clock::timestamp_ms(arg9), arg8)) {
            return
        };
        0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::floors(arg6, arg6);
        if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_pause<T0, 0x2::sui::SUI>(arg1) || !0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_unlocked<0x2::sui::SUI, T0, T1>(arg2)) {
            return
        };
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, 0x2::sui::SUI>(arg1);
        let v1 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<0x2::sui::SUI, T0, T1>(arg2);
        if (0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::clmm_price(v0, true) == 0 || 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::clmm_price(v1, false) == 0) {
            return
        };
        let (v2, v3) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::gap::flip(v0, v1, arg7);
        if (!v2 && arg7 > 0) {
            return
        };
        let v4 = v3 || arg7 == 0;
        let v5 = !v3 || arg7 == 0;
        let v6 = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::search::new(arg4, arg5, arg4, arg5, v4, v5, v3, 1, 1, 1, 1);
        loop {
            let (v7, v8, v9) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::search::next(&mut v6);
            if (!v7) {
                break
            };
            let v10 = if (v8) {
                0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::turbos<0x2::sui::SUI, T0, T1>(arg2, false, 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::cetus<T0, 0x2::sui::SUI>(arg1, false, v9))
            } else {
                0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::cetus<T0, 0x2::sui::SUI>(arg1, true, 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::turbos<0x2::sui::SUI, T0, T1>(arg2, true, v9))
            };
            0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::search::record(&mut v6, v8, v9, v10, arg6);
        };
        let (v11, v12, v13) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::search::result(&v6, v3);
        if (v12 == 0) {
            return
        };
        if (v11) {
            let (v14, v15, v16) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, false, true, v12, 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::limit(false), arg9);
            let v17 = v16;
            0x2::balance::destroy_zero<0x2::sui::SUI>(v15);
            let v18 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v17);
            let (v19, v20) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::execute::turbos_buy<0x2::sui::SUI, T0, T1>(arg2, arg3, v14, arg9, arg10);
            let v21 = v19;
            0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::payout<T0>(v20, arg10);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T0>(), 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::repayment<0x2::sui::SUI>(&mut v21, v18, arg6), v17);
            0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::finish<0x2::sui::SUI>(0, v11, v18, v21, v13, arg10);
        } else {
            let (v22, v23, v24) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<0x2::sui::SUI, T0, T1>(arg2, @0x0, true, (v12 as u128), true, 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::limit(true), arg9, arg3, arg10);
            let v25 = v24;
            0x2::coin::destroy_zero<0x2::sui::SUI>(v22);
            let (_, _, v28) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<0x2::sui::SUI, T0>(&v25);
            let (v29, v30) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::execute::cetus_sell<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::coin::into_balance<T0>(v23), arg9);
            let v31 = v29;
            0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::payout<T0>(v30, arg10);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<0x2::sui::SUI, T0, T1>(arg2, 0x2::coin::from_balance<0x2::sui::SUI>(0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::repayment<0x2::sui::SUI>(&mut v31, v28, arg6), arg10), 0x2::coin::zero<T0>(arg10), v25, arg3);
            0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::finish<0x2::sui::SUI>(0, v11, v28, v31, v13, arg10);
        };
    }

    public fun probe_turbos_bolt<T0, T1>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, T0, T1>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<0x2::sui::SUI>, arg3: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        if (!0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::live(0x2::clock::timestamp_ms(arg12), arg11)) {
            return
        };
        0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::floors(arg8, arg9);
        if (!0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::bolt_live<0x2::sui::SUI, T0>(arg3, arg12) || !0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::bolt_live<T0, 0x2::sui::SUI>(arg3, arg12)) {
            return
        };
        if (!0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::bolt_available<0x2::sui::SUI, T0>(arg2)) {
            return
        };
        if (!0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_unlocked<0x2::sui::SUI, T0, T1>(arg0)) {
            return
        };
        let (v0, v1) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::bolt_prices<0x2::sui::SUI, T0>(arg3, arg12);
        let (v2, v3, v4) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::screen(0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::clmm_price(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<0x2::sui::SUI, T0, T1>(arg0), false), v0, v1, arg10);
        if (!v2 && !v3) {
            return
        };
        let v5 = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::search::new(arg4, arg5, arg6, arg7, v2, v3, v4, 1, 1, 1, 1);
        let v6 = false;
        loop {
            let (v7, v8, v9) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::search::next(&mut v5);
            if (!v7) {
                break
            };
            let v10 = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::turbos<0x2::sui::SUI, T0, T1>(arg0, v8, v9);
            let (v11, v12) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::bolt_out<0x2::sui::SUI, T0>(arg2, arg3, v8, v10, arg12);
            let v13 = if (!v6) {
                if (v12 > 0) {
                    v10 > 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v13) {
                0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::search::boundary(&mut v5, v8, 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::debt_boundary(v9, v10, v12));
                v6 = true;
            };
            let v14 = if (v8) {
                arg8
            } else {
                arg9
            };
            0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::search::record(&mut v5, v8, v9, v11, v14);
        };
        let (v15, v16, v17) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::search::result(&v5, v4);
        if (v16 == 0) {
            return
        };
        if (v15) {
            let (v18, v19, v20) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<0x2::sui::SUI, T0, T1>(arg0, @0x0, true, (v16 as u128), true, 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::limit(true), arg12, arg1, arg13);
            let v21 = v20;
            0x2::coin::destroy_zero<0x2::sui::SUI>(v18);
            let (_, _, v24) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<0x2::sui::SUI, T0>(&v21);
            let (v25, v26) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::execute::bolt_buy<0x2::sui::SUI, T0>(arg2, arg3, 0x2::coin::into_balance<T0>(v19), arg12, arg13);
            let v27 = v25;
            0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::payout<T0>(v26, arg13);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<0x2::sui::SUI, T0, T1>(arg0, 0x2::coin::from_balance<0x2::sui::SUI>(0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::repayment<0x2::sui::SUI>(&mut v27, v24, arg8), arg13), 0x2::coin::zero<T0>(arg13), v21, arg1);
            0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::finish<0x2::sui::SUI>(5, v15, v24, v27, v17, arg13);
        } else {
            let (v28, v29, v30) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<0x2::sui::SUI, T0, T1>(arg0, @0x0, false, (v16 as u128), true, 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::limit(false), arg12, arg1, arg13);
            let v31 = v30;
            0x2::coin::destroy_zero<T0>(v29);
            let (_, _, v34) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<0x2::sui::SUI, T0>(&v31);
            let (v35, v36) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::execute::bolt_sell<0x2::sui::SUI, T0>(arg2, arg3, 0x2::coin::into_balance<0x2::sui::SUI>(v28), arg12, arg13);
            let v37 = v35;
            0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::payout<0x2::sui::SUI>(v36, arg13);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<0x2::sui::SUI, T0, T1>(arg0, 0x2::coin::zero<0x2::sui::SUI>(arg13), 0x2::coin::from_balance<T0>(0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::repayment<T0>(&mut v37, v34, arg9), arg13), v31, arg1);
            0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::finish<T0>(5, v15, v34, v37, v17, arg13);
        };
    }

    public fun probe_turbos_deepbook<T0, T1>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, T0, T1>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        if (!0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::live(0x2::clock::timestamp_ms(arg11), arg10)) {
            return
        };
        0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::floors(arg7, arg8);
        if (!0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_unlocked<0x2::sui::SUI, T0, T1>(arg0)) {
            return
        };
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<0x2::sui::SUI, T0>(arg2, arg11);
        let (v1, v2, v3) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::screen(0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::clmm_price(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<0x2::sui::SUI, T0, T1>(arg0), false), (v0 as u128), (v0 as u128), arg9);
        let (v4, v5, v6, v7) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::book_grid<0x2::sui::SUI, T0>(arg2, v0);
        if (!v1 && !v2) {
            return
        };
        let v8 = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::search::new(arg3, arg4, arg5, arg6, v1, v2, v3, v4, v5, v6, v7);
        loop {
            let (v9, v10, v11) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::search::next(&mut v8);
            if (!v9) {
                break
            };
            let (v12, _) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::book<0x2::sui::SUI, T0>(arg2, v10, 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::turbos<0x2::sui::SUI, T0, T1>(arg0, v10, v11), arg11);
            let v14 = if (v10) {
                arg7
            } else {
                arg8
            };
            0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::search::record(&mut v8, v10, v11, v12, v14);
        };
        let (v15, v16, v17) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::search::result(&v8, v3);
        if (v16 == 0) {
            return
        };
        if (v15) {
            let (v18, v19, v20) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<0x2::sui::SUI, T0, T1>(arg0, @0x0, true, (v16 as u128), true, 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::limit(true), arg11, arg1, arg12);
            let v21 = v20;
            0x2::coin::destroy_zero<0x2::sui::SUI>(v18);
            let (_, _, v24) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<0x2::sui::SUI, T0>(&v21);
            let (v25, v26) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::execute::book_buy<0x2::sui::SUI, T0>(arg2, 0x2::coin::into_balance<T0>(v19), arg11, arg12);
            let v27 = v25;
            0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::payout<T0>(v26, arg12);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<0x2::sui::SUI, T0, T1>(arg0, 0x2::coin::from_balance<0x2::sui::SUI>(0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::repayment<0x2::sui::SUI>(&mut v27, v24, arg7), arg12), 0x2::coin::zero<T0>(arg12), v21, arg1);
            0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::finish<0x2::sui::SUI>(2, v15, v24, v27, v17, arg12);
        } else {
            let (v28, v29, v30) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<0x2::sui::SUI, T0, T1>(arg0, @0x0, false, (v16 as u128), true, 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q::limit(false), arg11, arg1, arg12);
            let v31 = v30;
            0x2::coin::destroy_zero<T0>(v29);
            let (_, _, v34) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<0x2::sui::SUI, T0>(&v31);
            let (v35, v36) = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::execute::book_sell<0x2::sui::SUI, T0>(arg2, 0x2::coin::into_balance<0x2::sui::SUI>(v28), arg11, arg12);
            let v37 = v35;
            0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::payout<0x2::sui::SUI>(v36, arg12);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<0x2::sui::SUI, T0, T1>(arg0, 0x2::coin::zero<0x2::sui::SUI>(arg12), 0x2::coin::from_balance<T0>(0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::repayment<T0>(&mut v37, v34, arg8), arg12), v31, arg1);
            0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::account::finish<T0>(2, v15, v34, v37, v17, arg12);
        };
    }

    // decompiled from Move bytecode v7
}

