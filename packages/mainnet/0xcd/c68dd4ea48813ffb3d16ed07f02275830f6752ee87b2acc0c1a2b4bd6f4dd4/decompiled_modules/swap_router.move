module 0xcdc68dd4ea48813ffb3d16ed07f02275830f6752ee87b2acc0c1a2b4bd6f4dd4::swap_router {
    public fun swap_exact_x_to_y<T0, T1>(arg0: &mut 0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::Route, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::borrow_mut_current_path<T0, T1>(arg0);
        let v1 = 0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::take_coin_in<T0, T1>(v0);
        0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::fill_coin_out<T0, T1>(v0, 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_x<T0, T1>(arg1, v1, 0x2::coin::value<T0>(&v1), 0, arg2));
    }

    public fun swap_exact_y_to_x<T0, T1>(arg0: &mut 0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::Route, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::borrow_mut_current_path<T1, T0>(arg0);
        let v1 = 0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::take_coin_in<T1, T0>(v0);
        0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::fill_coin_out<T1, T0>(v0, 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_y<T0, T1>(arg1, v1, 0x2::coin::value<T1>(&v1), 0, arg2));
    }

    // decompiled from Move bytecode v6
}

