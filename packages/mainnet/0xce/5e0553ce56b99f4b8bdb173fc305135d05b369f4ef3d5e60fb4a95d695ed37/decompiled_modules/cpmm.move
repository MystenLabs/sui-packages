module 0xce5e0553ce56b99f4b8bdb173fc305135d05b369f4ef3d5e60fb4a95d695ed37::cpmm {
    public fun swap<T0, T1>(arg0: &mut 0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::SwapContext, arg1: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg2: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg3: bool, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::SwapContext, arg1: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg2: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T0>(0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::take_balance<T0>(arg0, arg3), arg4);
        if (0x2::coin::value<T0>(&v0) == 0) {
            0x2::coin::destroy_zero<T0>(v0);
            return
        };
        0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::router::swap_exact_x_to_y_with_return<T0, T1>(arg1, arg2, v0, 0, arg4)));
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::SwapContext, arg1: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg2: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T1>(0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::take_balance<T1>(arg0, arg3), arg4);
        if (0x2::coin::value<T1>(&v0) == 0) {
            0x2::coin::destroy_zero<T1>(v0);
            return
        };
        0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::router::swap_exact_y_to_x_with_return<T0, T1>(arg1, arg2, v0, 0, arg4)));
    }

    // decompiled from Move bytecode v6
}

