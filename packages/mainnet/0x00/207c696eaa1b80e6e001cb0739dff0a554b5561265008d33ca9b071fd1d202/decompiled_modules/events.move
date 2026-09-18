module 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::events {
    struct LogLendingStateCreated has copy, drop {
        state: 0x2::object::ID,
        underlying: 0x1::type_name::TypeName,
    }

    struct LogDeposit has copy, drop {
        token: 0x1::type_name::TypeName,
        sender: address,
        assets: u64,
        shares_minted: u64,
    }

    struct LogWithdraw has copy, drop {
        token: 0x1::type_name::TypeName,
        sender: address,
        assets: u64,
        shares_burned: u64,
    }

    struct LogUpdateRates has copy, drop {
        token: 0x1::type_name::TypeName,
        token_exchange_price: u64,
        liquidity_exchange_price: u64,
    }

    struct LogRebalance has copy, drop {
        token: 0x1::type_name::TypeName,
        assets: u64,
    }

    struct LogAddAdmin has copy, drop {
        addr: address,
    }

    struct LogRemoveAdmin has copy, drop {
        addr: address,
    }

    struct LogRoleChange has copy, drop {
        role: 0x1::type_name::TypeName,
        owner: address,
        granted: bool,
    }

    struct LogSetRewardsSchedule has copy, drop {
        token: 0x1::type_name::TypeName,
        start_tvl: u64,
        start_s: u64,
        end_s: u64,
        yearly_reward: u64,
        next_start_s: u64,
        next_end_s: u64,
        next_yearly_reward: u64,
    }

    struct LogClearRewards has copy, drop {
        token: 0x1::type_name::TypeName,
    }

    struct LogSetRewardsWriter has copy, drop {
        token: 0x1::type_name::TypeName,
        cap_id: 0x1::option::Option<0x2::object::ID>,
    }

    public(friend) fun emit_log_add_admin(arg0: address) {
        0x2::event::emit<LogAddAdmin>(new_log_add_admin(arg0));
    }

    public(friend) fun emit_log_clear_rewards(arg0: 0x1::type_name::TypeName) {
        0x2::event::emit<LogClearRewards>(new_log_clear_rewards(arg0));
    }

    public(friend) fun emit_log_deposit(arg0: 0x1::type_name::TypeName, arg1: address, arg2: u64, arg3: u64) {
        0x2::event::emit<LogDeposit>(new_log_deposit(arg0, arg1, arg2, arg3));
    }

    public(friend) fun emit_log_lending_state_created(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName) {
        0x2::event::emit<LogLendingStateCreated>(new_log_lending_state_created(arg0, arg1));
    }

    public(friend) fun emit_log_rebalance(arg0: 0x1::type_name::TypeName, arg1: u64) {
        0x2::event::emit<LogRebalance>(new_log_rebalance(arg0, arg1));
    }

    public(friend) fun emit_log_remove_admin(arg0: address) {
        0x2::event::emit<LogRemoveAdmin>(new_log_remove_admin(arg0));
    }

    public(friend) fun emit_log_role_change(arg0: 0x1::type_name::TypeName, arg1: address, arg2: bool) {
        0x2::event::emit<LogRoleChange>(new_log_role_change(arg0, arg1, arg2));
    }

    public(friend) fun emit_log_set_rewards_schedule(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::TimestampS, arg3: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::TimestampS, arg4: u64, arg5: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::TimestampS, arg6: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::TimestampS, arg7: u64) {
        0x2::event::emit<LogSetRewardsSchedule>(new_log_set_rewards_schedule(arg0, arg1, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::raw_ts(arg2), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::raw_ts(arg3), arg4, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::raw_ts(arg5), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::raw_ts(arg6), arg7));
    }

    public(friend) fun emit_log_set_rewards_writer(arg0: 0x1::type_name::TypeName, arg1: 0x1::option::Option<0x2::object::ID>) {
        0x2::event::emit<LogSetRewardsWriter>(new_log_set_rewards_writer(arg0, arg1));
    }

    public(friend) fun emit_log_update_rates(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: u64) {
        0x2::event::emit<LogUpdateRates>(new_log_update_rates(arg0, arg1, arg2));
    }

    public(friend) fun emit_log_withdraw(arg0: 0x1::type_name::TypeName, arg1: address, arg2: u64, arg3: u64) {
        0x2::event::emit<LogWithdraw>(new_log_withdraw(arg0, arg1, arg2, arg3));
    }

    public(friend) fun new_log_add_admin(arg0: address) : LogAddAdmin {
        LogAddAdmin{addr: arg0}
    }

    public(friend) fun new_log_clear_rewards(arg0: 0x1::type_name::TypeName) : LogClearRewards {
        LogClearRewards{token: arg0}
    }

    public(friend) fun new_log_deposit(arg0: 0x1::type_name::TypeName, arg1: address, arg2: u64, arg3: u64) : LogDeposit {
        LogDeposit{
            token         : arg0,
            sender        : arg1,
            assets        : arg2,
            shares_minted : arg3,
        }
    }

    public(friend) fun new_log_lending_state_created(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName) : LogLendingStateCreated {
        LogLendingStateCreated{
            state      : arg0,
            underlying : arg1,
        }
    }

    public(friend) fun new_log_rebalance(arg0: 0x1::type_name::TypeName, arg1: u64) : LogRebalance {
        LogRebalance{
            token  : arg0,
            assets : arg1,
        }
    }

    public(friend) fun new_log_remove_admin(arg0: address) : LogRemoveAdmin {
        LogRemoveAdmin{addr: arg0}
    }

    public(friend) fun new_log_role_change(arg0: 0x1::type_name::TypeName, arg1: address, arg2: bool) : LogRoleChange {
        LogRoleChange{
            role    : arg0,
            owner   : arg1,
            granted : arg2,
        }
    }

    public(friend) fun new_log_set_rewards_schedule(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : LogSetRewardsSchedule {
        LogSetRewardsSchedule{
            token              : arg0,
            start_tvl          : arg1,
            start_s            : arg2,
            end_s              : arg3,
            yearly_reward      : arg4,
            next_start_s       : arg5,
            next_end_s         : arg6,
            next_yearly_reward : arg7,
        }
    }

    public(friend) fun new_log_set_rewards_writer(arg0: 0x1::type_name::TypeName, arg1: 0x1::option::Option<0x2::object::ID>) : LogSetRewardsWriter {
        LogSetRewardsWriter{
            token  : arg0,
            cap_id : arg1,
        }
    }

    public(friend) fun new_log_update_rates(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: u64) : LogUpdateRates {
        LogUpdateRates{
            token                    : arg0,
            token_exchange_price     : arg1,
            liquidity_exchange_price : arg2,
        }
    }

    public(friend) fun new_log_withdraw(arg0: 0x1::type_name::TypeName, arg1: address, arg2: u64, arg3: u64) : LogWithdraw {
        LogWithdraw{
            token         : arg0,
            sender        : arg1,
            assets        : arg2,
            shares_burned : arg3,
        }
    }

    // decompiled from Move bytecode v7
}

