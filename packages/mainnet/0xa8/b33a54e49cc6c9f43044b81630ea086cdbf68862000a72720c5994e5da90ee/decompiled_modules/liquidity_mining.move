module 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::liquidity_mining {
    struct RewardClaimedEvent has copy, drop {
        who: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        reward_coin_type: 0x1::type_name::TypeName,
        reward_amount: u64,
        time: u64,
    }

    public fun claim_reward<T0, T1, T2>(arg0: &mut 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::Market<T0>, arg1: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::ObligationOwnerCap, arg2: u8, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::ensure_version_matches<T0>(arg0);
        let v0 = claim_reward_as_coin<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun claim_reward_as_coin<T0, T1, T2>(arg0: &mut 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::Market<T0>, arg1: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::ObligationOwnerCap, arg2: u8, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::ensure_version_matches<T0>(arg0);
        assert!(!0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::has_circuit_break_triggered<T0>(arg0), 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::error::market_under_circuit_break());
        let v0 = 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::liquidity_miner::claim_rewards<T0, T1, T2>(0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::borrow_liquidity_mining_mut<T0>(arg0), arg2, 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::id(arg1), arg4, arg3);
        let v1 = RewardClaimedEvent{
            who              : 0x2::tx_context::sender(arg5),
            market           : 0x1::type_name::get<T0>(),
            obligation       : 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::obligation::id(arg1),
            coin_type        : 0x1::type_name::get<T1>(),
            reward_coin_type : 0x1::type_name::get<T2>(),
            reward_amount    : 0x2::balance::value<T2>(&v0),
            time             : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        0x2::event::emit<RewardClaimedEvent>(v1);
        0x2::coin::from_balance<T2>(v0, arg5)
    }

    // decompiled from Move bytecode v6
}

