module 0x7d371d7bc2f90300b1782a657f1f1aab41fa6288991d4cf408b0e79c53642a7::prop_amm {
    public fun swap<T0, T1>(arg0: &mut 0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::SwapContext, arg1: &mut 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg2) {
            swap_a2b<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::SwapContext, arg1: &mut 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::take_balance<T0>(arg0, arg2);
        if (0x2::balance::value<T0>(&v0) == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v1, v2) = 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::swap_x_2_y<T0, T1>(arg1, 0, v0, arg3, arg5);
        0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::merge_balance<T0>(arg0, v1);
        if (arg4) {
            0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::transfer_remaining_balance<T0>(arg0, 0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::take_all_balance<T0>(arg0), arg5);
        };
        0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::merge_balance<T1>(arg0, v2);
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::SwapContext, arg1: &mut 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::take_balance<T1>(arg0, arg2);
        if (0x2::balance::value<T1>(&v0) == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v1, v2) = 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::swap_y_2_x<T0, T1>(arg1, 0, v0, arg3, arg5);
        0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::merge_balance<T1>(arg0, v2);
        if (arg4) {
            0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::transfer_remaining_balance<T1>(arg0, 0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::take_all_balance<T1>(arg0), arg5);
        };
        0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::merge_balance<T0>(arg0, v1);
    }

    // decompiled from Move bytecode v7
}

