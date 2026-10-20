module 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::module_bluefin {
    public(friend) fun collect_reward<T0, T1, T2>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T2> {
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg3, arg2, arg1, arg0)
    }

    public(friend) fun add_liquidity<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::params::OpenParams, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::params::open_fixed_amount(&arg4);
        let v1 = 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::params::open_deduction(&arg4);
        let v2 = 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::params::open_is_fixed_a(&arg4);
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, T1>(arg0);
        let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0);
        let v5 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v4, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mod(v4, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v3)));
        let v6 = 0x2::balance::value<T0>(&arg2);
        let v7 = 0x2::balance::value<T1>(&arg3);
        let (v8, v9) = if (v2) {
            let v10 = if (v0 > 0) {
                v0
            } else {
                assert!(v6 >= v1, 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::error::insufficient_balance_x());
                v6 - v1
            };
            assert!(v6 >= v10, 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::error::insufficient_balance_x());
            (v10, v7)
        } else {
            let v11 = if (v0 > 0) {
                v0
            } else {
                assert!(v7 >= v1, 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::error::insufficient_balance_y());
                v7 - v1
            };
            assert!(v7 >= v11, 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::error::insufficient_balance_y());
            (v6, v11)
        };
        let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg1, arg0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v5, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::params::open_lower_mult(&arg4) * v3))), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v5, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::params::open_upper_mult(&arg4) * v3))), arg6);
        let v13 = if (v2) {
            v8
        } else {
            v9
        };
        let (_, _, v16, v17) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg5, arg1, arg0, &mut v12, arg2, arg3, v13, v2);
        (v12, v16, v17)
    }

    public(friend) fun burn_position<T0, T1>(arg0: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&arg0);
        let (v1, v2) = if (v0 > 0) {
            let (_, _, v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg2, arg1, &mut arg0, v0, arg3);
            (v5, v6)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v7 = v2;
        let v8 = v1;
        let (_, _, v11, v12) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg3, arg2, arg1, &mut arg0);
        0x2::balance::join<T0>(&mut v8, v11);
        0x2::balance::join<T1>(&mut v7, v12);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg3, arg2, arg1, arg0);
        (v8, v7)
    }

    // decompiled from Move bytecode v7
}

