module 0xdd6a7371b43f9822efb45e4ddd6c92908f384ef003ae90ddb3002e5a59aa30a9::router {
    struct AftermathRouterWrapper has store, key {
        id: 0x2::object::UID,
    }

    public fun authorize(arg0: &0xe16daff2fcdfff4075ec5a87eb33e5836368817a50c2d76f0b9b9fc5ffe0a55f::admin::AdminCap, arg1: &mut AftermathRouterWrapper) {
        0xe16daff2fcdfff4075ec5a87eb33e5836368817a50c2d76f0b9b9fc5ffe0a55f::admin::authorize(arg0, &mut arg1.id);
    }

    public fun revoke_auth(arg0: &0xe16daff2fcdfff4075ec5a87eb33e5836368817a50c2d76f0b9b9fc5ffe0a55f::admin::AdminCap, arg1: &mut AftermathRouterWrapper) {
        0xe16daff2fcdfff4075ec5a87eb33e5836368817a50c2d76f0b9b9fc5ffe0a55f::admin::revoke_auth(arg0, &mut arg1.id);
    }

    public fun add_swap_exact_in_to_route<T0, T1, T2, T3>(arg0: &mut AftermathRouterWrapper, arg1: &mut 0xe16daff2fcdfff4075ec5a87eb33e5836368817a50c2d76f0b9b9fc5ffe0a55f::swap_cap::RouterSwapCap<T0>, arg2: &0x2328394b747206cf1111a020ae0eb6cf68fc33cb9ca435183d9c950c6c08a8ab::pool_registry::PoolRegistry, arg3: &mut 0x2328394b747206cf1111a020ae0eb6cf68fc33cb9ca435183d9c950c6c08a8ab::pool::Pool<T1>, arg4: 0x2::coin::Coin<T2>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        0xe16daff2fcdfff4075ec5a87eb33e5836368817a50c2d76f0b9b9fc5ffe0a55f::swap_cap::assert_valid_swap<T0, T2>(arg1, &mut arg4);
        let v0 = 0x2328394b747206cf1111a020ae0eb6cf68fc33cb9ca435183d9c950c6c08a8ab::swap::add_swap_exact_in_to_route<T0, T1, T2, T3>(&arg0.id, arg2, arg3, arg4, arg5, arg6);
        0xe16daff2fcdfff4075ec5a87eb33e5836368817a50c2d76f0b9b9fc5ffe0a55f::swap_cap::update_path_metadata<T0, T3>(&arg0.id, arg1, 0x2::coin::value<T3>(&v0));
        v0
    }

    public fun add_swap_exact_out_to_route<T0, T1, T2, T3>(arg0: &mut AftermathRouterWrapper, arg1: &mut 0xe16daff2fcdfff4075ec5a87eb33e5836368817a50c2d76f0b9b9fc5ffe0a55f::swap_cap::RouterSwapCap<T0>, arg2: &0x2328394b747206cf1111a020ae0eb6cf68fc33cb9ca435183d9c950c6c08a8ab::pool_registry::PoolRegistry, arg3: &mut 0x2328394b747206cf1111a020ae0eb6cf68fc33cb9ca435183d9c950c6c08a8ab::pool::Pool<T1>, arg4: u64, arg5: &mut 0x2::coin::Coin<T2>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        0xe16daff2fcdfff4075ec5a87eb33e5836368817a50c2d76f0b9b9fc5ffe0a55f::swap_cap::assert_valid_swap<T0, T2>(arg1, arg5);
        let v0 = 0x2328394b747206cf1111a020ae0eb6cf68fc33cb9ca435183d9c950c6c08a8ab::swap::add_swap_exact_out_to_route<T0, T1, T2, T3>(&arg0.id, arg2, arg3, arg4, arg5, arg6, arg7);
        0xe16daff2fcdfff4075ec5a87eb33e5836368817a50c2d76f0b9b9fc5ffe0a55f::swap_cap::update_path_metadata<T0, T3>(&arg0.id, arg1, 0x2::coin::value<T3>(&v0));
        v0
    }

    public fun authorize_amm(arg0: &0x2328394b747206cf1111a020ae0eb6cf68fc33cb9ca435183d9c950c6c08a8ab::admin::AdminCap, arg1: &mut AftermathRouterWrapper) {
        0x2328394b747206cf1111a020ae0eb6cf68fc33cb9ca435183d9c950c6c08a8ab::admin::authorize(arg0, &mut arg1.id);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AftermathRouterWrapper{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<AftermathRouterWrapper>(v0);
    }

    public fun revoke_auth_amm(arg0: &0x2328394b747206cf1111a020ae0eb6cf68fc33cb9ca435183d9c950c6c08a8ab::admin::AdminCap, arg1: &mut AftermathRouterWrapper) {
        0x2328394b747206cf1111a020ae0eb6cf68fc33cb9ca435183d9c950c6c08a8ab::admin::revoke_auth(arg0, &mut arg1.id);
    }

    // decompiled from Move bytecode v6
}

