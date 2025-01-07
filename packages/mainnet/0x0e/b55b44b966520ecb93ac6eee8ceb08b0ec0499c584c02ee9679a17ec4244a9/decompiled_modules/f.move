module 0x9a0501c340c8fca6cbc7666e62e730c105db6f291beabb5c53ae35a8ba4591fa::f {
    fun cetus_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: bool, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = if (arg4) {
            0x2::coin::value<T0>(&arg2)
        } else {
            0x2::coin::value<T1>(&arg3)
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, arg5, v0, arg6, arg7);
        let v4 = v3;
        let (v5, v6) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4), arg8)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4), arg8)))
        };
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v1, arg8));
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v2, arg8));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v5, v6, v4);
        (arg2, arg3)
    }

    public fun doushiwode<T0, T1, T2>(arg0: &0x9a0501c340c8fca6cbc7666e62e730c105db6f291beabb5c53ae35a8ba4591fa::c::G, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x9a0501c340c8fca6cbc7666e62e730c105db6f291beabb5c53ae35a8ba4591fa::c::ca1(arg0, 0x2::tx_context::sender(arg7));
        let (v0, v1, v2) = youjie<T1, T2>(arg1, arg4, false, true, arg5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg6, arg7);
        let v3 = 0x2::coin::zero<T0>(arg7);
        let (v4, v5) = cetus_swap<T0, T1>(arg1, arg2, v3, v0, false, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg6, arg7);
        let (v6, v7) = cetus_swap<T0, T2>(arg1, arg3, v4, v1, true, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg6, arg7);
        let (v8, v9) = cetus_swap<T1, T2>(arg1, arg4, v5, v7, false, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg6, arg7);
        let (v10, v11) = youhuan<T1, T2>(arg1, arg4, true, v8, v9, v2, arg7);
        shengxiaguiwo<T0>(v6, arg7);
        shengxiaguiwo<T1>(v10, arg7);
        shengxiaguiwo<T2>(v11, arg7);
    }

    public fun doushiwode2<T0, T1, T2>(arg0: &0x9a0501c340c8fca6cbc7666e62e730c105db6f291beabb5c53ae35a8ba4591fa::c::G, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x9a0501c340c8fca6cbc7666e62e730c105db6f291beabb5c53ae35a8ba4591fa::c::ca1(arg0, 0x2::tx_context::sender(arg7));
        let (v0, v1, v2) = youjie<T1, T2>(arg1, arg4, false, true, arg5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg6, arg7);
        let v3 = 0x2::coin::zero<T0>(arg7);
        let (v4, v5) = cetus_swap<T0, T1>(arg1, arg2, v3, v0, false, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg6, arg7);
        let (v6, v7) = cetus_swap<T0, T2>(arg1, arg3, v4, v1, true, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg6, arg7);
        let (v8, v9) = youhuan<T1, T2>(arg1, arg4, false, v5, v7, v2, arg7);
        shengxiaguiwo<T0>(v6, arg7);
        shengxiaguiwo<T1>(v8, arg7);
        shengxiaguiwo<T2>(v9, arg7);
    }

    public fun doushiwode3<T0, T1, T2>(arg0: &0x9a0501c340c8fca6cbc7666e62e730c105db6f291beabb5c53ae35a8ba4591fa::c::G, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x9a0501c340c8fca6cbc7666e62e730c105db6f291beabb5c53ae35a8ba4591fa::c::ca1(arg0, 0x2::tx_context::sender(arg7));
        let (v0, v1, v2) = youjie<T0, T2>(arg1, arg3, false, true, arg5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg6, arg7);
        let v3 = 0x2::coin::zero<T1>(arg7);
        let (v4, v5) = cetus_swap<T0, T1>(arg1, arg2, v0, v3, true, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg6, arg7);
        let (v6, v7) = cetus_swap<T1, T2>(arg1, arg4, v5, v1, true, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg6, arg7);
        let (v8, v9) = youhuan<T0, T2>(arg1, arg3, false, v4, v7, v2, arg7);
        shengxiaguiwo<T0>(v8, arg7);
        shengxiaguiwo<T2>(v9, arg7);
        shengxiaguiwo<T1>(v6, arg7);
    }

    public fun shengxiaguiwo<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    fun youhuan<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&arg5);
        let (v1, v2) = if (arg2) {
            assert!(0x2::coin::value<T0>(&arg3) > v0, 0);
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v0, arg6)), 0x2::balance::zero<T1>())
        } else {
            assert!(0x2::coin::value<T1>(&arg4) > v0, 0);
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, v0, arg6)))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v1, v2, arg5);
        (arg3, arg4)
    }

    fun youjie<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool, arg3: bool, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        (0x2::coin::from_balance<T0>(v0, arg7), 0x2::coin::from_balance<T1>(v1, arg7), v2)
    }

    // decompiled from Move bytecode v6
}

