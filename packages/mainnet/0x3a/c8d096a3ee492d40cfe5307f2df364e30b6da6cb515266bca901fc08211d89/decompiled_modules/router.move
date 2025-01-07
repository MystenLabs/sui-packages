module 0x3ac8d096a3ee492d40cfe5307f2df364e30b6da6cb515266bca901fc08211d89::router {
    struct AftermathRouterWrapper has store, key {
        id: 0x2::object::UID,
    }

    public fun add_swap_exact_in_to_route<T0, T1, T2, T3>(arg0: &mut AftermathRouterWrapper, arg1: &mut 0xdc15721baa82ba64822d585a7349a1508f76d94ae80e899b06e48369c257750e::swap_cap::RouterSwapCap<T0>, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg3: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T1>, arg4: 0x2::coin::Coin<T2>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        0xdc15721baa82ba64822d585a7349a1508f76d94ae80e899b06e48369c257750e::swap_cap::assert_valid_swap<T0, T2>(arg1, &mut arg4);
        let v0 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::add_swap_exact_in_to_route<T0, T1, T2, T3>(&arg0.id, arg2, arg3, arg4, arg5, arg6);
        0xdc15721baa82ba64822d585a7349a1508f76d94ae80e899b06e48369c257750e::swap_cap::update_path_metadata<T0, T3>(&arg0.id, arg1, 0x2::coin::value<T3>(&v0));
        v0
    }

    public fun add_swap_exact_out_to_route<T0, T1, T2, T3>(arg0: &mut AftermathRouterWrapper, arg1: &mut 0xdc15721baa82ba64822d585a7349a1508f76d94ae80e899b06e48369c257750e::swap_cap::RouterSwapCap<T0>, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg3: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T1>, arg4: u64, arg5: &mut 0x2::coin::Coin<T2>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        0xdc15721baa82ba64822d585a7349a1508f76d94ae80e899b06e48369c257750e::swap_cap::assert_valid_swap<T0, T2>(arg1, arg5);
        let v0 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::add_swap_exact_out_to_route<T0, T1, T2, T3>(&arg0.id, arg2, arg3, arg4, arg5, arg6, arg7);
        0xdc15721baa82ba64822d585a7349a1508f76d94ae80e899b06e48369c257750e::swap_cap::update_path_metadata<T0, T3>(&arg0.id, arg1, 0x2::coin::value<T3>(&v0));
        v0
    }

    public fun authorize(arg0: &0xdc15721baa82ba64822d585a7349a1508f76d94ae80e899b06e48369c257750e::admin::AdminCap, arg1: &mut AftermathRouterWrapper) {
        0xdc15721baa82ba64822d585a7349a1508f76d94ae80e899b06e48369c257750e::admin::authorize(arg0, &mut arg1.id);
    }

    public fun authorize_amm(arg0: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::admin::AdminCap, arg1: &mut AftermathRouterWrapper) {
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::admin::authorize(arg0, &mut arg1.id);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AftermathRouterWrapper{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<AftermathRouterWrapper>(v0);
    }

    public fun revoke_auth(arg0: &0xdc15721baa82ba64822d585a7349a1508f76d94ae80e899b06e48369c257750e::admin::AdminCap, arg1: &mut AftermathRouterWrapper) {
        0xdc15721baa82ba64822d585a7349a1508f76d94ae80e899b06e48369c257750e::admin::revoke_auth(arg0, &mut arg1.id);
    }

    public fun revoke_auth_amm(arg0: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::admin::AdminCap, arg1: &mut AftermathRouterWrapper) {
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::admin::revoke_auth(arg0, &mut arg1.id);
    }

    // decompiled from Move bytecode v6
}

