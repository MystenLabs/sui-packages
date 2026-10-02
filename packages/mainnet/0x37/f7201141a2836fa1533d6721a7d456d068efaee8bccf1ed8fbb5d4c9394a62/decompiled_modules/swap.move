module 0x37f7201141a2836fa1533d6721a7d456d068efaee8bccf1ed8fbb5d4c9394a62::swap {
    public fun stop(arg0: u128, arg1: u128, arg2: u64, arg3: bool) : u128 {
        let v0 = 0x8408a521b66b063678d501cfb7bf4d532182b20ca7cd54bbb7d100657624d2ce::vault::limit(arg0, arg1, arg2, arg3);
        if (arg3) {
            assert!(v0 < arg1, 1);
            0x1::u128::max(v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price())
        } else {
            assert!(v0 > arg1, 1);
            0x1::u128::min(v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price())
        }
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0x8408a521b66b063678d501cfb7bf4d532182b20ca7cd54bbb7d100657624d2ce::vault::Vault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u128, arg6: u8, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        let (v0, v1) = 0x8408a521b66b063678d501cfb7bf4d532182b20ca7cd54bbb7d100657624d2ce::vault::take<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), arg3, arg4, arg6, arg7, arg8, arg9);
        let v2 = v0;
        let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, arg3, stop(arg5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg2), true), arg8);
        let v6 = v5;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v6)), 0x2::balance::zero<T1>(), v6);
        0x2::balance::join<T0>(&mut v2, v3);
        0x8408a521b66b063678d501cfb7bf4d532182b20ca7cd54bbb7d100657624d2ce::vault::settle<T0, T1>(arg0, v1, v2, v4);
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x8408a521b66b063678d501cfb7bf4d532182b20ca7cd54bbb7d100657624d2ce::vault::Vault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u128, arg6: u8, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        let (v0, v1) = 0x8408a521b66b063678d501cfb7bf4d532182b20ca7cd54bbb7d100657624d2ce::vault::take<T1, T0>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), arg3, arg4, arg6, arg7, arg8, arg9);
        let v2 = v0;
        let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, arg3, stop(arg5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg2), false), arg8);
        let v6 = v5;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v6)), v6);
        0x2::balance::join<T1>(&mut v2, v4);
        0x8408a521b66b063678d501cfb7bf4d532182b20ca7cd54bbb7d100657624d2ce::vault::settle<T1, T0>(arg0, v1, v2, v3);
    }

    // decompiled from Move bytecode v7
}

