module 0xfc23a1193552af26453ae8426c3f51638a03827bbe094d89a619f1d78d98eef9::router {
    struct BaySwapRouterWrapper has store, key {
        id: 0x2::object::UID,
    }

    public fun swap_exact_coin_x_for_coin_y<T0, T1, T2, T3>(arg0: &mut BaySwapRouterWrapper, arg1: &mut 0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::swap_cap::RouterSwapCap<T0>, arg2: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::swap_cap::assert_valid_swap<T0, T1>(arg1, &arg3);
        let v0 = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::router::swap_exact_coin_x_for_coin_y<T1, T2, T3>(arg2, arg3, 0, arg4);
        0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::swap_cap::update_path_metadata<T0, T2>(&arg0.id, arg1, 0x2::coin::value<T2>(&v0));
        v0
    }

    public fun swap_exact_coin_y_for_coin_x<T0, T1, T2, T3>(arg0: &mut BaySwapRouterWrapper, arg1: &mut 0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::swap_cap::RouterSwapCap<T0>, arg2: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg3: 0x2::coin::Coin<T2>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::swap_cap::assert_valid_swap<T0, T2>(arg1, &arg3);
        let v0 = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::router::swap_exact_coin_y_for_coin_x<T1, T2, T3>(arg2, arg3, 0, arg4);
        0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::swap_cap::update_path_metadata<T0, T1>(&arg0.id, arg1, 0x2::coin::value<T1>(&v0));
        v0
    }

    public fun authorize(arg0: &0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::admin::AdminCap, arg1: &mut BaySwapRouterWrapper) {
        0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::admin::authorize(arg0, &mut arg1.id);
    }

    public fun revoke_auth(arg0: &0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::admin::AdminCap, arg1: &mut BaySwapRouterWrapper) {
        0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::admin::revoke_auth(arg0, &mut arg1.id);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BaySwapRouterWrapper{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<BaySwapRouterWrapper>(v0);
    }

    // decompiled from Move bytecode v6
}

