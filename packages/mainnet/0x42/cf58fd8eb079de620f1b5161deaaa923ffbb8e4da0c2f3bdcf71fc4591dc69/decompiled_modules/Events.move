module 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::Events {
    struct StakeEvent<phantom T0> has copy, drop {
        staker: address,
        token_id: 0x1::option::Option<0x2::object::ID>,
        amount: u64,
        lock_end_time: u64,
        veheadal_amount: u64,
        token_type: 0x1::type_name::TypeName,
        is_decaying: bool,
        lock_weeks: u64,
    }

    struct UnstakeEvent<phantom T0> has copy, drop {
        staker: address,
        token_id: 0x2::object::ID,
        amount: u64,
        token_type: 0x1::type_name::TypeName,
    }

    struct StakeAddedEvent<phantom T0> has copy, drop {
        staker: address,
        token_id: 0x2::object::ID,
        additional_amount: u64,
        new_veheadal_amount: u64,
        token_type: 0x1::type_name::TypeName,
    }

    struct ExtendLockEvent<phantom T0> has copy, drop {
        staker: address,
        token_id: 0x2::object::ID,
        lock_end_time: u64,
        new_veheadal_amount: u64,
        additional_weeks: u64,
        token_type: 0x1::type_name::TypeName,
    }

    struct ClaimUnstakedEvent<phantom T0> has copy, drop {
        staker: address,
        amount: u64,
        token_type: 0x1::type_name::TypeName,
        token_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct UserDecayStartedEvent<phantom T0> has copy, drop {
        staker: address,
        token_id: 0x2::object::ID,
        decay_weeks: u64,
        new_veheadal_amount: u64,
        token_type: 0x1::type_name::TypeName,
    }

    struct UserDecayStoppedEvent<phantom T0> has copy, drop {
        staker: address,
        token_id: 0x2::object::ID,
        lock_weeks: u64,
        new_veheadal_amount: u64,
        token_type: 0x1::type_name::TypeName,
    }

    public fun emit_claim_unstaked_event<T0>(arg0: address, arg1: u64, arg2: 0x1::option::Option<0x2::object::ID>) {
        let v0 = ClaimUnstakedEvent<T0>{
            staker     : arg0,
            amount     : arg1,
            token_type : 0x1::type_name::get<T0>(),
            token_id   : arg2,
        };
        0x2::event::emit<ClaimUnstakedEvent<T0>>(v0);
    }

    public fun emit_extend_lock_event<T0>(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = ExtendLockEvent<T0>{
            staker              : arg0,
            token_id            : arg1,
            lock_end_time       : arg2,
            new_veheadal_amount : arg3,
            additional_weeks    : arg4,
            token_type          : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<ExtendLockEvent<T0>>(v0);
    }

    public fun emit_stake_added_event<T0>(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = StakeAddedEvent<T0>{
            staker              : arg0,
            token_id            : arg1,
            additional_amount   : arg2,
            new_veheadal_amount : arg3,
            token_type          : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<StakeAddedEvent<T0>>(v0);
    }

    public fun emit_stake_event<T0>(arg0: address, arg1: 0x1::option::Option<0x2::object::ID>, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: u64) {
        let v0 = StakeEvent<T0>{
            staker          : arg0,
            token_id        : arg1,
            amount          : arg2,
            lock_end_time   : arg3,
            veheadal_amount : arg4,
            token_type      : 0x1::type_name::get<T0>(),
            is_decaying     : arg5,
            lock_weeks      : arg6,
        };
        0x2::event::emit<StakeEvent<T0>>(v0);
    }

    public fun emit_unstake_event<T0>(arg0: address, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = UnstakeEvent<T0>{
            staker     : arg0,
            token_id   : arg1,
            amount     : arg2,
            token_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<UnstakeEvent<T0>>(v0);
    }

    public fun emit_user_decay_started_event<T0>(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = UserDecayStartedEvent<T0>{
            staker              : arg0,
            token_id            : arg1,
            decay_weeks         : arg2,
            new_veheadal_amount : arg3,
            token_type          : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<UserDecayStartedEvent<T0>>(v0);
    }

    public fun emit_user_decay_stopped_event<T0>(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = UserDecayStoppedEvent<T0>{
            staker              : arg0,
            token_id            : arg1,
            lock_weeks          : arg2,
            new_veheadal_amount : arg3,
            token_type          : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<UserDecayStoppedEvent<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

