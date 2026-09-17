module 0x2adec2c6da5d1cb0dcd97f60efd2b8ab04acf3718411935de84b073f7e6e189d::r_dipcoin {
    public fun a2b<T0, T1>(arg0: &mut 0x2adec2c6da5d1cb0dcd97f60efd2b8ab04acf3718411935de84b073f7e6e189d::session::Session, arg1: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg2: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0x2adec2c6da5d1cb0dcd97f60efd2b8ab04acf3718411935de84b073f7e6e189d::session::assert_decided(arg0);
        if (!0x2adec2c6da5d1cb0dcd97f60efd2b8ab04acf3718411935de84b073f7e6e189d::session::armed(arg0)) {
            return
        };
        0x2adec2c6da5d1cb0dcd97f60efd2b8ab04acf3718411935de84b073f7e6e189d::session::put<T1>(arg0, arg3 + 1, 0x2::coin::into_balance<T1>(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::router::swap_exact_x_to_y_with_return<T0, T1>(arg1, arg2, 0x2::coin::from_balance<T0>(0x2adec2c6da5d1cb0dcd97f60efd2b8ab04acf3718411935de84b073f7e6e189d::session::take<T0>(arg0, arg3), arg4), 0, arg4)));
    }

    public fun b2a<T0, T1>(arg0: &mut 0x2adec2c6da5d1cb0dcd97f60efd2b8ab04acf3718411935de84b073f7e6e189d::session::Session, arg1: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg2: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0x2adec2c6da5d1cb0dcd97f60efd2b8ab04acf3718411935de84b073f7e6e189d::session::assert_decided(arg0);
        if (!0x2adec2c6da5d1cb0dcd97f60efd2b8ab04acf3718411935de84b073f7e6e189d::session::armed(arg0)) {
            return
        };
        0x2adec2c6da5d1cb0dcd97f60efd2b8ab04acf3718411935de84b073f7e6e189d::session::put<T0>(arg0, arg3 + 1, 0x2::coin::into_balance<T0>(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::router::swap_exact_y_to_x_with_return<T0, T1>(arg1, arg2, 0x2::coin::from_balance<T1>(0x2adec2c6da5d1cb0dcd97f60efd2b8ab04acf3718411935de84b073f7e6e189d::session::take<T1>(arg0, arg3), arg4), 0, arg4)));
    }

    // decompiled from Move bytecode v7
}

