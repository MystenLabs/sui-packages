module 0xb5ae50815be057c549bbaf4383842d6a0d9cac29b4e253a78bfaddf462468c5c::router {
    struct InterestProtocolRouterWrapper has store, key {
        id: 0x2::object::UID,
    }

    public fun swap_token_x<T0, T1, T2>(arg0: &mut InterestProtocolRouterWrapper, arg1: &mut 0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::swap_cap::RouterSwapCap<T0>, arg2: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::swap_cap::assert_valid_swap<T0, T1>(arg1, &arg4);
        let v0 = 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::router::swap_token_x<T1, T2>(arg2, arg3, arg4, 0, arg5);
        0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::swap_cap::update_path_metadata<T0, T2>(&arg0.id, arg1, 0x2::coin::value<T2>(&v0));
        v0
    }

    public fun swap_token_y<T0, T1, T2>(arg0: &mut InterestProtocolRouterWrapper, arg1: &mut 0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::swap_cap::RouterSwapCap<T0>, arg2: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T2>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::swap_cap::assert_valid_swap<T0, T2>(arg1, &arg4);
        let v0 = 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::router::swap_token_y<T1, T2>(arg2, arg3, arg4, 0, arg5);
        0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::swap_cap::update_path_metadata<T0, T1>(&arg0.id, arg1, 0x2::coin::value<T1>(&v0));
        v0
    }

    public fun authorize(arg0: &0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::admin::AdminCap, arg1: &mut InterestProtocolRouterWrapper) {
        0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::admin::authorize(arg0, &mut arg1.id);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = InterestProtocolRouterWrapper{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<InterestProtocolRouterWrapper>(v0);
    }

    public fun revoke_auth(arg0: &0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::admin::AdminCap, arg1: &mut InterestProtocolRouterWrapper) {
        0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::admin::revoke_auth(arg0, &mut arg1.id);
    }

    // decompiled from Move bytecode v6
}

