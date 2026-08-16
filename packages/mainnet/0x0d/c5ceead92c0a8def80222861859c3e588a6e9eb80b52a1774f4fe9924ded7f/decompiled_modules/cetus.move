module 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::cetus {
    fun eval<T0, T1, T2>(arg0: &mut 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::Plan<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: u64, arg3: bool) {
        let v0 = 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::hop_inputs<T0>(arg0, arg2);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&v0)) {
            let v3 = *0x1::vector::borrow<u64>(&v0, v2);
            let v4 = if (v3 == 0) {
                0
            } else {
                let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T2>(arg1, arg3, true, v3);
                if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v5)) {
                    0
                } else {
                    0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v5)
                }
            };
            0x1::vector::push_back<u64>(&mut v1, v4);
            v2 = v2 + 1;
        };
        0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::record_hop<T0>(arg0, arg2, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg1), v1);
    }

    public fun eval_a2b<T0, T1, T2>(arg0: &mut 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::Plan<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: u64) {
        eval<T0, T1, T2>(arg0, arg1, arg2, true);
    }

    public fun eval_b2a<T0, T1, T2>(arg0: &mut 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::Plan<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: u64) {
        eval<T0, T1, T2>(arg0, arg1, arg2, false);
    }

    public fun swap_a2b<T0, T1, T2>(arg0: &mut 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::Plan<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: u64, arg4: 0x2::balance::Balance<T1>, arg5: &0x2::clock::Clock) : 0x2::balance::Balance<T2> {
        if (!0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::is_selected<T0>(arg0, arg3)) {
            0x2::balance::destroy_zero<T1>(arg4);
            return 0x2::balance::zero<T2>()
        };
        0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::advance<T0>(arg0, arg3, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2));
        let v0 = 0x2::balance::value<T1>(&arg4);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg1, arg2, true, true, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price() + 1, arg5);
        let v4 = v3;
        0x2::balance::destroy_zero<T1>(v1);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v4) == v0, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg1, arg2, arg4, 0x2::balance::zero<T2>(), v4);
        v2
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &mut 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::Plan<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: u64, arg4: 0x2::balance::Balance<T2>, arg5: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        if (!0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::is_selected<T0>(arg0, arg3)) {
            0x2::balance::destroy_zero<T2>(arg4);
            return 0x2::balance::zero<T1>()
        };
        0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::plan::advance<T0>(arg0, arg3, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg2));
        let v0 = 0x2::balance::value<T2>(&arg4);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg1, arg2, false, true, v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price() - 1, arg5);
        let v4 = v3;
        0x2::balance::destroy_zero<T2>(v2);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v4) == v0, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg1, arg2, 0x2::balance::zero<T1>(), arg4, v4);
        v1
    }

    // decompiled from Move bytecode v7
}

