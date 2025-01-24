module 0xade068789561f806ff9b909025789a298a5e4c3d71211eaec2c757814437c40a::user {
    struct RedeemRewardsEvent has copy, drop {
        user: address,
        reward_pool_id: 0x2::object::ID,
        protocol_type: u64,
        rewards: u64,
        timestamp: u64,
    }

    struct ClaimedRewardsEvent has copy, drop {
        user: address,
        reward_pool_id: 0x2::object::ID,
        protocol_type: u64,
        rewards: u64,
    }

    public fun query_claimed<T0>(arg0: &0xade068789561f806ff9b909025789a298a5e4c3d71211eaec2c757814437c40a::rewards_pool::RewardsPool<T0>, arg1: address, arg2: u64) : u64 {
        let v0 = 0xade068789561f806ff9b909025789a298a5e4c3d71211eaec2c757814437c40a::rewards_pool::query_claimed<T0>(arg0, arg1, arg2);
        let v1 = ClaimedRewardsEvent{
            user           : arg1,
            reward_pool_id : 0x2::object::id<0xade068789561f806ff9b909025789a298a5e4c3d71211eaec2c757814437c40a::rewards_pool::RewardsPool<T0>>(arg0),
            protocol_type  : arg2,
            rewards        : v0,
        };
        0x2::event::emit<ClaimedRewardsEvent>(v1);
        v0
    }

    public entry fun redeem_rewards<T0>(arg0: &mut 0xade068789561f806ff9b909025789a298a5e4c3d71211eaec2c757814437c40a::rewards_pool::RewardsPool<T0>, arg1: vector<u8>, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xade068789561f806ff9b909025789a298a5e4c3d71211eaec2c757814437c40a::rewards_pool::redeem_rewards<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = RedeemRewardsEvent{
            user           : arg2,
            reward_pool_id : 0x2::object::id<0xade068789561f806ff9b909025789a298a5e4c3d71211eaec2c757814437c40a::rewards_pool::RewardsPool<T0>>(arg0),
            protocol_type  : arg5,
            rewards        : 0x2::coin::value<T0>(&v0),
            timestamp      : 0x2::clock::timestamp_ms(arg6) / 1000,
        };
        0x2::event::emit<RedeemRewardsEvent>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg2);
    }

    // decompiled from Move bytecode v6
}

