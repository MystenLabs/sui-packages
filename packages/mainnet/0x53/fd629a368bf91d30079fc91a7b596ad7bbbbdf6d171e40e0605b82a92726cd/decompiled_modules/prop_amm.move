module 0x53fd629a368bf91d30079fc91a7b596ad7bbbbdf6d171e40e0605b82a92726cd::prop_amm {
    public fun swap<T0, T1>(arg0: &mut 0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::SwapContext, arg1: &mut 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg2) {
            swap_a2b<T0, T1>(arg0, arg1, arg3, arg4, arg5);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg3, arg4, arg5);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::SwapContext, arg1: &mut 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::take_balance<T0>(arg0, arg2);
        if (0x2::balance::value<T0>(&v0) == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v1, v2) = 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::swap_x_2_y<T0, T1>(arg1, 0, v0, arg3, arg4);
        if (arg2 == 0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::max_amount_in()) {
            0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::transfer_remaining_balance<T0>(arg0, v1, arg4);
        } else {
            0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::merge_balance<T0>(arg0, v1);
        };
        0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::merge_balance<T1>(arg0, v2);
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::SwapContext, arg1: &mut 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::take_balance<T1>(arg0, arg2);
        if (0x2::balance::value<T1>(&v0) == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v1, v2) = 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::swap_y_2_x<T0, T1>(arg1, 0, v0, arg3, arg4);
        if (arg2 == 0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::max_amount_in()) {
            0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::transfer_remaining_balance<T1>(arg0, v2, arg4);
        } else {
            0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::merge_balance<T1>(arg0, v2);
        };
        0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::merge_balance<T0>(arg0, v1);
    }

    // decompiled from Move bytecode v7
}

