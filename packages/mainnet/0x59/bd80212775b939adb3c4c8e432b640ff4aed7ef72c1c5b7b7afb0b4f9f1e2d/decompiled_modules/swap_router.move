module 0x59bd80212775b939adb3c4c8e432b640ff4aed7ef72c1c5b7b7afb0b4f9f1e2d::swap_router {
    public fun swap_exact<T0, T1>(arg0: &mut 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::Route, arg1: &mut 0x863370f42741e28dbe3293276c3477ffa8ef5137c24ccb4c7eeee2eafeb570c0::tide_amm::TidePool, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::borrow_mut_current_path<T0, T1>(arg0);
        let (v1, v2) = 0x863370f42741e28dbe3293276c3477ffa8ef5137c24ccb4c7eeee2eafeb570c0::tide_amm::swap<T0, T1>(arg1, arg4, arg2, arg3, 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::take_coin_in<T0, T1>(v0), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg5));
        0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::fill_coin_out<T0, T1>(v0, v2);
    }

    // decompiled from Move bytecode v6
}

