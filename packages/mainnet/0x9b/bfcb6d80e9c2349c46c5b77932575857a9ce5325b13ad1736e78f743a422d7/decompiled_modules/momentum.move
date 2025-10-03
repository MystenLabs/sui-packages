module 0x9bbfcb6d80e9c2349c46c5b77932575857a9ce5325b13ad1736e78f743a422d7::momentum {
    public fun swap<T0, T1>(arg0: &mut 0x9bbfcb6d80e9c2349c46c5b77932575857a9ce5325b13ad1736e78f743a422d7::swap_context::SwapContext, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: bool, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg2) {
            swap_a2b<T0, T1>(arg0, arg1, arg3, arg4, arg5);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg3, arg4, arg5);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0x9bbfcb6d80e9c2349c46c5b77932575857a9ce5325b13ad1736e78f743a422d7::swap_context::SwapContext, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9bbfcb6d80e9c2349c46c5b77932575857a9ce5325b13ad1736e78f743a422d7::swap_context::take_balance<T0>(arg0);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v2, v3, v4) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, true, true, v1, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price(), arg3, arg2, arg4);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v4, v0, 0x2::balance::zero<T1>(), arg2, arg4);
        0x9bbfcb6d80e9c2349c46c5b77932575857a9ce5325b13ad1736e78f743a422d7::swap_context::transfer_or_destroy_balance<T0>(v2, arg4);
        0x9bbfcb6d80e9c2349c46c5b77932575857a9ce5325b13ad1736e78f743a422d7::swap_context::merge_balance<T1>(arg0, v3);
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0x9bbfcb6d80e9c2349c46c5b77932575857a9ce5325b13ad1736e78f743a422d7::swap_context::SwapContext, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9bbfcb6d80e9c2349c46c5b77932575857a9ce5325b13ad1736e78f743a422d7::swap_context::take_balance<T1>(arg0);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v2, v3, v4) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, false, true, v1, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_sqrt_price(), arg3, arg2, arg4);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v4, 0x2::balance::zero<T0>(), v0, arg2, arg4);
        0x9bbfcb6d80e9c2349c46c5b77932575857a9ce5325b13ad1736e78f743a422d7::swap_context::transfer_or_destroy_balance<T1>(v3, arg4);
        0x9bbfcb6d80e9c2349c46c5b77932575857a9ce5325b13ad1736e78f743a422d7::swap_context::merge_balance<T0>(arg0, v2);
    }

    // decompiled from Move bytecode v6
}

