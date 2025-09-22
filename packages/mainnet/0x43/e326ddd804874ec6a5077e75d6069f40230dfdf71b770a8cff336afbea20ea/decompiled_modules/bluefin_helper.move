module 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::bluefin_helper {
    struct OpenParameters has copy, drop {
        pool_id: 0x2::object::ID,
        lower_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        upper_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        coin_a_decimal: u8,
        coin_b_decimal: u8,
        real_price: 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::UQ128_128,
        a2b: bool,
        swap_amount: u128,
        a_position_amount: u128,
        b_position_amount: u128,
    }

    struct PoolStatus has copy, drop {
        pool_id: 0x2::object::ID,
        current_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        current_sqrt_price: u128,
        tick_spacing: u32,
        lower_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        upper_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        current_real_price: 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::UQ128_128,
        deposit_ratio_x: u64,
        deposit_ratio_y: u64,
    }

    public fun collect_reward<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::utils::transfer_balance<T2>(v0, 0x2::tx_context::sender(arg4), arg4);
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
    }

    fun cal_purchase_quantity(arg0: 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::UQ128_128, arg1: 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::UQ128_128, arg2: u64, arg3: u64, arg4: 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::UQ128_128) : (0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::UQ128_128, 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::UQ128_128) {
        let v0 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::from_u64(arg3);
        let v1 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::mul(&arg0, &v0);
        let v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::from_u64(arg2);
        let v3 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::mul(&arg1, &v2);
        let v4 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::add(&v1, &v3);
        let v5 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::zero();
        assert!(!0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::eq(&v4, &v5), 114515);
        let v6 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::from_u64(arg3);
        let v7 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::mul(&arg4, &v6);
        let v8 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::from_u64(arg2);
        let v9 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::mul(&arg4, &v8);
        (0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::div(&v7, &v4), 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::div(&v9, &v4))
    }

    fun cal_xy(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: u128) : (u64, u64) {
        let (_, v1, v2) = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::utils::get_liquidity_by_amount(arg0, arg1, arg2, arg3, 1000000, true);
        (v1, v2)
    }

    public fun calc_open_parameters<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u128, arg2: u128, arg3: u8, arg4: u8, arg5: u128, arg6: bool) : OpenParameters {
        calc_open_parameters_inner(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, T1>(arg0), arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun calc_open_parameters_inner(arg0: 0x2::object::ID, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: u128, arg3: u32, arg4: u128, arg5: u128, arg6: u8, arg7: u8, arg8: u128, arg9: bool) : OpenParameters {
        let (v0, v1) = calc_tick_index(arg1, arg3, 0, 1);
        let v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::utils::sqrt_price_to_price(arg2, arg6, arg7);
        let (v3, v4) = cal_xy(v0, v1, arg1, arg2);
        let v5 = PoolStatus{
            pool_id            : arg0,
            current_tick       : arg1,
            current_sqrt_price : arg2,
            tick_spacing       : arg3,
            lower_tick         : v0,
            upper_tick         : v1,
            current_real_price : v2,
            deposit_ratio_x    : v3,
            deposit_ratio_y    : v4,
        };
        0x2::event::emit<PoolStatus>(v5);
        let v6 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::from_u128(0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::pow(10, (arg6 as u64)));
        let v7 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::from_u128(0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::pow(10, (arg7 as u64)));
        let (v8, v9) = if (arg9) {
            let v10 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::from_u128(arg8);
            let v11 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::div(&v10, &v6);
            let (v12, v13) = cal_purchase_quantity(v2, 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::from_u64(1), v4, v3, 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::mul(&v11, &v2));
            let v9 = v13;
            let v8 = v12;
            (v8, v9)
        } else {
            let v14 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::from_u128(arg8);
            let (v15, v16) = cal_purchase_quantity(v2, 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::from_u64(1), v4, v3, 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::div(&v14, &v7));
            let v9 = v16;
            let v8 = v15;
            (v8, v9)
        };
        let v17 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::mul(&v8, &v7);
        v8 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::div(&v17, &v6);
        let v18 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::mul(&v9, &v6);
        v9 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::div(&v18, &v7);
        let v19 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::mul(&v8, &v6);
        let v20 = arg4 > 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::to_u128(&v19);
        let v21 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::zero();
        let v22 = if (v20) {
            let v23 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::mul(&v9, &v7);
            arg5 < 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::to_u128(&v23)
        } else {
            false
        };
        if (v22) {
            let v24 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::from_u128(arg5);
            let v25 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::div(&v24, &v7);
            let v26 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::diff(&v9, &v25);
            v21 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::div(&v26, &v2);
        } else {
            let v27 = if (!v20) {
                let v28 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::mul(&v8, &v6);
                arg4 < 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::to_u128(&v28)
            } else {
                false
            };
            if (v27) {
                let v29 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::from_u128(arg4);
                let v30 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::div(&v29, &v6);
                let v31 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::diff(&v8, &v30);
                v21 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::mul(&v31, &v2);
            };
        };
        let v32 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::zero();
        let v33 = if (0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::eq(&v21, &v32)) {
            0
        } else if (v20) {
            let v34 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::mul(&v21, &v6);
            0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::to_u128(&v34)
        } else {
            let v35 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::mul(&v21, &v7);
            0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::to_u128(&v35)
        };
        let v36 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::mul(&v8, &v6);
        let v37 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::mul(&v9, &v7);
        OpenParameters{
            pool_id           : arg0,
            lower_tick        : v0,
            upper_tick        : v1,
            coin_a_decimal    : arg6,
            coin_b_decimal    : arg7,
            real_price        : v2,
            a2b               : v20,
            swap_amount       : v33,
            a_position_amount : 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::to_u128(&v36),
            b_position_amount : 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::to_u128(&v37),
        }
    }

    fun calc_tick_index(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: u32, arg2: u32, arg3: u32) : (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg1);
        (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(arg0, v0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::neg_from(arg2)), v0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(arg0, v0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3)), v0))
    }

    public fun close_position_and_try_reopen<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u8, arg7: u8, arg8: u128, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&arg3);
        let (v1, v2) = if (v0 > 0) {
            let (_, _, v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg1, arg2, &mut arg3, v0, arg0);
            (v5, v6)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let (_, _, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg0, arg1, arg2, &mut arg3);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg0, arg1, arg2, arg3);
        let v11 = 0x2::coin::into_balance<T0>(arg4);
        let v12 = 0x2::coin::into_balance<T1>(arg5);
        0x2::balance::join<T0>(&mut v11, v1);
        0x2::balance::join<T1>(&mut v12, v2);
        let v13 = (0x2::balance::join<T0>(&mut v11, v9) as u128);
        let v14 = (0x2::balance::join<T1>(&mut v12, v10) as u128);
        let v15 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::from_u128(0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::pow(10, (arg6 as u64)));
        let v16 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::from_u128(0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::pow(10, (arg7 as u64)));
        let v17 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg2);
        let v18 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg2);
        let (v19, v20) = calc_tick_index(v17, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, T1>(arg2), 0, 1);
        let v21 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::utils::sqrt_price_to_price(v18, arg6, arg7);
        let (_, v23, v24) = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::utils::get_liquidity_by_amount(v19, v20, v17, v18, 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::to_u64(&v15), true);
        let v25 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::from_u64(v23);
        let v26 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::div(&v25, &v15);
        let v27 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::from_u64(v24);
        let v28 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::div(&v26, &v27);
        let v29 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::mul(&v28, &v16);
        let v30 = if (arg9) {
            let v31 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::from_u128(arg8);
            let v32 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::mul(&v31, &v21);
            0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::div(&v32, &v15)
        } else {
            let v33 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::from_u128(arg8);
            0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::div(&v33, &v16)
        };
        let v34 = v30;
        let v35 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::mul(&v21, &v29);
        let v36 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::one();
        let v37 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::add(&v35, &v36);
        let v38 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::div(&v34, &v37);
        let v39 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::mul(&v29, &v38);
        let v40 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::mul(&v39, &v15);
        let v41 = with_position_ratio_u128(0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::to_u128(&v40));
        let v42 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::mul(&v38, &v16);
        let v43 = with_position_ratio_u128(0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::to_u128(&v42));
        let v44 = if (v43 > v14) {
            v43 - v14
        } else if (v41 > v13) {
            v41 - v13
        } else {
            0
        };
        let v45 = OpenParameters{
            pool_id           : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2),
            lower_tick        : v19,
            upper_tick        : v20,
            coin_a_decimal    : arg6,
            coin_b_decimal    : arg7,
            real_price        : v21,
            a2b               : v43 > v14,
            swap_amount       : v44,
            a_position_amount : v41,
            b_position_amount : v43,
        };
        0x2::event::emit<OpenParameters>(v45);
        if (v41 < v13 && v43 < v14) {
            let (v46, v47, v48) = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::utils::get_liquidity_by_amount(v45.lower_tick, v45.upper_tick, v17, v18, (v41 as u64), true);
            let v49 = if (v46 <= 1) {
                true
            } else if (v13 <= (v47 as u128)) {
                true
            } else {
                v14 <= (v48 as u128)
            };
            if (v49) {
                0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::utils::transfer_balance<T0>(v11, 0x2::tx_context::sender(arg10), arg10);
                0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::utils::transfer_balance<T1>(v12, 0x2::tx_context::sender(arg10), arg10);
                return
            };
            let v50 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg1, arg2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v45.lower_tick), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v45.upper_tick), arg10);
            let (_, _, v53, v54) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity<T0, T1>(arg0, arg1, arg2, &mut v50, v11, v12, v46 - 1);
            0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::utils::transfer_balance<T0>(v53, 0x2::tx_context::sender(arg10), arg10);
            0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::utils::transfer_balance<T1>(v54, 0x2::tx_context::sender(arg10), arg10);
            0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v50, 0x2::tx_context::sender(arg10));
        } else {
            0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::utils::transfer_balance<T0>(v11, 0x2::tx_context::sender(arg10), arg10);
            0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::utils::transfer_balance<T1>(v12, 0x2::tx_context::sender(arg10), arg10);
        };
    }

    public fun collect_reward_and_return<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x2::coin::from_balance<T2>(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3), arg4)
    }

    fun with_position_ratio_u128(arg0: u128) : u128 {
        arg0 * 95 / 100
    }

    fun with_position_ratio_u64(arg0: u64) : u64 {
        arg0 * 95 / 100
    }

    // decompiled from Move bytecode v6
}

