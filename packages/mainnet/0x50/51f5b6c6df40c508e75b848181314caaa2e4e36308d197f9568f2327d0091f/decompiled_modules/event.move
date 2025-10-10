module 0x87c13bb9157c3d51d61c7802704539d9d4782e838aadc41df0d6f0cc117298ba::event {
    struct InitializeEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
        acl_control_id: 0x2::object::ID,
    }

    struct CreatePoolEvent<phantom T0, phantom T1> has copy, drop {
        id: 0x2::object::ID,
        start_time: u64,
        end_time: u64,
        lock_duration: u64,
    }

    struct SetEnabledEvent<phantom T0, phantom T1> has copy, drop {
        enabled: bool,
    }

    struct SetStartTimeEvent<phantom T0, phantom T1> has copy, drop {
        start_time: u64,
    }

    struct SetEndTimeEvent<phantom T0, phantom T1> has copy, drop {
        end_time: u64,
    }

    struct SetLockDurationEvent<phantom T0, phantom T1> has copy, drop {
        lock_duration: u64,
    }

    struct SetRewardRateEvent<phantom T0, phantom T1> has copy, drop {
        reward_rate: u128,
        end_time: u64,
    }

    struct AddRewardEvent<phantom T0, phantom T1> has copy, drop {
        reward_amount: u64,
    }

    struct DepositEvent<phantom T0, phantom T1> has copy, drop {
        user: address,
        deposit_amount: u64,
        lock_until: u64,
    }

    struct WithdrawEvent<phantom T0, phantom T1> has copy, drop {
        user: address,
        withdraw_amount: u64,
        reward_amount: u64,
    }

    struct ClaimRewardEvent<phantom T0, phantom T1> has copy, drop {
        user: address,
        reward_amount: u64,
    }

    struct ClearCredentialEvent<phantom T0, phantom T1> has copy, drop {
        user: address,
    }

    struct ForceWithdrawEvent<phantom T0, phantom T1> has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct PoolVersionUpdated<phantom T0, phantom T1> has copy, drop {
        old_version: u64,
        new_version: u64,
    }

    public(friend) fun add_reward<T0, T1>(arg0: u64) {
        let v0 = AddRewardEvent<T0, T1>{reward_amount: arg0};
        0x2::event::emit<AddRewardEvent<T0, T1>>(v0);
    }

    public(friend) fun claim_reward<T0, T1>(arg0: address, arg1: u64) {
        let v0 = ClaimRewardEvent<T0, T1>{
            user          : arg0,
            reward_amount : arg1,
        };
        0x2::event::emit<ClaimRewardEvent<T0, T1>>(v0);
    }

    public(friend) fun clear_credential<T0, T1>(arg0: address) {
        let v0 = ClearCredentialEvent<T0, T1>{user: arg0};
        0x2::event::emit<ClearCredentialEvent<T0, T1>>(v0);
    }

    public(friend) fun create_pool<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = CreatePoolEvent<T0, T1>{
            id            : arg0,
            start_time    : arg1,
            end_time      : arg2,
            lock_duration : arg3,
        };
        0x2::event::emit<CreatePoolEvent<T0, T1>>(v0);
    }

    public(friend) fun deposit<T0, T1>(arg0: address, arg1: u64, arg2: u64) {
        let v0 = DepositEvent<T0, T1>{
            user           : arg0,
            deposit_amount : arg1,
            lock_until     : arg2,
        };
        0x2::event::emit<DepositEvent<T0, T1>>(v0);
    }

    public(friend) fun force_withdraw<T0, T1>(arg0: u64, arg1: address) {
        let v0 = ForceWithdrawEvent<T0, T1>{
            amount    : arg0,
            recipient : arg1,
        };
        0x2::event::emit<ForceWithdrawEvent<T0, T1>>(v0);
    }

    public(friend) fun initialize(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = InitializeEvent{
            admin_cap_id   : arg0,
            acl_control_id : arg1,
        };
        0x2::event::emit<InitializeEvent>(v0);
    }

    public(friend) fun pool_version_updated<T0, T1>(arg0: u64, arg1: u64) {
        let v0 = PoolVersionUpdated<T0, T1>{
            old_version : arg0,
            new_version : arg1,
        };
        0x2::event::emit<PoolVersionUpdated<T0, T1>>(v0);
    }

    public(friend) fun set_enabled<T0, T1>(arg0: bool) {
        let v0 = SetEnabledEvent<T0, T1>{enabled: arg0};
        0x2::event::emit<SetEnabledEvent<T0, T1>>(v0);
    }

    public(friend) fun set_end_time<T0, T1>(arg0: u64) {
        let v0 = SetEndTimeEvent<T0, T1>{end_time: arg0};
        0x2::event::emit<SetEndTimeEvent<T0, T1>>(v0);
    }

    public(friend) fun set_lock_duration<T0, T1>(arg0: u64) {
        let v0 = SetLockDurationEvent<T0, T1>{lock_duration: arg0};
        0x2::event::emit<SetLockDurationEvent<T0, T1>>(v0);
    }

    public(friend) fun set_reward_rate<T0, T1>(arg0: u128, arg1: u64) {
        let v0 = SetRewardRateEvent<T0, T1>{
            reward_rate : arg0,
            end_time    : arg1,
        };
        0x2::event::emit<SetRewardRateEvent<T0, T1>>(v0);
    }

    public(friend) fun set_start_time<T0, T1>(arg0: u64) {
        let v0 = SetStartTimeEvent<T0, T1>{start_time: arg0};
        0x2::event::emit<SetStartTimeEvent<T0, T1>>(v0);
    }

    public(friend) fun withdraw<T0, T1>(arg0: address, arg1: u64, arg2: u64) {
        let v0 = WithdrawEvent<T0, T1>{
            user            : arg0,
            withdraw_amount : arg1,
            reward_amount   : arg2,
        };
        0x2::event::emit<WithdrawEvent<T0, T1>>(v0);
    }

    // decompiled from Move bytecode v6
}

