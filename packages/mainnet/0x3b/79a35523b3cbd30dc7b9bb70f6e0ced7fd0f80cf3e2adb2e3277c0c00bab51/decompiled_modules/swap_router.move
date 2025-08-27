module 0x3b79a35523b3cbd30dc7b9bb70f6e0ced7fd0f80cf3e2adb2e3277c0c00bab51::swap_router {
    public fun swap_exact_x_to_y<T0, T1>(arg0: &mut 0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::Route, arg1: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg2: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::borrow_mut_current_path<T0, T1>(arg0);
        0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::fill_coin_out<T0, T1>(v0, 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::router::swap_exact_x_to_y_with_return<T0, T1>(arg1, arg2, 0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::take_coin_in<T0, T1>(v0), 0, arg3));
    }

    public fun swap_exact_y_to_x<T0, T1>(arg0: &mut 0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::Route, arg1: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg2: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::borrow_mut_current_path<T1, T0>(arg0);
        0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::fill_coin_out<T1, T0>(v0, 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::router::swap_exact_y_to_x_with_return<T0, T1>(arg1, arg2, 0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::take_coin_in<T1, T0>(v0), 0, arg3));
    }

    // decompiled from Move bytecode v6
}

