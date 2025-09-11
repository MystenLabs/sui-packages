module 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::bluefin_helper {
    struct OpenParameters<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        lower_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        upper_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        coin_a_decimal: u8,
        coin_b_decimal: u8,
        real_price: 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::UQ128_128,
        a2b: bool,
        swap_amount: u128,
        a_position_amount: u128,
        b_position_amount: u128,
    }

    public fun collect_reward<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3);
        if (0x2::balance::value<T2>(&v0) > 0) {
            0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::utils::transfer_balance<T2>(v0, 0x2::tx_context::sender(arg4), arg4);
        } else {
            0x2::balance::destroy_zero<T2>(v0);
        };
    }

    fun cal_purchase_quantity(arg0: 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::UQ128_128, arg1: 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::UQ128_128, arg2: u64, arg3: u64, arg4: 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::UQ128_128) : (0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::UQ128_128, 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::UQ128_128) {
        let v0 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::from_u64(arg3);
        let v1 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::mul(&arg0, &v0);
        let v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::from_u64(arg2);
        let v3 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::mul(&arg1, &v2);
        let v4 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::add(&v1, &v3);
        let v5 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::zero();
        assert!(0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::eq(&v4, &v5), 114515);
        let v6 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::from_u64(arg3);
        let v7 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::mul(&arg4, &v6);
        let v8 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::from_u64(arg2);
        let v9 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::mul(&arg4, &v8);
        (0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::div(&v7, &v4), 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::div(&v9, &v4))
    }

    fun cal_xy(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: u128) : (u64, u64) {
        let (_, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_liquidity_by_amount(arg0, arg1, arg2, arg3, 1000000, true);
        (v1, v2)
    }

    public fun calc_open_parameters<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u128, arg2: u128, arg3: u8, arg4: u8, arg5: u128, arg6: bool) : OpenParameters<T0, T1> {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0);
        let (v2, v3) = calc_tick_index(v0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, T1>(arg0), 0, 1);
        let v4 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::utils::sqrt_price_to_price(v1, arg3, arg4);
        let (v5, v6) = cal_xy(v2, v3, v0, v1);
        let v7 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::from_u128(0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::pow(10, (arg3 as u64)));
        let v8 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::from_u128(0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::pow(10, (arg4 as u64)));
        let (v9, v10) = if (arg6) {
            let v11 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::from_u128(arg5);
            let v12 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::div(&v11, &v7);
            let (v13, v14) = cal_purchase_quantity(v4, 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::from_u64(1), v6, v5, 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::mul(&v12, &v4));
            let v10 = v14;
            let v9 = v13;
            (v9, v10)
        } else {
            let v15 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::from_u128(arg5);
            let (v16, v17) = cal_purchase_quantity(v4, 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::from_u64(1), v6, v5, 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::div(&v15, &v8));
            let v10 = v17;
            let v9 = v16;
            (v9, v10)
        };
        let v18 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::mul(&v9, &v7);
        let v19 = arg1 > 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::to_u128(&v18);
        let v20 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::zero();
        let v21 = if (v19) {
            let v22 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::mul(&v10, &v8);
            arg2 < 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::to_u128(&v22)
        } else {
            false
        };
        if (v21) {
            let v23 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::from_u128(arg2);
            let v24 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::div(&v23, &v8);
            let v25 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::diff(&v10, &v24);
            v20 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::div(&v25, &v4);
        } else {
            let v26 = if (!v19) {
                let v27 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::mul(&v9, &v7);
                arg1 < 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::to_u128(&v27)
            } else {
                false
            };
            if (v26) {
                let v28 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::from_u128(arg1);
                let v29 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::div(&v28, &v7);
                let v30 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::diff(&v9, &v29);
                v20 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::mul(&v30, &v4);
            };
        };
        let v31 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::zero();
        let v32 = if (0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::eq(&v20, &v31)) {
            0
        } else if (v19) {
            let v33 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::mul(&v20, &v7);
            0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::to_u128(&v33)
        } else {
            let v34 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::mul(&v20, &v8);
            0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::to_u128(&v34)
        };
        let v35 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::mul(&v9, &v7);
        let v36 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::mul(&v10, &v8);
        OpenParameters<T0, T1>{
            pool_id           : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg0),
            lower_tick        : v2,
            upper_tick        : v3,
            coin_a_decimal    : arg3,
            coin_b_decimal    : arg4,
            real_price        : v4,
            a2b               : v19,
            swap_amount       : v32,
            a_position_amount : 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::to_u128(&v35),
            b_position_amount : 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::to_u128(&v36),
        }
    }

    fun calc_tick_index(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: u32, arg2: u32, arg3: u32) : (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg1);
        (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(arg0, v0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::neg_from(arg2)), v0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(arg0, v0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3)), v0))
    }

    public fun collect_reward_and_return<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x2::coin::from_balance<T2>(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3), arg4)
    }

    // decompiled from Move bytecode v6
}

