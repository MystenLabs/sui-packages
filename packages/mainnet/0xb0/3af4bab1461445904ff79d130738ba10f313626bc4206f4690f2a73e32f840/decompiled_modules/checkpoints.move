module 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::checkpoints {
    struct RewardPerTokenCheckpoint has store {
        timestamp: u64,
        reward_per_token: u256,
    }

    struct SupplyCheckpoint has store {
        timestamp: u64,
        supply: u64,
    }

    struct BalanceCheckpoint has store {
        timestamp: u64,
        balance: u64,
    }

    public fun balance(arg0: &BalanceCheckpoint) : u64 {
        arg0.balance
    }

    public fun balance_ts(arg0: &BalanceCheckpoint) : u64 {
        arg0.timestamp
    }

    public fun new_cp(arg0: u64, arg1: u64) : BalanceCheckpoint {
        BalanceCheckpoint{
            timestamp : arg0,
            balance   : arg1,
        }
    }

    public fun new_rp(arg0: u64, arg1: u256) : RewardPerTokenCheckpoint {
        RewardPerTokenCheckpoint{
            timestamp        : arg0,
            reward_per_token : arg1,
        }
    }

    public fun new_sp(arg0: u64, arg1: u64) : SupplyCheckpoint {
        SupplyCheckpoint{
            timestamp : arg0,
            supply    : arg1,
        }
    }

    public fun reward(arg0: &RewardPerTokenCheckpoint) : u256 {
        arg0.reward_per_token
    }

    public fun reward_ts(arg0: &RewardPerTokenCheckpoint) : u64 {
        arg0.timestamp
    }

    public fun supply(arg0: &SupplyCheckpoint) : u64 {
        arg0.supply
    }

    public fun supply_ts(arg0: &SupplyCheckpoint) : u64 {
        arg0.timestamp
    }

    public fun update_balance(arg0: &mut BalanceCheckpoint, arg1: u64) {
        arg0.balance = arg1;
    }

    public fun update_reward(arg0: &mut RewardPerTokenCheckpoint, arg1: u256) {
        arg0.reward_per_token = arg1;
    }

    public fun update_supply(arg0: &mut SupplyCheckpoint, arg1: u64) {
        arg0.supply = arg1;
    }

    // decompiled from Move bytecode v6
}

