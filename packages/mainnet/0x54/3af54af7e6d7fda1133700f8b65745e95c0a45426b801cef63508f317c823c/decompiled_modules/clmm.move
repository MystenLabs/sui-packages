module 0x543af54af7e6d7fda1133700f8b65745e95c0a45426b801cef63508f317c823c::clmm {
    public fun swap<T0, T1>(arg0: &mut 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::SwapContext, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: bool, arg3: u64, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg2) {
            swap_a2b<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::SwapContext, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: u64, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::take_balance<T0>(arg0, arg2);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v2, v3, v4) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, true, true, v1, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price(), arg4, arg3, arg5);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v4, v0, 0x2::balance::zero<T1>(), arg3, arg5);
        if (arg2 == 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::max_amount_in()) {
            0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::transfer_remaining_balance<T0>(arg0, v2, arg5);
        } else {
            0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::merge_balance<T0>(arg0, v2);
        };
        0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::merge_balance<T1>(arg0, v3);
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::SwapContext, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: u64, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::take_balance<T1>(arg0, arg2);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v2, v3, v4) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, false, true, v1, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_sqrt_price(), arg4, arg3, arg5);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v4, 0x2::balance::zero<T0>(), v0, arg3, arg5);
        if (arg2 == 0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::max_amount_in()) {
            0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::transfer_remaining_balance<T1>(arg0, v3, arg5);
        } else {
            0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::merge_balance<T1>(arg0, v3);
        };
        0x4dea343c9fe65d83b514a8520fdc619464be1debf598ad1e60f19b513cddb204::router::merge_balance<T0>(arg0, v2);
    }

    // decompiled from Move bytecode v7
}

