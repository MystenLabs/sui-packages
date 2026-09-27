module 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::dae2 {
    fun addr<T0, T1>(arg0: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>) : address {
        0x2::object::id_address<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>>(arg0)
    }

    public fun peek(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = if (arg3 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else {
            arg0 > 2000
        };
        if (v0) {
            return 0
        };
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::math::get_amount_out(arg0, arg3, arg1, arg2)
    }

    public fun r_a2b<T0, T1>(arg0: &mut 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::Session, arg1: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg2: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::take_in<T0>(arg0, arg3);
        if (0x2::balance::value<T0>(&v0) == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::put_out<T1>(arg0, arg3, 0x2::balance::zero<T1>(), addr<T0, T1>(arg2));
            return
        };
        0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::put_out<T1>(arg0, arg3, 0x2::coin::into_balance<T1>(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::router::swap_exact_x_to_y_with_return<T0, T1>(arg1, arg2, 0x2::coin::from_balance<T0>(v0, arg4), 0, arg4)), addr<T0, T1>(arg2));
    }

    public fun r_b2a<T0, T1>(arg0: &mut 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::Session, arg1: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg2: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::take_in<T1>(arg0, arg3);
        if (0x2::balance::value<T1>(&v0) == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::put_out<T0>(arg0, arg3, 0x2::balance::zero<T0>(), addr<T0, T1>(arg2));
            return
        };
        0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::put_out<T0>(arg0, arg3, 0x2::coin::into_balance<T0>(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::router::swap_exact_y_to_x_with_return<T0, T1>(arg1, arg2, 0x2::coin::from_balance<T1>(v0, arg4), 0, arg4)), addr<T0, T1>(arg2));
    }

    // decompiled from Move bytecode v7
}

