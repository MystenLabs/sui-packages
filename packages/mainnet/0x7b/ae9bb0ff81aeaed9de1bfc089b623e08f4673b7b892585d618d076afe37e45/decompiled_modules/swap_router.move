module 0x7bae9bb0ff81aeaed9de1bfc089b623e08f4673b7b892585d618d076afe37e45::swap_router {
    public fun swap_exact_input<T0, T1>(arg0: &mut 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::Route, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::borrow_mut_current_path<T0, T1>(arg0);
        0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::fill_coin_out<T0, T1>(v0, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, T1>(arg1, 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::universal_router::take_coin_in<T0, T1>(v0), arg2));
    }

    // decompiled from Move bytecode v6
}

