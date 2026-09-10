module 0xc1c8a42f907ead1e3e4d16e54357b8fb3523adcdf97d3fc7230ad6af79ee4e9a::execution {
    public fun maybe_x_to_y<T0, T1>(arg0: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg1: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg2: 0x1::option::Option<0x2::coin::Coin<T0>>, arg3: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T1>> {
        if (0x1::option::is_none<0x2::coin::Coin<T0>>(&arg2)) {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg2);
            return 0x1::option::none<0x2::coin::Coin<T1>>()
        };
        0x1::option::some<0x2::coin::Coin<T1>>(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::router::swap_exact_x_to_y_with_return<T0, T1>(arg0, arg1, 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg2), 0, arg3))
    }

    public fun maybe_y_to_x<T0, T1>(arg0: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg1: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg2: 0x1::option::Option<0x2::coin::Coin<T1>>, arg3: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0x1::option::is_none<0x2::coin::Coin<T1>>(&arg2)) {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg2);
            return 0x1::option::none<0x2::coin::Coin<T0>>()
        };
        0x1::option::some<0x2::coin::Coin<T0>>(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::router::swap_exact_y_to_x_with_return<T0, T1>(arg0, arg1, 0x1::option::destroy_some<0x2::coin::Coin<T1>>(arg2), 0, arg3))
    }

    // decompiled from Move bytecode v7
}

