module 0x3b314d2468d261bcbc017fca28266ddd1dd84064ded0e4295026f1106fa348d0::dipcoin {
    public fun swap<T0, T1>(arg0: &mut 0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::SwapContext, arg1: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg2: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg3: bool, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::SwapContext, arg1: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg2: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::take_balance<T0>(arg0, arg3);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let v2 = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::router::swap_exact_x_to_y_with_return<T0, T1>(arg1, arg2, 0x2::coin::from_balance<T0>(v0, arg4), 0, arg4);
        0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v2));
        0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::emit_swap_event<T0, T1>(arg0, b"DIPCOIN", 0x2::object::id<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>>(arg2), v1, 0x2::coin::value<T1>(&v2), 0);
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::SwapContext, arg1: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg2: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::take_balance<T1>(arg0, arg3);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let v2 = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::router::swap_exact_y_to_x_with_return<T0, T1>(arg1, arg2, 0x2::coin::from_balance<T1>(v0, arg4), 0, arg4);
        0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v2));
        0x4a9914d41430f9a8efbdb07c2d7872777fe1ba9d6c7cb0fb6b345fcfe5af5470::router::emit_swap_event<T1, T0>(arg0, b"DIPCOIN", 0x2::object::id<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>>(arg2), v1, 0x2::coin::value<T0>(&v2), 0);
    }

    // decompiled from Move bytecode v7
}

