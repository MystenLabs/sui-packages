module 0x6e8f83d8df825fb51f893bb041824a54f116a371db48188aca2e9b32cb85cb6e::events {
    struct RewardPoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        controller: address,
    }

    struct RewardPoolFunded has copy, drop {
        pool_id: 0x2::object::ID,
        depositor: address,
        amount: u64,
        pool_balance: u64,
    }

    struct RewardsClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        claimer: address,
        receiver: address,
        amount: u64,
        nonce: u128,
    }

    struct RewardsControllerUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        previous_controller: address,
        new_controller: address,
    }

    struct NonceMarkedAsClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        nonce: u128,
    }

    struct RewardsPoolFundsWithdrawn has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        pool_balance: u64,
        destination: address,
    }

    public(friend) fun emit_nonce_marked_as_claimed_event(arg0: 0x2::object::ID, arg1: u128) {
        let v0 = NonceMarkedAsClaimed{
            pool_id : arg0,
            nonce   : arg1,
        };
        0x2::event::emit<NonceMarkedAsClaimed>(v0);
    }

    public(friend) fun emit_reward_amount_deposited_event(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = RewardPoolFunded{
            pool_id      : arg0,
            depositor    : arg1,
            amount       : arg2,
            pool_balance : arg3,
        };
        0x2::event::emit<RewardPoolFunded>(v0);
    }

    public(friend) fun emit_reward_pool_created_event(arg0: 0x2::object::ID, arg1: address) {
        let v0 = RewardPoolCreated{
            pool_id    : arg0,
            controller : arg1,
        };
        0x2::event::emit<RewardPoolCreated>(v0);
    }

    public(friend) fun emit_rewards_claimed_event(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: u128) {
        let v0 = RewardsClaimed{
            pool_id  : arg0,
            claimer  : arg1,
            receiver : arg2,
            amount   : arg3,
            nonce    : arg4,
        };
        0x2::event::emit<RewardsClaimed>(v0);
    }

    public(friend) fun emit_rewards_controller_updated_event(arg0: 0x2::object::ID, arg1: address, arg2: address) {
        let v0 = RewardsControllerUpdated{
            pool_id             : arg0,
            previous_controller : arg1,
            new_controller      : arg2,
        };
        0x2::event::emit<RewardsControllerUpdated>(v0);
    }

    public(friend) fun emit_rewards_pool_funds_withdrawn_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: address) {
        let v0 = RewardsPoolFundsWithdrawn{
            pool_id      : arg0,
            amount       : arg1,
            pool_balance : arg2,
            destination  : arg3,
        };
        0x2::event::emit<RewardsPoolFundsWithdrawn>(v0);
    }

    // decompiled from Move bytecode v6
}

