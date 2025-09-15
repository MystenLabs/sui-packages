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

    struct PoolStatus<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        current_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        current_sqrt_price: u128,
        tick_spacing: u32,
        lower_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        upper_tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        current_real_price: 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::UQ128_128,
        deposit_ratio_x: u64,
        deposit_ratio_y: u64,
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
        let v0 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg0);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0);
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0);
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, T1>(arg0);
        let (v4, v5) = calc_tick_index(v1, v3, 0, 1);
        let v6 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::utils::sqrt_price_to_price(v2, arg3, arg4);
        let (v7, v8) = cal_xy(v4, v5, v1, v2);
        let v9 = PoolStatus<T0, T1>{
            pool_id            : v0,
            current_tick       : v1,
            current_sqrt_price : v2,
            tick_spacing       : v3,
            lower_tick         : v4,
            upper_tick         : v5,
            current_real_price : v6,
            deposit_ratio_x    : v7,
            deposit_ratio_y    : v8,
        };
        0x2::event::emit<PoolStatus<T0, T1>>(v9);
        let v10 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::from_u128(0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::pow(10, (arg3 as u64)));
        let v11 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::from_u128(0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::pow(10, (arg4 as u64)));
        let (v12, v13) = if (arg6) {
            let v14 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::from_u128(arg5);
            let v15 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::div(&v14, &v10);
            let (v16, v17) = cal_purchase_quantity(v6, 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::from_u64(1), v8, v7, 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::mul(&v15, &v6));
            let v13 = v17;
            let v12 = v16;
            (v12, v13)
        } else {
            let v18 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::from_u128(arg5);
            let (v19, v20) = cal_purchase_quantity(v6, 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::from_u64(1), v8, v7, 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::div(&v18, &v11));
            let v13 = v20;
            let v12 = v19;
            (v12, v13)
        };
        let v21 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::mul(&v12, &v10);
        let v22 = arg1 > 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::to_u128(&v21);
        let v23 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::zero();
        let v24 = if (v22) {
            let v25 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::mul(&v13, &v11);
            arg2 < 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::to_u128(&v25)
        } else {
            false
        };
        if (v24) {
            let v26 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::from_u128(arg2);
            let v27 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::div(&v26, &v11);
            let v28 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::diff(&v13, &v27);
            v23 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::div(&v28, &v6);
        } else {
            let v29 = if (!v22) {
                let v30 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::mul(&v12, &v10);
                arg1 < 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::to_u128(&v30)
            } else {
                false
            };
            if (v29) {
                let v31 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::from_u128(arg1);
                let v32 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::div(&v31, &v10);
                let v33 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::diff(&v12, &v32);
                v23 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::mul(&v33, &v6);
            };
        };
        let v34 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::zero();
        let v35 = if (0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::eq(&v23, &v34)) {
            0
        } else if (v22) {
            let v36 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::mul(&v23, &v10);
            0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::to_u128(&v36)
        } else {
            let v37 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::mul(&v23, &v11);
            0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::to_u128(&v37)
        };
        let v38 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::mul(&v12, &v10);
        let v39 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::mul(&v13, &v11);
        let v40 = OpenParameters<T0, T1>{
            pool_id           : v0,
            lower_tick        : v4,
            upper_tick        : v5,
            coin_a_decimal    : arg3,
            coin_b_decimal    : arg4,
            real_price        : v6,
            a2b               : v22,
            swap_amount       : v35,
            a_position_amount : 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::to_u128(&v38),
            b_position_amount : 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::to_u128(&v39),
        };
        0x2::event::emit<OpenParameters<T0, T1>>(v40);
        v40
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

