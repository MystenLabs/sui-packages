module 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::liquidity_mining {
    struct RewardClaimedEvent has copy, drop {
        who: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        reward_coin_type: 0x1::type_name::TypeName,
        reward_amount: u64,
        time: u64,
    }

    public fun claim_reward<T0, T1, T2>(arg0: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::ProtocolApp, arg1: &mut 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::Market<T0>, arg2: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::obligation::ObligationOwnerCap, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = claim_reward_as_coin<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, 0x2::tx_context::sender(arg6));
    }

    public fun claim_reward_as_coin<T0, T1, T2>(arg0: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::ProtocolApp, arg1: &mut 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::Market<T0>, arg2: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::obligation::ObligationOwnerCap, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::validate_market<T0>(arg0, arg1);
        0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::ensure_version_matches(arg0);
        assert!(!0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::has_circuit_break_triggered<T0>(arg1), 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::error::market_under_circuit_break());
        let v0 = 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::liquidity_miner::claim_rewards<T0, T1, T2>(0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::borrow_liquidity_mining_mut<T0>(arg1), arg3, 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::obligation::id(arg2), arg5, arg4);
        let v1 = RewardClaimedEvent{
            who              : 0x2::tx_context::sender(arg6),
            market           : 0x1::type_name::with_defining_ids<T0>(),
            obligation       : 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::obligation::id(arg2),
            coin_type        : 0x1::type_name::with_defining_ids<T1>(),
            reward_coin_type : 0x1::type_name::with_defining_ids<T2>(),
            reward_amount    : 0x2::balance::value<T2>(&v0),
            time             : 0x2::clock::timestamp_ms(arg5) / 1000,
        };
        0x2::event::emit<RewardClaimedEvent>(v1);
        0x2::coin::from_balance<T2>(v0, arg6)
    }

    // decompiled from Move bytecode v6
}

