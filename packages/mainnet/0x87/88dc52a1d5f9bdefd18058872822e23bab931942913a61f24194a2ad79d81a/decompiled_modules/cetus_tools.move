module 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_tools {
    public(friend) fun get_balances_in_ratio<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u32, arg2: u32, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: bool) : (u128, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg1);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg2);
        if (0x2::balance::value<T0>(&arg3) == 0 || 0x2::balance::value<T1>(&arg4) == 0) {
            (0, 0x2::balance::zero<T0>(), 0x2::balance::zero<T1>(), arg3, arg4)
        } else {
            let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v0, v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0), 0x2::balance::value<T0>(&arg3), true);
            let v8 = 0x2::balance::value<T1>(&arg4);
            let (v9, v10, v11) = if (v7 <= v8) {
                if (!arg5) {
                    assert!(((v8 - v7) as u128) * 1000000000 / (v8 as u128) <= 2000000, 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::error::difference_too_high());
                };
                (v5, 0x2::balance::split<T0>(&mut arg3, v6), 0x2::balance::split<T1>(&mut arg4, v7))
            } else {
                let (v12, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v0, v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0), 0x2::balance::value<T1>(&arg4), false);
                let v15 = v13;
                let v16 = 0x2::balance::value<T0>(&arg3);
                assert!(v13 <= v16, 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::error::insufficient_balance_to_add_liquidity());
                if (!arg5) {
                    assert!(((v16 - v13) as u128) * 1000000000 / (v16 as u128) <= 2000000, 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::error::difference_too_high());
                };
                if (v13 > 1) {
                    v15 = v13 - 1;
                };
                (v12, 0x2::balance::split<T0>(&mut arg3, v15), 0x2::balance::split<T1>(&mut arg4, v14))
            };
            (v9, v10, v11, arg3, arg4)
        }
    }

    public(friend) fun get_price_lower_end_by_amount_b(arg0: u128, arg1: u64, arg2: u128) : u128 {
        if (arg1 == 0 || arg2 == 0) {
            return 0
        };
        arg0 - ((((arg1 as u256) << 64) / (arg2 as u256)) as u128)
    }

    public(friend) fun get_price_upper_end_by_amount_a(arg0: u128, arg1: u64, arg2: u128) : u128 {
        if (arg1 == 0 || arg2 == 0) {
            return 0
        };
        let v0 = (arg2 as u256) << 64;
        (((arg0 as u256) * v0 / (v0 - (arg1 as u256) * (arg0 as u256))) as u128)
    }

    // decompiled from Move bytecode v6
}

