module 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::module_cetus {
    public(friend) fun collect_reward<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<T2> {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg2, arg1, arg0, arg3, true, arg4)
    }

    public(friend) fun add_liquidity<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x2::balance::Balance<T0>, arg3: &mut 0x2::balance::Balance<T1>, arg4: 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::params::OpenParams, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        let v0 = 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::params::open_fixed_amount(&arg4);
        let v1 = 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::params::open_deduction(&arg4);
        let v2 = 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::params::open_is_fixed_a(&arg4);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg0);
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg0);
        let v5 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v4, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mod(v4, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v3)));
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg1, arg0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v5, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::params::open_lower_mult(&arg4) * v3))), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v5, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::params::open_upper_mult(&arg4) * v3))), arg6);
        let v7 = 0x2::balance::value<T0>(arg2);
        let v8 = 0x2::balance::value<T1>(arg3);
        let v9 = if (v2) {
            let v10 = if (v0 > 0) {
                v0
            } else {
                assert!(v7 > v1, 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::error::insufficient_balance_x());
                v7 - v1
            };
            assert!(v10 > v1, 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::error::insufficient_balance_x());
            v10
        } else {
            let v11 = if (v0 > 0) {
                v0
            } else {
                assert!(v8 > v1, 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::error::insufficient_balance_y());
                v8 - v1
            };
            assert!(v11 > v1, 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::error::insufficient_balance_y());
            v11
        };
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg1, arg0, &mut v6, v9, v2, arg5);
        let (v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v12);
        assert!(v7 > v13, 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::error::insufficient_balance_x());
        assert!(v8 > v14, 0x988209323614b9e6b9424f211ecf982db475b3c32e947263ff05fff939e7febe::error::insufficient_balance_y());
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg1, arg0, 0x2::balance::split<T0>(arg2, v13), 0x2::balance::split<T1>(arg3, v14), v12);
        v6
    }

    public(friend) fun burn_position<T0, T1>(arg0: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg0);
        let (v1, v2) = if (v0 > 0) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg2, arg1, &mut arg0, v0, arg3)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v3 = v2;
        let v4 = v1;
        let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg2, arg1, &arg0, true);
        0x2::balance::join<T0>(&mut v4, v5);
        0x2::balance::join<T1>(&mut v3, v6);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg2, arg1, arg0);
        (v4, v3)
    }

    // decompiled from Move bytecode v7
}

