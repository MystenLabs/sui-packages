module 0x8c93751ded4275f3ffc5d5bebcd587ba08f630551d55ca09f5045fd5fc8252e0::events {
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
        pool_id: 0x2::object::ID,
    }

    struct UnstakeEventV1 has copy, drop {
        owner: address,
        amount: u64,
        pool_id: 0x2::object::ID,
    }

    struct DepositRewardEventV1 has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct ClaimRewardEventV1 has copy, drop {
        owner: address,
        amount: u64,
        pool_id: 0x2::object::ID,
    }

    struct ForfeitsSweptEventV1 has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        drip_end_ms: u64,
    }

    struct ParchRewardClaimedEventV1 has copy, drop {
        owner: address,
        amount: u64,
        pool_id: 0x2::object::ID,
    }

    struct BindReferrerEventV1 has copy, drop {
        referee: address,
        referrer: address,
    }

    struct ReferralBonusAccruedEventV1 has copy, drop {
        referee: address,
        referrer: address,
        level: u8,
        reward: u64,
        amount: u64,
    }

    struct ReferralBonusFundedEventV1 has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        owed_total: u64,
        reserve: u64,
    }

    struct ReferralBonusClaimedEventV1 has copy, drop {
        referrer: address,
        amount: u64,
        still_owed: u64,
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

    public(friend) fun emit_claim_reward_event(arg0: address, arg1: u64, arg2: 0x2::object::ID) {
        let v0 = ClaimRewardEventV1{
            owner   : arg0,
            amount  : arg1,
            pool_id : arg2,
        };
        emit<ClaimRewardEventV1>(v0);
    }

    public(friend) fun emit_deposit_reward_event(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = DepositRewardEventV1{
            pool_id : arg0,
            amount  : arg1,
        };
        emit<DepositRewardEventV1>(v0);
    }

    public(friend) fun emit_forfeits_swept_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = ForfeitsSweptEventV1{
            pool_id     : arg0,
            amount      : arg1,
            drip_end_ms : arg2,
        };
        emit<ForfeitsSweptEventV1>(v0);
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

    public(friend) fun emit_parch_reward_claimed_event(arg0: address, arg1: u64, arg2: 0x2::object::ID) {
        let v0 = ParchRewardClaimedEventV1{
            owner   : arg0,
            amount  : arg1,
            pool_id : arg2,
        };
        emit<ParchRewardClaimedEventV1>(v0);
    }

    public(friend) fun emit_referral_bonus_accrued_event(arg0: address, arg1: address, arg2: u8, arg3: u64, arg4: u64) {
        let v0 = ReferralBonusAccruedEventV1{
            referee  : arg0,
            referrer : arg1,
            level    : arg2,
            reward   : arg3,
            amount   : arg4,
        };
        emit<ReferralBonusAccruedEventV1>(v0);
    }

    public(friend) fun emit_referral_bonus_claimed_event(arg0: address, arg1: u64, arg2: u64) {
        let v0 = ReferralBonusClaimedEventV1{
            referrer   : arg0,
            amount     : arg1,
            still_owed : arg2,
        };
        emit<ReferralBonusClaimedEventV1>(v0);
    }

    public(friend) fun emit_referral_bonus_funded_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = ReferralBonusFundedEventV1{
            pool_id    : arg0,
            amount     : arg1,
            owed_total : arg2,
            reserve    : arg3,
        };
        emit<ReferralBonusFundedEventV1>(v0);
    }

    public(friend) fun emit_reward_stream_updated_event(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = RewardStreamUpdatedEventV1{
            pool_id          : arg0,
            reward_stream_ms : arg1,
        };
        emit<RewardStreamUpdatedEventV1>(v0);
    }

    public(friend) fun emit_stake_event(arg0: address, arg1: u64, arg2: 0x2::object::ID) {
        let v0 = StakeEventV1{
            owner   : arg0,
            amount  : arg1,
            pool_id : arg2,
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

    public(friend) fun emit_unstake_event(arg0: address, arg1: u64, arg2: 0x2::object::ID) {
        let v0 = UnstakeEventV1{
            owner   : arg0,
            amount  : arg1,
            pool_id : arg2,
        };
        emit<UnstakeEventV1>(v0);
    }

    public fun inner<T0: copy + drop>(arg0: Event<T0>) : T0 {
        let Event { pos0: v0 } = arg0;
        v0
    }

    // decompiled from Move bytecode v7
}

