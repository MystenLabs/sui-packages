module 0x2dd6d3b8bf01dc879fa48a2632832f188a23ca6dcb2bf02f06de24cfe7f4a371::open_lp_wrapper {
    public fun open_position_with_liquidity_only_b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u32, arg3: u32, arg4: vector<0x2::coin::Coin<T1>>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg0, arg1, arg2, arg3, arg7);
        let v1 = if (0x1::vector::length<0x2::coin::Coin<T1>>(&arg4) == 0) {
            0x2::coin::zero<T1>(arg7)
        } else {
            0x1::vector::pop_back<0x2::coin::Coin<T1>>(&mut arg4)
        };
        let v2 = v1;
        0x2::pay::join_vec<T1>(&mut v2, arg4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v2), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, &mut v0, arg5, false, arg6));
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v0, 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

