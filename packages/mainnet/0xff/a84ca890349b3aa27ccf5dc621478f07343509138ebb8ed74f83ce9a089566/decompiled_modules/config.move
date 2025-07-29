module 0xffa84ca890349b3aa27ccf5dc621478f07343509138ebb8ed74f83ce9a089566::config {
    struct StakingConfig has store {
        deposit_fee: u64,
        reward_fee: u64,
        validator_reward_fee: u64,
        service_fee: u64,
        withdraw_time_limit: u64,
        validator_count: u64,
        walrus_start_epoch: u32,
        walrus_start_timestamp_ms: u64,
        walrus_epoch_duration: u64,
    }

    struct StakingConfigCreated has copy, drop {
        deposit_fee: u64,
        reward_fee: u64,
        validator_reward_fee: u64,
        service_fee: u64,
        withdraw_time_limit: u64,
        validator_count: u64,
        walrus_start_epoch: u32,
        walrus_start_timestamp_ms: u64,
        walrus_epoch_duration: u64,
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

    public fun get_walrus_epoch_duration(arg0: &StakingConfig) : u64 {
        arg0.walrus_epoch_duration
    }

    public fun get_walrus_start_epoch(arg0: &StakingConfig) : u32 {
        arg0.walrus_start_epoch
    }

    public fun get_walrus_start_timestamp_ms(arg0: &StakingConfig) : u64 {
        arg0.walrus_start_timestamp_ms
    }

    public fun get_withdraw_time_limit(arg0: &StakingConfig) : u64 {
        arg0.withdraw_time_limit
    }

    public(friend) fun new(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u32, arg7: u64, arg8: u64) : StakingConfig {
        new_event(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        StakingConfig{
            deposit_fee               : arg0,
            reward_fee                : arg1,
            validator_reward_fee      : arg2,
            service_fee               : arg3,
            withdraw_time_limit       : arg4,
            validator_count           : arg5,
            walrus_start_epoch        : arg6,
            walrus_start_timestamp_ms : arg7,
            walrus_epoch_duration     : arg8,
        }
    }

    fun new_event(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u32, arg7: u64, arg8: u64) {
        let v0 = StakingConfigCreated{
            deposit_fee               : arg0,
            reward_fee                : arg1,
            validator_reward_fee      : arg2,
            service_fee               : arg3,
            withdraw_time_limit       : arg4,
            validator_count           : arg5,
            walrus_start_epoch        : arg6,
            walrus_start_timestamp_ms : arg7,
            walrus_epoch_duration     : arg8,
        };
        0x2::event::emit<StakingConfigCreated>(v0);
    }

    public(friend) fun set_deposit_fee(arg0: &mut StakingConfig, arg1: u64) {
        assert!(arg0.deposit_fee != arg1, 1);
        assert!(arg1 <= 10000000, 2);
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
        assert!(arg1 <= 10000000, 2);
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
        assert!(arg1 <= 10000000, 2);
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

    public(friend) fun set_walrus_epoch_start(arg0: &mut StakingConfig, arg1: u32, arg2: u64, arg3: u64) {
        assert!(arg0.walrus_start_epoch != arg1, 1);
        assert!(arg0.walrus_start_timestamp_ms <= arg2, 1);
        let v0 = StakingFeeConfigUpdated{
            name : b"WalrusEpochEtartUpdated",
            old  : (arg0.walrus_start_epoch as u64),
            new  : (arg1 as u64),
        };
        0x2::event::emit<StakingFeeConfigUpdated>(v0);
        let v1 = StakingFeeConfigUpdated{
            name : b"WalrusEpochEtartConfigUpdated",
            old  : arg0.walrus_start_timestamp_ms,
            new  : arg2,
        };
        0x2::event::emit<StakingFeeConfigUpdated>(v1);
        let v2 = StakingFeeConfigUpdated{
            name : b"WalrusEpochDurationUpdated",
            old  : arg0.walrus_epoch_duration,
            new  : arg3,
        };
        0x2::event::emit<StakingFeeConfigUpdated>(v2);
        arg0.walrus_start_epoch = arg1;
        arg0.walrus_start_timestamp_ms = arg2;
        arg0.walrus_epoch_duration = arg3;
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

