module 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::config {
    struct StakingConfig has store {
        deposit_fee: u64,
        reward_fee: u64,
        validator_reward_fee: u64,
        service_fee: u64,
        withdraw_time_limit: u64,
        validator_count: u64,
    }

    struct StakingConfigCreated has copy, drop {
        deposit_fee: u64,
        reward_fee: u64,
        validator_reward_fee: u64,
        service_fee: u64,
        withdraw_time_limit: u64,
        validator_count: u64,
    }

    struct StakingFeeConfigUpdated has copy, drop {
        name: vector<u8>,
        old: u64,
        new: u64,
    }

    public fun get_deposit_fee(arg0: &StakingConfig) : u64 {
        arg0.deposit_fee
    }

    public fun get_reward_fee(arg0: &StakingConfig) : u64 {
        arg0.reward_fee
    }

    public fun get_service_fee(arg0: &StakingConfig) : u64 {
        arg0.service_fee
    }

    public fun get_validator_count(arg0: &StakingConfig) : u64 {
        arg0.validator_count
    }

    public fun get_validator_reward_fee(arg0: &StakingConfig) : u64 {
        arg0.validator_reward_fee
    }

    public fun get_withdraw_time_limit(arg0: &StakingConfig) : u64 {
        arg0.withdraw_time_limit
    }

    public(friend) fun new(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : StakingConfig {
        new_event(arg0, arg1, arg2, arg3, arg4, arg5);
        StakingConfig{
            deposit_fee          : arg0,
            reward_fee           : arg1,
            validator_reward_fee : arg2,
            service_fee          : arg3,
            withdraw_time_limit  : arg4,
            validator_count      : arg5,
        }
    }

    fun new_event(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = StakingConfigCreated{
            deposit_fee          : arg0,
            reward_fee           : arg1,
            validator_reward_fee : arg2,
            service_fee          : arg3,
            withdraw_time_limit  : arg4,
            validator_count      : arg5,
        };
        0x2::event::emit<StakingConfigCreated>(v0);
    }

    public(friend) fun set_deposit_fee(arg0: &mut StakingConfig, arg1: u64) {
        assert!(arg0.deposit_fee != arg1, 1);
        assert!(arg1 <= 1000, 2);
        let v0 = StakingFeeConfigUpdated{
            name : b"DepositFeeUpdated",
            old  : arg0.deposit_fee,
            new  : arg1,
        };
        0x2::event::emit<StakingFeeConfigUpdated>(v0);
        arg0.deposit_fee = arg1;
    }

    public(friend) fun set_reward_fee(arg0: &mut StakingConfig, arg1: u64) {
        assert!(arg0.reward_fee != arg1, 1);
        assert!(arg1 <= 1000, 2);
        let v0 = StakingFeeConfigUpdated{
            name : b"RewardFeeUpdated",
            old  : arg0.reward_fee,
            new  : arg1,
        };
        0x2::event::emit<StakingFeeConfigUpdated>(v0);
        arg0.reward_fee = arg1;
    }

    public(friend) fun set_service_fee(arg0: &mut StakingConfig, arg1: u64) {
        assert!(arg0.service_fee != arg1, 1);
        assert!(arg1 <= 1000, 2);
        let v0 = StakingFeeConfigUpdated{
            name : b"ServiceFeeUpdated",
            old  : arg0.service_fee,
            new  : arg1,
        };
        0x2::event::emit<StakingFeeConfigUpdated>(v0);
        arg0.service_fee = arg1;
    }

    public(friend) fun set_validator_count(arg0: &mut StakingConfig, arg1: u64) {
        assert!(arg1 > 0 && arg0.validator_count != arg1, 1);
        let v0 = StakingFeeConfigUpdated{
            name : b"ValidatorCountUpdated",
            old  : arg0.validator_count,
            new  : arg1,
        };
        0x2::event::emit<StakingFeeConfigUpdated>(v0);
        arg0.validator_count = arg1;
    }

    public(friend) fun set_validator_reward_fee(arg0: &mut StakingConfig, arg1: u64) {
        assert!(arg0.validator_reward_fee != arg1, 1);
        let v0 = StakingFeeConfigUpdated{
            name : b"ValidatorRewardFeeUpdated",
            old  : arg0.validator_reward_fee,
            new  : arg1,
        };
        0x2::event::emit<StakingFeeConfigUpdated>(v0);
        arg0.validator_reward_fee = arg1;
    }

    public(friend) fun set_withdraw_time_limit(arg0: &mut StakingConfig, arg1: u64) {
        assert!(arg0.withdraw_time_limit != arg1, 1);
        let v0 = StakingFeeConfigUpdated{
            name : b"WithdrawTimeLimitUpdated",
            old  : arg0.withdraw_time_limit,
            new  : arg1,
        };
        0x2::event::emit<StakingFeeConfigUpdated>(v0);
        arg0.withdraw_time_limit = arg1;
    }

    // decompiled from Move bytecode v6
}

