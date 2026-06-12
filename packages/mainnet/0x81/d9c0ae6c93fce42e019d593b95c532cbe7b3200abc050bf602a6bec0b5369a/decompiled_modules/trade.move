module 0x97755fb8fc0c33be95c8411de5efd6e8e0d6f151b917f70b8fdcac45dac70c70::trade {
    struct TradeEvent has copy, drop {
        a2b: bool,
        amount_in: u64,
        receive_a: u64,
        receive_b: u64,
        vault_balance_a: u64,
        vault_balance_b: u64,
    }

    public fun pool_fingerprint<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : u128 {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::balances<T0, T1>(arg0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0) ^ 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T1>(arg0) ^ (0x2::balance::value<T0>(v0) as u128) ^ (0x2::balance::value<T1>(v1) as u128)
    }

    public fun trade_cetus_v2<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x97755fb8fc0c33be95c8411de5efd6e8e0d6f151b917f70b8fdcac45dac70c70::vault::Vault, arg4: bool, arg5: u64, arg6: u64, arg7: u128, arg8: &mut 0x2::tx_context::TxContext) {
        if (arg7 > 0) {
            assert!(arg7 == pool_fingerprint<T0, T1>(arg2), 1000);
        };
        let v0 = if (arg5 == 18446744073709551615) {
            let v1 = if (arg4) {
                0x97755fb8fc0c33be95c8411de5efd6e8e0d6f151b917f70b8fdcac45dac70c70::vault::balance_of<T0>(arg3)
            } else {
                0x97755fb8fc0c33be95c8411de5efd6e8e0d6f151b917f70b8fdcac45dac70c70::vault::balance_of<T1>(arg3)
            };
            assert!(v1 > 0, 1001);
            v1
        } else {
            arg5
        };
        let v2 = if (arg4) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price()
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price()
        };
        let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, arg4, true, v0, v2, arg0);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        if (arg6 > 0) {
            let v9 = if (arg4) {
                0x2::balance::value<T1>(&v7)
            } else {
                0x2::balance::value<T0>(&v8)
            };
            assert!(v9 >= arg6, 1002);
        };
        0x97755fb8fc0c33be95c8411de5efd6e8e0d6f151b917f70b8fdcac45dac70c70::vault::deposit_balance<T0>(arg3, v8);
        0x97755fb8fc0c33be95c8411de5efd6e8e0d6f151b917f70b8fdcac45dac70c70::vault::deposit_balance<T1>(arg3, v7);
        let (v10, v11) = if (arg4) {
            (0x97755fb8fc0c33be95c8411de5efd6e8e0d6f151b917f70b8fdcac45dac70c70::vault::take_balance<T0>(arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v6), arg8), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x97755fb8fc0c33be95c8411de5efd6e8e0d6f151b917f70b8fdcac45dac70c70::vault::take_balance<T1>(arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v6), arg8))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, v10, v11, v6);
        let v12 = TradeEvent{
            a2b             : arg4,
            amount_in       : v0,
            receive_a       : 0x2::balance::value<T0>(&v8),
            receive_b       : 0x2::balance::value<T1>(&v7),
            vault_balance_a : 0x97755fb8fc0c33be95c8411de5efd6e8e0d6f151b917f70b8fdcac45dac70c70::vault::balance_of<T0>(arg3),
            vault_balance_b : 0x97755fb8fc0c33be95c8411de5efd6e8e0d6f151b917f70b8fdcac45dac70c70::vault::balance_of<T1>(arg3),
        };
        0x2::event::emit<TradeEvent>(v12);
    }

    // decompiled from Move bytecode v7
}

