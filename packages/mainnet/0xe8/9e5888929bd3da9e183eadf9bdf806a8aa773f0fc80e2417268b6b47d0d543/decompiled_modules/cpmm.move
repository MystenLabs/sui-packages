module 0xe89e5888929bd3da9e183eadf9bdf806a8aa773f0fc80e2417268b6b47d0d543::cpmm {
    public fun swap<T0, T1>(arg0: &mut 0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::SwapContext, arg1: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg2: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg3: bool, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::SwapContext, arg1: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg2: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T0>(0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::take_balance<T0>(arg0, arg3), arg5);
        if (0x2::coin::value<T0>(&v0) == 0) {
            0x2::coin::destroy_zero<T0>(v0);
            return
        };
        0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::router::swap_exact_x_to_y_with_return<T0, T1>(arg1, arg2, v0, 0, arg5)));
        if (arg4) {
            0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::transfer_remaining_balance<T0>(arg0, 0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::take_all_balance<T0>(arg0), arg5);
        };
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::SwapContext, arg1: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg2: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T1>(0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::take_balance<T1>(arg0, arg3), arg5);
        if (0x2::coin::value<T1>(&v0) == 0) {
            0x2::coin::destroy_zero<T1>(v0);
            return
        };
        0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::router::swap_exact_y_to_x_with_return<T0, T1>(arg1, arg2, v0, 0, arg5)));
        if (arg4) {
            0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::transfer_remaining_balance<T1>(arg0, 0xf9a65676145c1c472ac51cd60193e262ddc56c4766d2531fa2c56d09051fc3e7::router::take_all_balance<T1>(arg0), arg5);
        };
    }

    // decompiled from Move bytecode v7
}

