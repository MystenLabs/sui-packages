module 0x4dea4916aa61f522aca69c4e7265b8e3bdd65d3947f4fb9aaa6d87e0dfac35fd::fees {
    struct FeeConfig has store {
        stake_fee_bps: u64,
        unstake_fee_bps: u64,
    }

    struct StakeFeeRateUpdated has copy, drop {
        previous_stake_fee_bps: u64,
        new_stake_fee_bps: u64,
    }

    struct UnstakeFeeRateUpdated has copy, drop {
        previous_unstake_fee_bps: u64,
        new_unstake_fee_bps: u64,
    }

    fun calculate_fee(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0) {
            0
        } else {
            ((((arg1 as u256) * (arg0 as u256) + 9999) / 10000) as u64)
        }
    }

    fun calculate_fee_floor(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0) {
            0
        } else {
            (((arg1 as u256) * (arg0 as u256) / 10000) as u64)
        }
    }

    public fun calculate_stake_fee(arg0: &FeeConfig, arg1: u64) : u64 {
        calculate_fee(arg0.stake_fee_bps, arg1)
    }

    public fun calculate_unstake_fee(arg0: &FeeConfig, arg1: u64) : u64 {
        calculate_fee_floor(arg0.unstake_fee_bps, arg1)
    }

    public fun get_stake_fee_bps(arg0: &FeeConfig) : u64 {
        arg0.stake_fee_bps
    }

    public fun get_unstake_fee_bps(arg0: &FeeConfig) : u64 {
        arg0.unstake_fee_bps
    }

    public(friend) fun new(arg0: u64, arg1: u64) : FeeConfig {
        assert!(arg0 <= 10000, 0);
        assert!(arg1 <= 10000, 0);
        FeeConfig{
            stake_fee_bps   : arg0,
            unstake_fee_bps : arg1,
        }
    }

    public(friend) fun set_stake_fee_bps(arg0: &mut FeeConfig, arg1: u64) {
        assert!(arg1 <= 10000, 0);
        arg0.stake_fee_bps = arg1;
        let v0 = StakeFeeRateUpdated{
            previous_stake_fee_bps : arg0.stake_fee_bps,
            new_stake_fee_bps      : arg1,
        };
        0x2::event::emit<StakeFeeRateUpdated>(v0);
    }

    public(friend) fun set_unstake_fee_bps(arg0: &mut FeeConfig, arg1: u64) {
        assert!(arg1 <= 10000, 0);
        arg0.unstake_fee_bps = arg1;
        let v0 = UnstakeFeeRateUpdated{
            previous_unstake_fee_bps : arg0.unstake_fee_bps,
            new_unstake_fee_bps      : arg1,
        };
        0x2::event::emit<UnstakeFeeRateUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

