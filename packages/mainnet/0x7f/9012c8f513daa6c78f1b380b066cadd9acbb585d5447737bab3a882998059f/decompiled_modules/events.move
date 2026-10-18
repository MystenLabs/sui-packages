module 0x7f9012c8f513daa6c78f1b380b066cadd9acbb585d5447737bab3a882998059f::events {
    struct Event<T0: copy + drop> has copy, drop {
        pos0: T0,
    }

    struct MintEventV1 has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
        basis: u64,
        minted: u64,
    }

    struct StakeEventV1 has copy, drop {
        owner: address,
        amount: u64,
    }

    struct UnstakeEventV1 has copy, drop {
        owner: address,
        amount: u64,
    }

    struct DepositRewardEventV1 has copy, drop {
        amount: u64,
    }

    struct ClaimRewardEventV1 has copy, drop {
        owner: address,
        amount: u64,
    }

    struct BindReferrerEventV1 has copy, drop {
        referee: address,
        referrer: address,
    }

    struct StakingPoolCreatedEventV1 has copy, drop {
        config_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
    }

    struct StakingAdminActionEventV1 has copy, drop {
        config_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        action: u8,
    }

    struct RewardStreamUpdatedEventV1 has copy, drop {
        pool_id: 0x2::object::ID,
        reward_stream_ms: u64,
    }

    struct MinStakeLockUpdatedEventV1 has copy, drop {
        pool_id: 0x2::object::ID,
        min_stake_lock_ms: u64,
    }

    fun emit<T0: copy + drop>(arg0: T0) {
        let v0 = Event<T0>{pos0: arg0};
        0x2::event::emit<Event<T0>>(v0);
    }

    public(friend) fun emit_bind_referrer_event(arg0: address, arg1: address) {
        let v0 = BindReferrerEventV1{
            referee  : arg0,
            referrer : arg1,
        };
        emit<BindReferrerEventV1>(v0);
    }

    public(friend) fun emit_claim_reward_event(arg0: address, arg1: u64) {
        let v0 = ClaimRewardEventV1{
            owner  : arg0,
            amount : arg1,
        };
        emit<ClaimRewardEventV1>(v0);
    }

    public(friend) fun emit_deposit_reward_event(arg0: u64) {
        let v0 = DepositRewardEventV1{amount: arg0};
        emit<DepositRewardEventV1>(v0);
    }

    public(friend) fun emit_min_stake_lock_updated_event(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = MinStakeLockUpdatedEventV1{
            pool_id           : arg0,
            min_stake_lock_ms : arg1,
        };
        emit<MinStakeLockUpdatedEventV1>(v0);
    }

    public(friend) fun emit_mint_event(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = MintEventV1{
            account_id : arg0,
            owner      : arg1,
            basis      : arg2,
            minted     : arg3,
        };
        emit<MintEventV1>(v0);
    }

    public(friend) fun emit_reward_stream_updated_event(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = RewardStreamUpdatedEventV1{
            pool_id          : arg0,
            reward_stream_ms : arg1,
        };
        emit<RewardStreamUpdatedEventV1>(v0);
    }

    public(friend) fun emit_stake_event(arg0: address, arg1: u64) {
        let v0 = StakeEventV1{
            owner  : arg0,
            amount : arg1,
        };
        emit<StakeEventV1>(v0);
    }

    public(friend) fun emit_staking_admin_action_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u8) {
        let v0 = StakingAdminActionEventV1{
            config_id : arg0,
            pool_id   : arg1,
            action    : arg2,
        };
        emit<StakingAdminActionEventV1>(v0);
    }

    public(friend) fun emit_staking_pool_created_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = StakingPoolCreatedEventV1{
            config_id : arg0,
            pool_id   : arg1,
        };
        emit<StakingPoolCreatedEventV1>(v0);
    }

    public(friend) fun emit_unstake_event(arg0: address, arg1: u64) {
        let v0 = UnstakeEventV1{
            owner  : arg0,
            amount : arg1,
        };
        emit<UnstakeEventV1>(v0);
    }

    public fun inner<T0: copy + drop>(arg0: Event<T0>) : T0 {
        let Event { pos0: v0 } = arg0;
        v0
    }

    // decompiled from Move bytecode v7
}

