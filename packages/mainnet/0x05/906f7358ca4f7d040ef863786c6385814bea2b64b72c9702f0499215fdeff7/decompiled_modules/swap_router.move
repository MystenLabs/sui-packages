module 0x5906f7358ca4f7d040ef863786c6385814bea2b64b72c9702f0499215fdeff7::swap_router {
    public fun swap_exact_x_to_y<T0>(arg0: &mut 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::Route, arg1: &mut 0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::fun_7k::Configuration, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::borrow_mut_current_path<T0, 0x2::sui::SUI>(arg0);
        let v1 = 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::take_coin_in<T0, 0x2::sui::SUI>(v0);
        0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::utils::refund_if_necessary<T0>(v1, 0x2::tx_context::sender(arg2));
        0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::fill_coin_out<T0, 0x2::sui::SUI>(v0, 0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::fun_7k::sell_<T0>(arg1, &mut v1, true, 0, arg2));
    }

    public fun swap_exact_y_to_x<T0>(arg0: &mut 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::Route, arg1: &mut 0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::fun_7k::Configuration, arg2: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::borrow_mut_current_path<0x2::sui::SUI, T0>(arg0);
        let v1 = 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::take_coin_in<0x2::sui::SUI, T0>(v0);
        let (v2, v3) = 0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::fun_7k::buy_<T0>(arg1, &mut v1, true, 0, arg3, arg2, arg4);
        0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::locked_coin::destroy_zero<T0>(v3);
        0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::utils::refund_if_necessary<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg4));
        0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::fill_coin_out<0x2::sui::SUI, T0>(v0, v2);
    }

    // decompiled from Move bytecode v6
}

