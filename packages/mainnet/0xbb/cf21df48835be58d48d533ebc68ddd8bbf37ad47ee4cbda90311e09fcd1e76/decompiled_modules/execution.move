module 0xbbcf21df48835be58d48d533ebc68ddd8bbf37ad47ee4cbda90311e09fcd1e76::execution {
    public fun maybe_x_to_y<T0, T1, T2>(arg0: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg1: 0x1::option::Option<0x2::coin::Coin<T0>>, arg2: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T1>> {
        if (0x1::option::is_none<0x2::coin::Coin<T0>>(&arg1)) {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg1);
            return 0x1::option::none<0x2::coin::Coin<T1>>()
        };
        assert!(0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::is_uncorrelated<T2>() || 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::is_stable<T2>(), 2);
        0x1::option::some<0x2::coin::Coin<T1>>(0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::router::swap_exact_coin_x_for_coin_y<T0, T1, T2>(arg0, 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg1), 0, arg2))
    }

    public fun maybe_y_to_x<T0, T1, T2>(arg0: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg1: 0x1::option::Option<0x2::coin::Coin<T1>>, arg2: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0x1::option::is_none<0x2::coin::Coin<T1>>(&arg1)) {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg1);
            return 0x1::option::none<0x2::coin::Coin<T0>>()
        };
        assert!(0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::is_uncorrelated<T2>() || 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::is_stable<T2>(), 2);
        0x1::option::some<0x2::coin::Coin<T0>>(0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::router::swap_exact_coin_y_for_coin_x<T0, T1, T2>(arg0, 0x1::option::destroy_some<0x2::coin::Coin<T1>>(arg1), 0, arg2))
    }

    // decompiled from Move bytecode v7
}

