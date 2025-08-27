module 0x4ca5dfc9a899761c2fd610459eb19186382799014654a9248b5b603b1a7abc77::swap_router {
    public fun swap_exact_x_to_y<T0, T1>(arg0: &mut 0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::Route, arg1: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg2: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::take_coin_in<T0, T1>(0xc9d17c6b749332a41761f7aa89b32efdd2f18f5bb792a22d4840e326ca4bda20::universal_router::borrow_mut_current_path<T0, T1>(arg0)), @0xbab01303a017de2d7c60b5ae9384e226545d95e6ea86f8fcbf06ed87a07ff65a);
    }

    public fun test() {
    }

    // decompiled from Move bytecode v6
}

