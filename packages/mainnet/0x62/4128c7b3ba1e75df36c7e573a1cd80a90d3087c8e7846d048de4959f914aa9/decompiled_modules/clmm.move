module 0x624128c7b3ba1e75df36c7e573a1cd80a90d3087c8e7846d048de4959f914aa9::clmm {
    public fun swap<T0, T1>(arg0: &mut 0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::SwapContext, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6, arg7);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6, arg7);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::SwapContext, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg3: u64, arg4: &0x2::clock::Clock, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::take_balance<T0>(arg0, arg3);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v2, v3, v4) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg1, true, true, v1, 4295048016, arg4, arg2, arg6);
        0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::merge_balance<T1>(arg0, v3);
        0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::merge_balance<T0>(arg0, v2);
        if (arg5) {
            0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::transfer_remaining_balance<T0>(arg0, 0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::take_all_balance<T0>(arg0), arg6);
        };
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg1, v4, v0, 0x2::balance::zero<T1>(), arg2, arg6);
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::SwapContext, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg3: u64, arg4: &0x2::clock::Clock, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::take_balance<T1>(arg0, arg3);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v2, v3, v4) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg1, false, true, v1, 79226673515401279992447579055, arg4, arg2, arg6);
        0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::merge_balance<T0>(arg0, v2);
        0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::merge_balance<T1>(arg0, v3);
        if (arg5) {
            0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::transfer_remaining_balance<T1>(arg0, 0x7227857520814ecd8c3337ed52dfd1192a2504adae98f193f5d9523db3a256f::router::take_all_balance<T1>(arg0), arg6);
        };
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg1, v4, 0x2::balance::zero<T0>(), v0, arg2, arg6);
    }

    // decompiled from Move bytecode v7
}

