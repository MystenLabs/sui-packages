module 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::events {
    struct Deposit has copy, drop {
        depositor: address,
        amount: u64,
        shares_issued: u64,
        deposit_queue_previous: u64,
        deposit_queue_current: u64,
    }

    struct Withdraw has copy, drop {
        depositor: address,
        amount: u64,
        new_total_staked: u64,
        shares_burned: u64,
    }

    struct PoolUpdate has copy, drop {
        previous_epoch: u64,
        previous_activatd_sui: u64,
        current_epoch: u64,
        current_activated_sui: u64,
        total_rewards: u64,
    }

    struct ValidatorStaked has copy, drop {
        validator: address,
        amount: u64,
        validator_staked: u64,
        total_staked: u64,
    }

    struct Upgraded has copy, drop {
        previous_version: u64,
        new_version: u64,
    }

    struct ValidatorProtocolFeesClaimed has copy, drop {
        validator: address,
        sui_claimed: u64,
    }

    struct ProtocolFeesClaimed has copy, drop {
        sui_claimed: u64,
        new_total_staked: u64,
    }

    struct SuiRemoved has copy, drop {
        validator: address,
        epoch: u64,
        amount: u64,
        previous_total_staked: u64,
        current_total_staked: u64,
    }

    struct ExcessUnstake has copy, drop {
        total_unstaked: u64,
        sui_to_remove: u64,
        excess: u64,
    }

    struct ValidatorRewardsUpdated has copy, drop {
        previous_total_rewards: u64,
        new_total_rewards: u64,
    }

    public(friend) fun emit_deposit(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = Deposit{
            depositor              : arg0,
            amount                 : arg1,
            shares_issued          : arg2,
            deposit_queue_previous : arg3,
            deposit_queue_current  : arg4,
        };
        0x2::event::emit<Deposit>(v0);
    }

    public(friend) fun emit_excess_unstake(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = ExcessUnstake{
            total_unstaked : arg0,
            sui_to_remove  : arg1,
            excess         : arg2,
        };
        0x2::event::emit<ExcessUnstake>(v0);
    }

    public(friend) fun emit_pool_update(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = PoolUpdate{
            previous_epoch        : arg0,
            previous_activatd_sui : arg1,
            current_epoch         : arg2,
            current_activated_sui : arg3,
            total_rewards         : arg4,
        };
        0x2::event::emit<PoolUpdate>(v0);
    }

    public(friend) fun emit_protocol_fees_claimed(arg0: u64, arg1: u64) {
        let v0 = ProtocolFeesClaimed{
            sui_claimed      : arg0,
            new_total_staked : arg1,
        };
        0x2::event::emit<ProtocolFeesClaimed>(v0);
    }

    public(friend) fun emit_sui_removed(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = SuiRemoved{
            validator             : arg0,
            epoch                 : arg1,
            amount                : arg2,
            previous_total_staked : arg3,
            current_total_staked  : arg4,
        };
        0x2::event::emit<SuiRemoved>(v0);
    }

    public(friend) fun emit_upgraded(arg0: u64, arg1: u64) {
        let v0 = Upgraded{
            previous_version : arg0,
            new_version      : arg1,
        };
        0x2::event::emit<Upgraded>(v0);
    }

    public(friend) fun emit_validator_protocol_fees_claimed(arg0: address, arg1: u64) {
        let v0 = ValidatorProtocolFeesClaimed{
            validator   : arg0,
            sui_claimed : arg1,
        };
        0x2::event::emit<ValidatorProtocolFeesClaimed>(v0);
    }

    public(friend) fun emit_validator_rewards_updated(arg0: u64, arg1: u64) {
        let v0 = ValidatorRewardsUpdated{
            previous_total_rewards : arg0,
            new_total_rewards      : arg1,
        };
        0x2::event::emit<ValidatorRewardsUpdated>(v0);
    }

    public(friend) fun emit_validator_staked(arg0: address, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = ValidatorStaked{
            validator        : arg0,
            amount           : arg1,
            validator_staked : arg2,
            total_staked     : arg3,
        };
        0x2::event::emit<ValidatorStaked>(v0);
    }

    public(friend) fun emit_withdraw(arg0: address, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = Withdraw{
            depositor        : arg0,
            amount           : arg1,
            new_total_staked : arg2,
            shares_burned    : arg3,
        };
        0x2::event::emit<Withdraw>(v0);
    }

    // decompiled from Move bytecode v6
}

