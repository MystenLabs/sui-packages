module 0xa404446257c43b02a7f1f59424ff760b956b087481b3e88e4e6ae696bce5e89a::swap_router {
    public fun swap_exact_x_to_y<T0, T1>(arg0: &mut 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::Route, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg4: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg5: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::borrow_mut_current_path<T0, T1>(arg0);
        let v1 = 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::take_coin_in<T0, T1>(v0);
        let (v2, v3, v4) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg1, arg2, arg3, true, true, 0x2::coin::value<T0>(&v1), arg6, arg4, arg5, arg7);
        let v5 = v4;
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg1, arg3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v1, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::swap_pay_amount<T0, T1>(&v5), arg8)), 0x2::balance::zero<T1>(), v5);
        0x2::coin::join<T0>(&mut v1, 0x2::coin::from_balance<T0>(v2, arg8));
        0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::utils::refund_if_necessary<T0>(v1, 0x2::tx_context::sender(arg8));
        0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::fill_coin_out<T0, T1>(v0, 0x2::coin::from_balance<T1>(v3, arg8));
    }

    public fun swap_exact_y_to_x<T0, T1>(arg0: &mut 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::Route, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg4: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg5: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::borrow_mut_current_path<T1, T0>(arg0);
        let v1 = 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::take_coin_in<T1, T0>(v0);
        let (v2, v3, v4) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg1, arg2, arg3, false, true, 0x2::coin::value<T1>(&v1), arg6, arg4, arg5, arg7);
        let v5 = v4;
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg1, arg3, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v1, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::swap_pay_amount<T0, T1>(&v5), arg8)), v5);
        0x2::coin::join<T1>(&mut v1, 0x2::coin::from_balance<T1>(v3, arg8));
        0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::utils::refund_if_necessary<T1>(v1, 0x2::tx_context::sender(arg8));
        0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::fill_coin_out<T1, T0>(v0, 0x2::coin::from_balance<T0>(v2, arg8));
    }

    // decompiled from Move bytecode v6
}

