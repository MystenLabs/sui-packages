module 0xdcbbb5d2b8431c63784c6a6e3d96fe45fbcbf5e5b9f471627c3a4093a14f3a2c::router {
    struct AftermathRouterWrapper has store, key {
        id: 0x2::object::UID,
    }

    public fun authorize(arg0: &0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::admin::AdminCap, arg1: &mut AftermathRouterWrapper) {
        0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::admin::authorize(arg0, &mut arg1.id);
    }

    public fun revoke_auth(arg0: &0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::admin::AdminCap, arg1: &mut AftermathRouterWrapper) {
        0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::admin::revoke_auth(arg0, &mut arg1.id);
    }

    public fun add_swap_exact_in_to_route<T0, T1, T2, T3>(arg0: &mut AftermathRouterWrapper, arg1: &mut 0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::swap_cap::RouterSwapCap<T0>, arg2: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg3: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T1>, arg4: 0x2::coin::Coin<T2>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::swap_cap::assert_valid_swap<T0, T2>(arg1, &mut arg4);
        let v0 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::swap::add_swap_exact_in_to_route<T0, T1, T2, T3>(&arg0.id, arg2, arg3, arg4, arg5, arg6);
        0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::swap_cap::update_path_metadata<T0, T3>(&arg0.id, arg1, 0x2::coin::value<T3>(&v0));
        v0
    }

    public fun add_swap_exact_out_to_route<T0, T1, T2, T3>(arg0: &mut AftermathRouterWrapper, arg1: &mut 0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::swap_cap::RouterSwapCap<T0>, arg2: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg3: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T1>, arg4: u64, arg5: &mut 0x2::coin::Coin<T2>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::swap_cap::assert_valid_swap<T0, T2>(arg1, arg5);
        let v0 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::swap::add_swap_exact_out_to_route<T0, T1, T2, T3>(&arg0.id, arg2, arg3, arg4, arg5, arg6, arg7);
        0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::swap_cap::update_path_metadata<T0, T3>(&arg0.id, arg1, 0x2::coin::value<T3>(&v0));
        v0
    }

    public fun authorize_amm(arg0: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::admin::AdminCap, arg1: &mut AftermathRouterWrapper) {
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::admin::authorize(arg0, &mut arg1.id);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AftermathRouterWrapper{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<AftermathRouterWrapper>(v0);
    }

    public fun revoke_auth_amm(arg0: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::admin::AdminCap, arg1: &mut AftermathRouterWrapper) {
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::admin::revoke_auth(arg0, &mut arg1.id);
    }

    // decompiled from Move bytecode v6
}

