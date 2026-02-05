module 0xa1a93a27bc169d6977b610b99e9ffc1d6547c593758d409244cc54e4be0bf7d::fee_config {
    struct FeeConfig has store {
        stake_fee_bps: u64,
        unstake_fee_bps: u64,
        reward_fee_bps: u64,
        unstake_fee_redistribution_bps: u64,
        extra_fields: 0x2::bag::Bag,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : FeeConfig {
        FeeConfig{
            stake_fee_bps                  : 0,
            unstake_fee_bps                : 0,
            reward_fee_bps                 : 0,
            unstake_fee_redistribution_bps : 0,
            extra_fields                   : 0x2::bag::new(arg0),
        }
    }

    public(friend) fun calculate_reward_fee(arg0: &FeeConfig, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg2 > arg1) {
            ((arg2 - arg1) as u128) * (reward_fee_bps(arg0) as u128) / 10000
        } else {
            0
        };
        (v0 as u64)
    }

    public(friend) fun calculate_stake_fee(arg0: &FeeConfig, arg1: u64) : u64 {
        if (arg0.stake_fee_bps == 0) {
            return 0
        };
        ((((arg0.stake_fee_bps as u128) * (arg1 as u128) + 9999) / 10000) as u64)
    }

    public(friend) fun calculate_unstake_fee(arg0: &FeeConfig, arg1: u64) : u64 {
        if (arg0.unstake_fee_bps == 0) {
            return 0
        };
        ((((arg1 as u128) * (arg0.unstake_fee_bps as u128) + 9999) / 10000) as u64)
    }

    public(friend) fun calculate_unstake_fee_redistribution(arg0: &FeeConfig, arg1: u64) : u64 {
        if (arg0.unstake_fee_redistribution_bps == 0) {
            return 0
        };
        ((((arg1 as u128) * (arg0.unstake_fee_redistribution_bps as u128) + 9999) / 10000) as u64)
    }

    public fun reward_fee_bps(arg0: &FeeConfig) : u64 {
        arg0.reward_fee_bps
    }

    public(friend) fun set_reward_fee_bps(arg0: &mut FeeConfig, arg1: u64) {
        arg0.reward_fee_bps = arg1;
        validate_fees(arg0);
    }

    public(friend) fun set_stake_fee_bps(arg0: &mut FeeConfig, arg1: u64) {
        arg0.stake_fee_bps = arg1;
        validate_fees(arg0);
    }

    public(friend) fun set_unstake_fee_bps(arg0: &mut FeeConfig, arg1: u64) {
        arg0.unstake_fee_bps = arg1;
        validate_fees(arg0);
    }

    public(friend) fun set_unstake_fee_redistribution_bps(arg0: &mut FeeConfig, arg1: u64) {
        arg0.unstake_fee_redistribution_bps = arg1;
        validate_fees(arg0);
    }

    public fun stake_fee_bps(arg0: &FeeConfig) : u64 {
        arg0.stake_fee_bps
    }

    public fun unstake_fee_bps(arg0: &FeeConfig) : u64 {
        arg0.unstake_fee_bps
    }

    public fun unstake_fee_redistribution_bps(arg0: &FeeConfig) : u64 {
        arg0.unstake_fee_redistribution_bps
    }

    public fun validate_fees(arg0: &FeeConfig) {
        assert!(arg0.stake_fee_bps <= 500, 20001);
        assert!(arg0.unstake_fee_bps <= 500, 20001);
        assert!(arg0.reward_fee_bps <= 10000, 20001);
        assert!(arg0.unstake_fee_redistribution_bps <= 10000, 20001);
    }

    // decompiled from Move bytecode v6
}

