module 0x2a3beb3c89759988ac1ae0ca3b06837ea7ac263fe82aae50c8a9c1e855224f08::router {
    struct SuiswapRouterWrapper has store, key {
        id: 0x2::object::UID,
    }

    public fun authorize(arg0: &0xdc15721baa82ba64822d585a7349a1508f76d94ae80e899b06e48369c257750e::admin::AdminCap, arg1: &mut SuiswapRouterWrapper) {
        0xdc15721baa82ba64822d585a7349a1508f76d94ae80e899b06e48369c257750e::admin::authorize(arg0, &mut arg1.id);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SuiswapRouterWrapper{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<SuiswapRouterWrapper>(v0);
    }

    public fun revoke_auth(arg0: &0xdc15721baa82ba64822d585a7349a1508f76d94ae80e899b06e48369c257750e::admin::AdminCap, arg1: &mut SuiswapRouterWrapper) {
        0xdc15721baa82ba64822d585a7349a1508f76d94ae80e899b06e48369c257750e::admin::revoke_auth(arg0, &mut arg1.id);
    }

    public fun swap_x_to_y<T0, T1, T2>(arg0: &mut SuiswapRouterWrapper, arg1: &mut 0xdc15721baa82ba64822d585a7349a1508f76d94ae80e899b06e48369c257750e::swap_cap::RouterSwapCap<T0>, arg2: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T1, T2>, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xdc15721baa82ba64822d585a7349a1508f76d94ae80e899b06e48369c257750e::swap_cap::assert_valid_swap<T0, T1>(arg1, &arg3);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v0, arg3);
        let (v1, v2) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_x_to_y_direct<T1, T2>(arg2, v0, 0x2::coin::value<T1>(&arg3), arg4, arg5);
        let v3 = v2;
        transfer_if_nonzero<T1>(v1, 0x2::tx_context::sender(arg5));
        0xdc15721baa82ba64822d585a7349a1508f76d94ae80e899b06e48369c257750e::swap_cap::update_path_metadata<T0, T2>(&arg0.id, arg1, 0x2::coin::value<T2>(&v3));
        v3
    }

    public fun swap_y_to_x<T0, T1, T2>(arg0: &mut SuiswapRouterWrapper, arg1: &mut 0xdc15721baa82ba64822d585a7349a1508f76d94ae80e899b06e48369c257750e::swap_cap::RouterSwapCap<T0>, arg2: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T1, T2>, arg3: 0x2::coin::Coin<T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xdc15721baa82ba64822d585a7349a1508f76d94ae80e899b06e48369c257750e::swap_cap::assert_valid_swap<T0, T2>(arg1, &arg3);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T2>>();
        0x1::vector::push_back<0x2::coin::Coin<T2>>(&mut v0, arg3);
        let (v1, v2) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_y_to_x_direct<T1, T2>(arg2, v0, 0x2::coin::value<T2>(&arg3), arg4, arg5);
        let v3 = v2;
        transfer_if_nonzero<T2>(v1, 0x2::tx_context::sender(arg5));
        0xdc15721baa82ba64822d585a7349a1508f76d94ae80e899b06e48369c257750e::swap_cap::update_path_metadata<T0, T1>(&arg0.id, arg1, 0x2::coin::value<T1>(&v3));
        v3
    }

    fun transfer_if_nonzero<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        };
    }

    // decompiled from Move bytecode v6
}

