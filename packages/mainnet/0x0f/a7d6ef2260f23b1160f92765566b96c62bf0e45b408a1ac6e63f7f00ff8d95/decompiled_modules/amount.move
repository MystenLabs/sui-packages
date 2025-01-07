module 0xfa7d6ef2260f23b1160f92765566b96c62bf0e45b408a1ac6e63f7f00ff8d95::amount {
    struct ArbEvent has copy, drop, store {
        sender: address,
        is_x_to_y: bool,
        swap_amount: u64,
        iterations: u64,
        price_difference: u128,
        sqrt_price_before_kriya: u128,
        sqrt_price_after_kriya: u128,
        sqrt_price_before_cetus: u128,
        sqrt_price_after_cetus: u128,
        profit: u64,
        cetus_pool_id: 0x2::object::ID,
        kriya_pool_id: 0x2::object::ID,
        type_x: 0x1::type_name::TypeName,
        type_y: 0x1::type_name::TypeName,
        is_reverse: bool,
    }

    fun calculate_price_diff<T0, T1>(arg0: &0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u64, arg3: bool) : u128 {
        let v0 = 0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::trade::compute_swap_result<T0, T1>(arg0, arg3, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), arg2);
        let v1 = 0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::trade::get_state_sqrt_price(&v0);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg1, !arg3, true, 0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::trade::get_state_amount_calculated(&v0));
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_after_sqrt_price(&v2);
        if (v1 > v3) {
            v1 - v3
        } else {
            v3 - v1
        }
    }

    fun calculate_price_diff_reverse<T0, T1>(arg0: &0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: u64, arg3: bool) : u128 {
        let v0 = 0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::trade::compute_swap_result<T0, T1>(arg0, arg3, true, 0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::math_u128::checked_div_round(340282366920938463463374607431768211455, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg1), true), arg2);
        let v1 = 0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::trade::get_state_sqrt_price(&v0);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T0>(arg1, arg3, true, 0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::trade::get_state_amount_calculated(&v0));
        let v3 = 0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::math_u128::checked_div_round(340282366920938463463374607431768211455, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_after_sqrt_price(&v2), true);
        if (v1 > v3) {
            v1 - v3
        } else {
            v3 - v1
        }
    }

    fun kriya_swap<T0, T1>(arg0: &mut 0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::pool::Pool<T0, T1>, arg1: bool, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::trade::flash_swap<T0, T1>(arg0, arg1, true, arg4, arg5, arg6, arg7, arg8);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let (v6, v7) = 0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::trade::swap_receipt_debts(&v3);
        let v8 = if (arg1) {
            v6
        } else {
            v7
        };
        if (arg1) {
        };
        0x2::coin::join<T0>(arg2, 0x2::coin::from_balance<T0>(v5, arg8));
        0x2::coin::join<T1>(arg3, 0x2::coin::from_balance<T1>(v4, arg8));
        let (v9, v10) = if (arg1) {
            assert!(0x2::coin::value<T0>(arg2) >= v8, 0xfa7d6ef2260f23b1160f92765566b96c62bf0e45b408a1ac6e63f7f00ff8d95::error::insufficient_balance_x());
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, v8, arg8)), 0x2::balance::zero<T1>())
        } else {
            assert!(0x2::coin::value<T1>(arg3) >= v8, 0xfa7d6ef2260f23b1160f92765566b96c62bf0e45b408a1ac6e63f7f00ff8d95::error::insufficient_balance_y());
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg3, v8, arg8)))
        };
        0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::trade::repay_flash_swap<T0, T1>(arg0, v3, v9, v10, arg7, arg8);
    }

    public fun swap_optimal_arb_amount<T0, T1>(arg0: &mut 0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::pool::Pool<T0, T1>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u64, arg3: u128, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::version::Version, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::pool::sqrt_price<T0, T1>(arg0);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v2 = 0x2::object::id<0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::pool::Pool<T0, T1>>(arg0);
        let (v3, v4) = if (v0 > v1) {
            let v5 = 0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::trade::compute_swap_result<T0, T1>(arg0, true, true, v1, 18446744073709551615);
            (true, 18446744073709551615 - 0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::trade::get_state_amount_specified(&v5))
        } else {
            let v6 = 0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::trade::compute_swap_result<T0, T1>(arg0, false, true, v1, 18446744073709551615);
            (false, 18446744073709551615 - 0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::trade::get_state_amount_specified(&v6))
        };
        let v7 = 0;
        let v8 = v4;
        let v9 = 0;
        let v10 = 0;
        let v11 = 0;
        while (v7 <= v8 && v10 < arg2) {
            let v12 = calculate_price_diff<T0, T1>(arg0, arg1, v7, v3);
            let v13 = calculate_price_diff<T0, T1>(arg0, arg1, v8, v3);
            let v14 = (v7 + v8) / 2;
            if (v12 < v13) {
                v8 = v14;
                v9 = v7;
                v11 = v12;
            } else {
                v7 = v14;
                v9 = v4;
                v11 = v13;
            };
            if (v11 < arg3) {
                break
            };
            v10 = v10 + 1;
        };
        let v15 = if (v3) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let (v16, v17, v18) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg4, arg1, v3, false, v9, v15, arg6);
        let v19 = v18;
        let v20 = 0x2::coin::from_balance<T0>(v16, arg7);
        let v21 = 0x2::coin::from_balance<T1>(v17, arg7);
        let v22 = if (v3) {
            4295048017
        } else {
            79226673515401279992447579050
        };
        let v23 = &mut v20;
        let v24 = &mut v21;
        kriya_swap<T0, T1>(arg0, v3, v23, v24, v9, v22, arg6, arg5, arg7);
        let (v25, v26) = if (v3) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v20, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v19), arg7)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v21, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v19), arg7)))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg4, arg1, v25, v26, v19);
        let v27 = if (v3) {
            0x2::coin::value<T1>(&v21)
        } else {
            0x2::coin::value<T0>(&v20)
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v20, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v21, 0x2::tx_context::sender(arg7));
        let v28 = ArbEvent{
            sender                  : 0x2::tx_context::sender(arg7),
            is_x_to_y               : v3,
            swap_amount             : v9,
            iterations              : v10,
            price_difference        : v11,
            sqrt_price_before_kriya : v0,
            sqrt_price_after_kriya  : 0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::pool::sqrt_price<T0, T1>(arg0),
            sqrt_price_before_cetus : v1,
            sqrt_price_after_cetus  : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1),
            profit                  : v27,
            cetus_pool_id           : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            kriya_pool_id           : v2,
            type_x                  : 0x1::type_name::get<T0>(),
            type_y                  : 0x1::type_name::get<T1>(),
            is_reverse              : true,
        };
        0x2::event::emit<ArbEvent>(v28);
    }

    public fun swap_optimal_arb_amount_reverse<T0, T1>(arg0: &mut 0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::pool::Pool<T0, T1>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: u64, arg3: u128, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::version::Version, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::pool::sqrt_price<T0, T1>(arg0);
        let v1 = 0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::math_u128::checked_div_round(340282366920938463463374607431768211455, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg1), true);
        let v2 = 0x2::object::id<0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::pool::Pool<T0, T1>>(arg0);
        let (v3, v4) = if (v0 > v1) {
            let v5 = 0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::trade::compute_swap_result<T0, T1>(arg0, true, true, v1, 18446744073709551615);
            (true, 18446744073709551615 - 0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::trade::get_state_amount_specified(&v5))
        } else {
            let v6 = 0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::trade::compute_swap_result<T0, T1>(arg0, false, true, v1, 18446744073709551615);
            (false, 18446744073709551615 - 0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::trade::get_state_amount_specified(&v6))
        };
        let v7 = 0;
        let v8 = v4;
        let v9 = 0;
        let v10 = 0;
        let v11 = 0;
        while (v7 <= v8 && v10 < arg2) {
            let v12 = calculate_price_diff_reverse<T0, T1>(arg0, arg1, v7, v3);
            let v13 = calculate_price_diff_reverse<T0, T1>(arg0, arg1, v8, v3);
            let v14 = (v7 + v8) / 2;
            if (v12 < v13) {
                v8 = v14;
                v9 = v7;
                v11 = v12;
            } else {
                v7 = v14;
                v9 = v4;
                v11 = v13;
            };
            if (v11 < arg3) {
                break
            };
            v10 = v10 + 1;
        };
        let v15 = if (v3) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let (v16, v17, v18) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg4, arg1, v3, false, v9, v15, arg6);
        let v19 = v18;
        let v20 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v19);
        let v21 = 0x2::coin::from_balance<T1>(v16, arg7);
        let v22 = 0x2::coin::from_balance<T0>(v17, arg7);
        let v23 = if (v3) {
            4295048017
        } else {
            79226673515401279992447579050
        };
        let v24 = &mut v22;
        let v25 = &mut v21;
        kriya_swap<T0, T1>(arg0, v3, v24, v25, v9, v23, arg6, arg5, arg7);
        let (v26, v27) = if (v3) {
            assert!(0x2::coin::value<T1>(&v21) >= v20, 0xfa7d6ef2260f23b1160f92765566b96c62bf0e45b408a1ac6e63f7f00ff8d95::error::insufficient_balance_x_cetus());
            (0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v21, v20, arg7)), 0x2::balance::zero<T0>())
        } else {
            assert!(0x2::coin::value<T0>(&v22) >= v20, 0xfa7d6ef2260f23b1160f92765566b96c62bf0e45b408a1ac6e63f7f00ff8d95::error::insufficient_balance_y_cetus());
            (0x2::balance::zero<T1>(), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v22, v20, arg7)))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg4, arg1, v26, v27, v19);
        let v28 = if (v3) {
            0x2::coin::value<T1>(&v21)
        } else {
            0x2::coin::value<T0>(&v22)
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v21, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v22, 0x2::tx_context::sender(arg7));
        let v29 = ArbEvent{
            sender                  : 0x2::tx_context::sender(arg7),
            is_x_to_y               : v3,
            swap_amount             : v9,
            iterations              : v10,
            price_difference        : v11,
            sqrt_price_before_kriya : v0,
            sqrt_price_after_kriya  : 0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::pool::sqrt_price<T0, T1>(arg0),
            sqrt_price_before_cetus : v1,
            sqrt_price_after_cetus  : 0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::math_u128::checked_div_round(340282366920938463463374607431768211455, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg1), true),
            profit                  : v28,
            cetus_pool_id           : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg1),
            kriya_pool_id           : v2,
            type_x                  : 0x1::type_name::get<T0>(),
            type_y                  : 0x1::type_name::get<T1>(),
            is_reverse              : true,
        };
        0x2::event::emit<ArbEvent>(v29);
    }

    // decompiled from Move bytecode v6
}

