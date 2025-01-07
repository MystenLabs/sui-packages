module 0x705b7644364a8d1c04425da3cb8eea8cdc28f58bb2c1cb8f438e4888b8de3178::router {
    struct BaySwapRouterWrapper has store, key {
        id: 0x2::object::UID,
    }

    public fun swap_exact_coin_x_for_coin_y<T0, T1, T2, T3>(arg0: &mut BaySwapRouterWrapper, arg1: &mut 0xdc15721baa82ba64822d585a7349a1508f76d94ae80e899b06e48369c257750e::swap_cap::RouterSwapCap<T0>, arg2: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xdc15721baa82ba64822d585a7349a1508f76d94ae80e899b06e48369c257750e::swap_cap::assert_valid_swap<T0, T1>(arg1, &arg3);
        let v0 = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::router::swap_exact_coin_x_for_coin_y<T1, T2, T3>(arg2, arg3, 0, arg4);
        0xdc15721baa82ba64822d585a7349a1508f76d94ae80e899b06e48369c257750e::swap_cap::update_path_metadata<T0, T2>(&arg0.id, arg1, 0x2::coin::value<T2>(&v0));
        v0
    }

    public fun swap_exact_coin_y_for_coin_x<T0, T1, T2, T3>(arg0: &mut BaySwapRouterWrapper, arg1: &mut 0xdc15721baa82ba64822d585a7349a1508f76d94ae80e899b06e48369c257750e::swap_cap::RouterSwapCap<T0>, arg2: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg3: 0x2::coin::Coin<T2>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xdc15721baa82ba64822d585a7349a1508f76d94ae80e899b06e48369c257750e::swap_cap::assert_valid_swap<T0, T2>(arg1, &arg3);
        let v0 = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::router::swap_exact_coin_y_for_coin_x<T1, T2, T3>(arg2, arg3, 0, arg4);
        0xdc15721baa82ba64822d585a7349a1508f76d94ae80e899b06e48369c257750e::swap_cap::update_path_metadata<T0, T1>(&arg0.id, arg1, 0x2::coin::value<T1>(&v0));
        v0
    }

    public fun authorize(arg0: &0xdc15721baa82ba64822d585a7349a1508f76d94ae80e899b06e48369c257750e::admin::AdminCap, arg1: &mut BaySwapRouterWrapper) {
        0xdc15721baa82ba64822d585a7349a1508f76d94ae80e899b06e48369c257750e::admin::authorize(arg0, &mut arg1.id);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BaySwapRouterWrapper{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<BaySwapRouterWrapper>(v0);
    }

    public fun revoke_auth(arg0: &0xdc15721baa82ba64822d585a7349a1508f76d94ae80e899b06e48369c257750e::admin::AdminCap, arg1: &mut BaySwapRouterWrapper) {
        0xdc15721baa82ba64822d585a7349a1508f76d94ae80e899b06e48369c257750e::admin::revoke_auth(arg0, &mut arg1.id);
    }

    // decompiled from Move bytecode v6
}

