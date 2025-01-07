module 0x54ed634a018904b66871bd30e9b9ccafcf9bfc192aa84c06b0931276c7afd22b::migrate {
    public fun add_final_lp<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg3: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::position::Position, arg4: &0x2::clock::Clock, arg5: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::liquidity::add_liquidity<T0, T1>(arg2, arg3, arg0, arg1, 0, 0, arg4, arg5, arg6)
    }

    public fun fix_add_lp_residual<T0, T1>(arg0: u128, arg1: u128, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::position::Position) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x2::coin::value<T1>(&arg3);
        let v2 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_tick_at_sqrt_price(arg0);
        let v3 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_tick_at_sqrt_price(arg1);
        let v4 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::from(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::tick_spacing<T0, T1>(arg4));
        let v5 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::sub(v3, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::mod(v3, v4));
        let v6 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::sub(v2, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::mod(v2, v4));
        let (v7, v8, v9) = 0x54ed634a018904b66871bd30e9b9ccafcf9bfc192aa84c06b0931276c7afd22b::utils::check_is_fix_coin_a(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_sqrt_price_at_tick(v6), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_sqrt_price_at_tick(v5), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg4), v0, v1);
        let v10 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::liquidity::open_position<T0, T1>(arg4, v6, v5, arg6, arg7);
        if (v7 && v0 > 0 && v1 > 0) {
            let (v11, v12) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::liquidity::add_liquidity<T0, T1>(arg4, &mut v10, arg2, 0x2::coin::split<T1>(&mut arg3, v9, arg7), 0, 0, arg5, arg6, arg7);
            let (v13, _) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::get_optimal_swap_amount_for_single_sided_liquidity<T0, T1>(arg4, 0x2::coin::value<T1>(&arg3), &v10, 79226673515401279992447579054, false, 10);
            return (v11, v12, 0x2::coin::zero<T0>(arg7), arg3, v13, v10)
        };
        if (v0 > 0 && v1 > 0) {
            let (v15, v16) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::liquidity::add_liquidity<T0, T1>(arg4, &mut v10, 0x2::coin::split<T0>(&mut arg2, v8, arg7), arg3, 0, 0, arg5, arg6, arg7);
            let (v17, _) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::get_optimal_swap_amount_for_single_sided_liquidity<T0, T1>(arg4, 0x2::coin::value<T0>(&arg2), &v10, 4295048017, true, 10);
            return (v15, v16, arg2, 0x2::coin::zero<T1>(arg7), v17, v10)
        };
        let v19 = if (v0 == 0) {
            v1
        } else {
            v0
        };
        let v20 = v0 == 0 && false || true;
        let (v21, _) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::get_optimal_swap_amount_for_single_sided_liquidity<T0, T1>(arg4, v19, &v10, 79226673515401279992447579054, v20, 10);
        (0x2::coin::zero<T0>(arg7), 0x2::coin::zero<T1>(arg7), arg2, arg3, v21, v10)
    }

    public fun fix_add_lp_residual_vsui<T0, T1>(arg0: u128, arg1: u128, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock, arg7: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::position::Position) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x2::coin::value<T1>(&arg3);
        let v2 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_tick_at_sqrt_price(arg0);
        let v3 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_tick_at_sqrt_price(arg1);
        let v4 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::from(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::tick_spacing<T0, T1>(arg4));
        let v5 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::sub(v3, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::mod(v3, v4));
        let v6 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::sub(v2, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::mod(v2, v4));
        let (v7, v8, v9) = 0x54ed634a018904b66871bd30e9b9ccafcf9bfc192aa84c06b0931276c7afd22b::utils::check_is_fix_coin_a(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_sqrt_price_at_tick(v6), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_sqrt_price_at_tick(v5), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg4), v0, v1);
        let v10 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::liquidity::open_position<T0, T1>(arg4, v6, v5, arg7, arg8);
        if (v7 && v0 > 0 && v1 > 0) {
            let (v11, v12) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::liquidity::add_liquidity<T0, T1>(arg4, &mut v10, arg2, 0x2::coin::split<T1>(&mut arg3, v9, arg8), 0, 0, arg6, arg7, arg8);
            let (v13, _) = 0x54ed634a018904b66871bd30e9b9ccafcf9bfc192aa84c06b0931276c7afd22b::utils::get_optimal_swap_amount_for_single_sided_liquidity<T0, T1>(arg5, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::as_u32(v6)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::as_u32(v5)), 0x2::coin::value<T1>(&arg3), false, 10);
            return (v11, v12, 0x2::coin::zero<T0>(arg8), arg3, v13, v10)
        };
        if (v0 > 0 && v1 > 0) {
            let (v15, v16) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::liquidity::add_liquidity<T0, T1>(arg4, &mut v10, 0x2::coin::split<T0>(&mut arg2, v8, arg8), arg3, 0, 0, arg6, arg7, arg8);
            let (v17, _) = 0x54ed634a018904b66871bd30e9b9ccafcf9bfc192aa84c06b0931276c7afd22b::utils::get_optimal_swap_amount_for_single_sided_liquidity<T0, T1>(arg5, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::as_u32(v6)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::as_u32(v5)), 0x2::coin::value<T0>(&arg2), true, 10);
            return (v15, v16, arg2, 0x2::coin::zero<T1>(arg8), v17, v10)
        };
        let v19 = if (v0 == 0) {
            v1
        } else {
            v0
        };
        let v20 = v0 == 0 && false || true;
        let (v21, _) = 0x54ed634a018904b66871bd30e9b9ccafcf9bfc192aa84c06b0931276c7afd22b::utils::get_optimal_swap_amount_for_single_sided_liquidity<T0, T1>(arg5, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::as_u32(v6)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::i32::as_u32(v5)), v19, v20, 10);
        (0x2::coin::zero<T0>(arg8), 0x2::coin::zero<T1>(arg8), arg2, arg3, v21, v10)
    }

    // decompiled from Move bytecode v6
}

